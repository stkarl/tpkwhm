package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.BuyContractDTO;
import com.banvien.tpk.core.dto.ReportByContractBean;
import com.banvien.tpk.core.dto.SummaryUsedMaterialDTO;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import jxl.Workbook;
import jxl.format.*;
import jxl.write.*;
import jxl.write.Alignment;
import jxl.write.Colour;
import jxl.write.VerticalAlignment;
import jxl.write.biff.RowsExceededException;
import org.apache.commons.lang.StringUtils;
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
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ReportImportByContractController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private BuyContractService buyContractService;

    @Autowired
    private CustomerService customerService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/contract/import.html"})
    public ModelAndView list(ReportByContractBean bean,HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/contract/import");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        String crudaction = bean.getCrudaction();
        if(crudaction !=null && StringUtils.isNotBlank(crudaction)){
            try {
                List<BuyContractDTO> results = this.buyContractService.reportImportByContract(bean);
                if(crudaction.equalsIgnoreCase("report")){
                    mav.addObject("results",results);
                }
                if(crudaction.equalsIgnoreCase("export")){
                    exportBuyContractReport2Excel(results, request, response);

                }
            } catch (Exception e) {
                log.error(e.getMessage(),e);
            }
        }
        addData2ModelMaterial(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void addData2ModelMaterial(ModelAndView mav){
        mav.addObject("customers", this.customerService.findAll());
    }


    private void exportBuyContractReport2Excel(List<BuyContractDTO> results, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/BaoCaoNhapTonTheoHopDong_" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/ReportBuyContract.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);

            WritableSheet sheet = workbook.getSheet(0);

            WritableFont normalFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    jxl.format.Colour.BLACK);
            WritableCellFormat normalFormat = new WritableCellFormat(normalFont);
            normalFormat.setAlignment(jxl.write.Alignment.CENTRE);
            normalFormat.setWrap(true);
            normalFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

            WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    jxl.format.Colour.BLACK);
            WritableCellFormat headerFormat = new WritableCellFormat(boldFont);
            headerFormat.setAlignment(jxl.write.Alignment.CENTRE);
            headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
            headerFormat.setWrap(true);
            headerFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            headerFormat.setBackground(jxl.format.Colour.GRAY_25);

            WritableCellFormat boldFormat = new WritableCellFormat(boldFont);
            boldFormat.setAlignment(jxl.write.Alignment.CENTRE);
            boldFormat.setWrap(true);
            boldFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

            DecimalFormat decimalFormat = new DecimalFormat("###,###.###");

            int startRow = 2;
            for(BuyContractDTO buyContractDTO : results){
                startRow = buildContractHeader(sheet, startRow, headerFormat);
                startRow = buildContractInfo(sheet, startRow, buyContractDTO, normalFormat, decimalFormat);
                startRow = buildContractDetailHeader(sheet, startRow, headerFormat);
                startRow = buildContractDetailInfo(sheet, startRow, buyContractDTO, normalFormat, boldFormat, decimalFormat);
            }
            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }

    private int buildContractHeader(WritableSheet sheet, int startRow, WritableCellFormat headerFormat) throws WriteException {
        int index = 0;
        CellValue[] resValue = new CellValue[7];
        resValue[index++] = new CellValue(CellDataType.STRING,"Số hợp đồng");
        resValue[index++] = new CellValue(CellDataType.STRING,"Đối tác");
        resValue[index++] = new CellValue(CellDataType.STRING,"Ngày hợp đồng");
        resValue[index++] = new CellValue(CellDataType.STRING,"Số cuộn");
        resValue[index++] = new CellValue(CellDataType.STRING,"T.Lượng (tấn)");
        resValue[index++] = new CellValue(CellDataType.STRING,"Đã nhập (cuộn)");
        resValue[index++] = new CellValue(CellDataType.STRING,"Đã nhập (tấn)");
        ExcelUtil.addRow(sheet, startRow++, resValue,headerFormat,headerFormat,headerFormat,headerFormat);
        return startRow;
    }

    private int buildContractInfo(WritableSheet sheet, int startRow, BuyContractDTO buyContractDTO, WritableCellFormat normalFormat, DecimalFormat decimalFormat) throws WriteException {
        int index = 0;
        CellValue[] resValue = new CellValue[7];
        resValue[index++] = new CellValue(CellDataType.STRING, StringUtils.isNotBlank(buyContractDTO.getCode()) ? buyContractDTO.getCode() : "");
        resValue[index++] = new CellValue(CellDataType.STRING, StringUtils.isNotBlank(buyContractDTO.getCustomerName()) ? buyContractDTO.getCustomerName() : "");
        resValue[index++] = new CellValue(CellDataType.STRING, buyContractDTO.getStartDate() != null ? DateUtils.date2String(buyContractDTO.getStartDate(),"dd/MM/yyyy") : "");
        resValue[index++] = new CellValue(CellDataType.STRING, buyContractDTO.getNoRoll() != null ? buyContractDTO.getNoRoll().toString() : "");
        resValue[index++] = new CellValue(CellDataType.STRING, buyContractDTO.getWeight() != null ? decimalFormat.format(buyContractDTO.getWeight()) : "");
        resValue[index++] = new CellValue(CellDataType.STRING, buyContractDTO.getImportProducts() != null ? buyContractDTO.getImportProducts().size() : "");
        resValue[index++] = new CellValue(CellDataType.STRING, buyContractDTO.getTotalWeight() != null ? decimalFormat.format(buyContractDTO.getTotalWeight() / 1000) : "");
        ExcelUtil.addRow(sheet, startRow++, resValue,normalFormat,normalFormat,normalFormat,normalFormat);
        return ++startRow;
    }

    private int buildContractDetailHeader(WritableSheet sheet, int startRow, WritableCellFormat headerFormat) throws WriteException {
        int index = 0;
        CellValue[] resValue = new CellValue[9];
        resValue[index++] = new CellValue(CellDataType.STRING,"STT");
        resValue[index++] = new CellValue(CellDataType.STRING,"Mã số");
        resValue[index++] = new CellValue(CellDataType.STRING,"Quy cách (mmxmm)");
        resValue[index++] = new CellValue(CellDataType.STRING,"Trọng lượng (tịnh)");
        resValue[index++] = new CellValue(CellDataType.STRING,"Trọng lượng (gộp)");
        resValue[index++] = new CellValue(CellDataType.STRING,"TL cân thực tế (gộp)");
        resValue[index++] = new CellValue(CellDataType.STRING,"Chênh lệch");
        resValue[index++] = new CellValue(CellDataType.STRING,"Xuất xứ");
        resValue[index++] = new CellValue(CellDataType.STRING,"Đơn giá (VNĐ/ĐVT");
        ExcelUtil.addRow(sheet, startRow++, resValue,headerFormat,headerFormat,headerFormat,headerFormat);
        return startRow;
    }

    private int buildContractDetailInfo(WritableSheet sheet, int startRow, BuyContractDTO buyContractDTO, WritableCellFormat normalFormat, WritableCellFormat boldCenterFormat, DecimalFormat decimalFormat) throws WriteException {
        int stt = 1;
        String originName;
        Double total = 0d;
        Double pure = 0d;
        Double actual = 0d;
        for(Importproduct importproduct : buyContractDTO.getImportProducts()){
            CellValue[] res = new CellValue[9];
            int i = 0;
            res[i++] = new CellValue(CellDataType.STRING, stt++);
            res[i++] = new CellValue(CellDataType.STRING, importproduct.getProductCode() != null ? importproduct.getProductCode() : "");
            res[i++] = new CellValue(CellDataType.STRING, importproduct.getSize() != null ? importproduct.getSize().getName() : "");
            res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2Pure() != null ? decimalFormat.format(importproduct.getQuantity2Pure())  : "");
            res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2() != null ? decimalFormat.format(importproduct.getQuantity2())  : "");
            res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2Actual() != null ? decimalFormat.format(importproduct.getQuantity2Actual())  : "");
            res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2() != null && importproduct.getQuantity2Actual() != null ? decimalFormat.format(importproduct.getQuantity2Actual() - importproduct.getQuantity2())  : "");
            originName = "";
            if(importproduct.getOrigin() != null){
                originName = importproduct.getOrigin().getName();
            }else if(importproduct.getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getOrigin() != null){
                originName = importproduct.getMainUsedMaterial().getOrigin().getName();
            }else if(importproduct.getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getMainUsedMaterial().getOrigin() != null){
                originName = importproduct.getMainUsedMaterial().getMainUsedMaterial().getOrigin().getName();
            }
            res[i++] = new CellValue(CellDataType.STRING, originName);
            res[i++] = new CellValue(CellDataType.STRING, importproduct.getMoney() != null ? decimalFormat.format(importproduct.getMoney())  : "");

            ExcelUtil.addRow(sheet, startRow++, res, normalFormat, normalFormat, normalFormat, normalFormat);
            total +=  importproduct.getQuantity2() != null ? importproduct.getQuantity2() : 0d;
            pure +=  importproduct.getQuantity2Pure() != null ? importproduct.getQuantity2Pure() : 0d;
            actual +=  importproduct.getQuantity2Actual() != null ? importproduct.getQuantity2Actual() : 0d;
        }

        Label tong = new Label(0,startRow,"Tổng",boldCenterFormat);
        sheet.addCell(tong);
        sheet.mergeCells(0,startRow,1,startRow);

        Label cuon = new Label(2,startRow, buyContractDTO.getImportProducts().size() + " cuộn",boldCenterFormat);
        sheet.addCell(cuon);

        Label lPure = new Label(3,startRow, decimalFormat.format(pure),boldCenterFormat);
        sheet.addCell(lPure);

        Label lTotal = new Label(4,startRow, decimalFormat.format(total),boldCenterFormat);
        sheet.addCell(lTotal);

        Label lActual = new Label(5,startRow, decimalFormat.format(actual),boldCenterFormat);
        sheet.addCell(lActual);

        Label lGap = new Label(6,startRow, decimalFormat.format(actual - total),boldCenterFormat);
        sheet.addCell(lGap);

        Label blank = new Label(7,startRow, "",boldCenterFormat);
        sheet.addCell(blank);

        Label lTotalMoney = new Label(8,startRow, decimalFormat.format(buyContractDTO.getTotalMoney()),boldCenterFormat);
        sheet.addCell(lTotalMoney);
        startRow += 2;
        return startRow;
    }


}
