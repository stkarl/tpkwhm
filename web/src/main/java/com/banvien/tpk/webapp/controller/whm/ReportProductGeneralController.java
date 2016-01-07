package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Size;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.ProductGeneralBean;
import com.banvien.tpk.core.dto.ProductInOutDTO;
import com.banvien.tpk.core.service.ImportproductService;
import com.banvien.tpk.core.service.ProductnameService;
import com.banvien.tpk.core.service.WarehouseService;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import jxl.Workbook;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.*;
import jxl.write.Number;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.lang.Boolean;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ReportProductGeneralController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ImportproductService importProductService;

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private ProductnameService productnameService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/productgeneral.html"})
    public ModelAndView list(ProductGeneralBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/productgeneral");
        try {
            bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
            bean.setReportSummaryProduction(Boolean.TRUE);
            bean.setMaxPageItems(Integer.MAX_VALUE);
            if(bean.getToDate() != null){
                bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
            }else{
                bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(System.currentTimeMillis())));
            }

            if(bean.getFromDate() == null){
                bean.setFromDate(new Timestamp(System.currentTimeMillis()));
            }

            if(bean.getCrudaction() != null && "report".equals(bean.getCrudaction())){
                List<ProductInOutDTO> results = this.importProductService.summaryProductInOut(bean);
                mav.addObject("results", results);
            }

            if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
                List<ProductInOutDTO> results = this.importProductService.summaryProductInOut(bean);
                mav.addObject("results", results);
                exportInOutProduct2Excel(bean, results, request, response);
            }
            addData2ModelProduct(mav);
        } catch (Exception e) {
            log.error(e.getMessage(),e);
        }
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void addData2ModelProduct(ModelAndView mav){
        List<Warehouse> warehouses = new ArrayList<Warehouse>();
        if(SecurityUtils.getPrincipal().getWarehouseID()!=null){
            Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
            warehouses.add(warehouse);
        }else{
            warehouses = this.warehouseService.findByStatus(Constants.TPK_USER_ACTIVE);
        }
        mav.addObject("warehouses", warehouses);
        mav.addObject("productNames", this.productnameService.findAll());
    }


    private void exportInOutProduct2Excel(ProductGeneralBean bean, List<ProductInOutDTO> results, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/NhapXuatTonTon_" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/NhapXuatTonTon.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);

            WritableSheet sheet = workbook.getSheet(0);

            WritableFont normalFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);
            WritableCellFormat normalFormat = new WritableCellFormat(normalFont);
            normalFormat.setAlignment(Alignment.CENTRE);
            normalFormat.setWrap(true);
            normalFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            int startRow = 2;

            Long key;

            for(ProductInOutDTO result : results){
                int stt = 1;
                startRow = buildHeaderInOutProductionReport(sheet,startRow,result,bean);
                Integer initRoll = 0,
                        inRoll = 0,
                        outRoll = 0;
                Double initMet = 0d,
                        initKg = 0d,
                        inMet = 0d,
                        inKg = 0d,
                        outMet = 0d,
                        outKg = 0d;
                for(Size size : result.getSizes()){
                    key = size.getSizeID();
                    Integer rInitRoll = 0,
                            rInRoll = 0,
                            rOutRoll = 0;
                    Double rInitMet = 0d,
                            rInitKg = 0d,
                            rInMet = 0d,
                            rInKg = 0d,
                            rOutMet = 0d,
                            rOutKg = 0d;
                    if (result.getMapInitSizeProducts().get(key) != null){
                        rInitRoll = result.getMapInitSizeProducts().get(key).getNoRoll();
                        rInitMet = result.getMapInitSizeProducts().get(key).getMet();
                        rInitKg = result.getMapInitSizeProducts().get(key).getKg();

                        initRoll += rInitRoll;
                        initMet += rInitMet;
                        initKg += rInitKg;
                    }
                    if (result.getMapInSizeProducts().get(key) != null){
                        rInRoll = result.getMapInSizeProducts().get(key).getNoRoll();
                        rInMet = result.getMapInSizeProducts().get(key).getMet();
                        rInKg = result.getMapInSizeProducts().get(key).getKg();

                        inRoll += rInRoll;
                        inMet += rInMet;
                        inKg += rInKg;
                    }

                    if (result.getMapOutSizeProducts().get(key) != null){
                        rOutRoll = result.getMapOutSizeProducts().get(key).getNoRoll();
                        rOutMet = result.getMapOutSizeProducts().get(key).getMet();
                        rOutKg = result.getMapOutSizeProducts().get(key).getKg();

                        outRoll += rOutRoll;
                        outMet += rOutMet;
                        outKg += rOutKg;
                    }


                    CellValue[] res = new CellValue[14];
                    int i = 0;
                    res[i++] = new CellValue(CellDataType.INT, stt++);
                    res[i++] = new CellValue(CellDataType.STRING, size.getName());
                    res[i++] = new CellValue(CellDataType.INT, rInitRoll);
                    res[i++] = new CellValue(CellDataType.DOUBLE, rInitMet);
                    res[i++] = new CellValue(CellDataType.DOUBLE, rInitKg);

                    res[i++] = new CellValue(CellDataType.INT, rInRoll);
                    res[i++] = new CellValue(CellDataType.DOUBLE, rInMet);
                    res[i++] = new CellValue(CellDataType.DOUBLE, rInKg);

                    res[i++] = new CellValue(CellDataType.INT, rOutRoll);
                    res[i++] = new CellValue(CellDataType.DOUBLE, rOutMet);
                    res[i++] = new CellValue(CellDataType.DOUBLE, rOutKg);

                    res[i++] = new CellValue(CellDataType.INT, rInitRoll + rInRoll - rOutRoll);
                    res[i++] = new CellValue(CellDataType.DOUBLE, rInitMet + rInMet - rOutMet);
                    res[i++] = new CellValue(CellDataType.DOUBLE, rInitKg + rInKg - rOutKg);
                    ExcelUtil.addRow(sheet, startRow++, res, normalFormat, normalFormat, normalFormat, normalFormat);
                }

                WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12,
                        WritableFont.BOLD, false,
                        UnderlineStyle.NO_UNDERLINE,
                        Colour.BLACK);
                WritableCellFormat boldCenterFormat = new WritableCellFormat(boldFont);
                boldCenterFormat.setWrap(true);
                boldCenterFormat.setAlignment(Alignment.CENTRE);
                boldCenterFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

                Label tong = new Label(0,startRow,"Tổng:",boldCenterFormat);
                sheet.addCell(tong);
                sheet.mergeCells(0,startRow,1,startRow);
                int j = 2;

                sheet.addCell(new Number(j++,startRow,initRoll,boldCenterFormat));
                sheet.addCell(new Number(j++,startRow,initMet,boldCenterFormat));
                sheet.addCell(new Number(j++,startRow,initKg,boldCenterFormat));

                sheet.addCell(new Number(j++,startRow,inRoll,boldCenterFormat));
                sheet.addCell(new Number(j++,startRow,inMet,boldCenterFormat));
                sheet.addCell(new Number(j++,startRow,inKg,boldCenterFormat));

                sheet.addCell(new Number(j++,startRow,outRoll,boldCenterFormat));
                sheet.addCell(new Number(j++,startRow,outMet,boldCenterFormat));
                sheet.addCell(new Number(j++,startRow,outKg,boldCenterFormat));

                sheet.addCell(new Number(j++,startRow, initRoll + inRoll - outRoll,boldCenterFormat));
                sheet.addCell(new Number(j++,startRow,initMet + inMet - outMet,boldCenterFormat));
                sheet.addCell(new Number(j++,startRow,initKg + inKg - outKg,boldCenterFormat));
                startRow += 2;
            }
            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }

    private int buildHeaderInOutProductionReport(WritableSheet sheet, int startRow, ProductInOutDTO result, ProductGeneralBean bean) throws WriteException {
        WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12, WritableFont.BOLD);

        WritableCellFormat cellBoldFormat = new WritableCellFormat(boldFont);
        cellBoldFormat.setWrap(true);
        cellBoldFormat.setAlignment(jxl.format.Alignment.CENTRE);
        cellBoldFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
        cellBoldFormat.setBackground(Colour.GRAY_50);
        cellBoldFormat.setVerticalAlignment(VerticalAlignment.CENTRE);

        Label headLabel = new Label(0,startRow,result.getSpecificName() + " từ ngày " + DateUtils.date2String(bean.getFromDate(),"dd/MM/yyyy") + " - đến " + DateUtils.date2String(bean.getToDate(),"dd/MM/yyyy"),cellBoldFormat);
        sheet.addCell(headLabel);
        sheet.mergeCells(0,startRow,13,startRow++);


        Label sttLabel = new Label(0,startRow,"STT",cellBoldFormat);
        sheet.addCell(sttLabel);
        Label qcLabel = new Label(1,startRow,"Quy cách",cellBoldFormat);
        sheet.addCell(qcLabel);
        Label dkLabel = new Label(2,startRow,"Tồn đầu kỳ",cellBoldFormat);
        sheet.addCell(dkLabel);
        Label tkLabel = new Label(5,startRow,"Nhập trong kỳ",cellBoldFormat);
        sheet.addCell(tkLabel);
        Label xkLabel = new Label(8,startRow,"Xuất trong kỳ",cellBoldFormat);
        sheet.addCell(xkLabel);
        Label ckLabel = new Label(11,startRow,"Tồn cuối kỳ",cellBoldFormat);
        sheet.addCell(ckLabel);

        sheet.mergeCells(0,startRow,0,startRow+1);
        sheet.mergeCells(1,startRow,1,startRow+1);
        sheet.mergeCells(2,startRow,4,startRow);
        sheet.mergeCells(5,startRow,7,startRow);
        sheet.mergeCells(8,startRow,10,startRow);
        sheet.mergeCells(11,startRow,13,startRow);
        startRow++;

        for(int i = 0; i < 4; i ++){
            Label cLabel = new Label(i * 3 + 2,startRow,"Cuộn",cellBoldFormat);
            sheet.addCell(cLabel);
            Label mLabel = new Label(i * 3 + 3,startRow,"Mét",cellBoldFormat);
            sheet.addCell(mLabel);
            Label tlLabel = new Label(i * 3 + 4,startRow,"T.Lượng",cellBoldFormat);
            sheet.addCell(tlLabel);
        }
        startRow++;
        return startRow;
    }



}
