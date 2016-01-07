package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.Quality;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.domain.WarehouseMap;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import com.banvien.tpk.webapp.util.WebCommonUtils;
import jxl.Workbook;
import jxl.format.*;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.*;
import jxl.write.Alignment;
import jxl.write.Border;
import jxl.write.BorderLineStyle;
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
import java.util.Map;

@Controller
public class ReportSummaryProductionController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ImportproductService importProductService;

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private MarketService marketService;

    @Autowired
    private OriginService originService;

    @Autowired
    private ProductnameService productnameService;

    @Autowired
    private ColourService colourService;

    @Autowired
    private ThicknessService thicknessService;

    @Autowired
    private SizeService sizeService;

    @Autowired
    private StiffnessService stiffnessService;

    @Autowired
    private OverlaytypeService overlaytypeService;

    @Autowired
    private MaterialService materialService;

    @Autowired
    private MaterialcategoryService materialcategoryService;

    @Autowired
    private ImportmaterialService importMaterialService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private BookProductBillService bookProductBillService;

    @Autowired
    private UserService userService;

    @Autowired
    private WarehouseMapService warehouseMapService;

    @Autowired
    private QualityService qualityService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/summaryproduction.html"})
    public ModelAndView list(ProducedProductBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/summaryproduction");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        bean.setReportSummaryProduction(Boolean.TRUE);
        bean.setMaxPageItems(Integer.MAX_VALUE);
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        if(bean.getCrudaction() != null && "report".equals(bean.getCrudaction())){
            List<SummaryProductionDTO> results = this.importProductService.summaryProducttion(bean);
            mav.addObject("results", results);
        }

        if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
            List<SummaryProductionDTO> results = this.importProductService.summaryProducttion(bean);
            mav.addObject("results", results);
            exportSummaryProduct2Excel(bean, results, request, response);
        }
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void addData2ModelProduct(ModelAndView mav){
        List<Warehouse> warehouses = new ArrayList<Warehouse>();
        List<WarehouseMap> warehouseMaps = new ArrayList<WarehouseMap>();
        if(SecurityUtils.getPrincipal().getWarehouseID()!=null){
            Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
            warehouses.add(warehouse);
            warehouseMaps = this.warehouseMapService.findByWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        }else{
            warehouses = this.warehouseService.findByStatus(Constants.TPK_USER_ACTIVE);
        }
        mav.addObject("warehouseMaps", warehouseMaps);
        mav.addObject("warehouses", warehouses);
        mav.addObject("productNames", this.productnameService.findAll());
        mav.addObject("sizes", this.sizeService.findAll());
        mav.addObject("thicknesses", this.thicknessService.findAll());
        mav.addObject("stiffnesses", this.stiffnessService.findAll());
        mav.addObject("colours", this.colourService.findAll());
        mav.addObject("overlayTypes", this.overlaytypeService.findAll());
        mav.addObject("origins", this.originService.findAll());
        mav.addObject("markets", this.marketService.findAll());
        mav.addObject("qualities", this.qualityService.findAll());
    }


    private void exportSummaryProduct2Excel(ProducedProductBean bean, List<SummaryProductionDTO> results, HttpServletRequest request, HttpServletResponse response) {
        try{
            Map<Long,String> mapOriginName = WebCommonUtils.buildMapOriginName(this.originService.findAll());
            List<Quality> qualities = this.qualityService.findAll();
            String outputFileName = "/files/temp/TongHopSanXuat_" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/TongHopSanXuat.xls");
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
            int startRow = 3;
            int stt = 1;

            for(SummaryProductionDTO result : results){
                startRow = buildHeaderSummaryProductionReport(sheet,qualities,startRow,result.getMaterialName(),result.getProductName(), result.getOriginIDs(), mapOriginName);
                Integer noOrigin = result.getOriginIDs().size();
                for(SummaryProductionDetailDTO detail : result.getSummaryProductionDetails()){
                    CellValue[] res = new CellValue[9 + qualities.size() + noOrigin];
                    int i = 0;
                    res[i++] = new CellValue(CellDataType.STRING, stt++);
                    res[i++] = new CellValue(CellDataType.STRING, detail.getSize() != null ? detail.getSize() : "");
                    res[i++] = new CellValue(CellDataType.STRING, detail.getSpecific() != null ? detail.getSpecific() : "");
                    res[i++] = new CellValue(CellDataType.STRING, detail.getNoMaterialRoll() != null ? detail.getNoMaterialRoll() : "");
                    res[i++] = new CellValue(CellDataType.STRING, detail.getMaterialKg() != null ? decimalFormat.format(detail.getMaterialKg())  : "");
                    for(Long originID : result.getOriginIDs()){
                        res[i++] = new CellValue(CellDataType.STRING, detail.getMapOriginQuantity().get(originID) != null ? decimalFormat.format(detail.getMapOriginQuantity().get(originID))  : "");
                    }
                    res[i++] = new CellValue(CellDataType.STRING, detail.getNoProductRoll() != null ? detail.getNoProductRoll() : "");
                    res[i++] = new CellValue(CellDataType.STRING, detail.getProductKg() != null ? decimalFormat.format(detail.getProductKg()) : "");
                    for(Quality quality : qualities){
                        res[i++] = new CellValue(CellDataType.STRING, detail.getMapQualityMet().get(quality.getQualityID()) != null ? decimalFormat.format(detail.getMapQualityMet().get(quality.getQualityID())) : "");
                    }
                    res[i++] = new CellValue(CellDataType.STRING, detail.getTotalMet() != null ? decimalFormat.format(detail.getTotalMet()) : "");
                    res[i++] = new CellValue(CellDataType.STRING, detail.getTotalMet2() != null ? decimalFormat.format(detail.getTotalMet2()) : "");
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
                sheet.mergeCells(0,startRow,2,startRow);
                SummaryProductionDetailDTO overallDetail = result.getOverallDetail();
                int j = 3;
                Label mRoll = new Label(j++,startRow,overallDetail.getNoMaterialRoll().toString(),boldCenterFormat);
                sheet.addCell(mRoll);

                String mKg = overallDetail.getMaterialKg() != null ? decimalFormat.format(overallDetail.getMaterialKg())  : "";
                Label lKg = new Label(j++,startRow,mKg,boldCenterFormat);
                sheet.addCell(lKg);

                for(Long originID : result.getOriginIDs()){
                    String mOriginKg = overallDetail.getMapOriginQuantity().get(originID) != null ? decimalFormat.format(overallDetail.getMapOriginQuantity().get(originID))  : "";
                    Label lOriginKg = new Label(j++,startRow,mOriginKg,boldCenterFormat);
                    sheet.addCell(lOriginKg);
                }

                Label pRoll = new Label(j++,startRow,overallDetail.getNoProductRoll().toString(),boldCenterFormat);
                sheet.addCell(pRoll);

                String pKg = overallDetail.getProductKg() != null ? decimalFormat.format(overallDetail.getProductKg())  : "";
                Label lpKg = new Label(j++,startRow,pKg,boldCenterFormat);
                sheet.addCell(lpKg);
                for(Quality quality : qualities){
                    String sM = overallDetail.getMapQualityMet().get(quality.getQualityID()) != null ? decimalFormat.format(overallDetail.getMapQualityMet().get(quality.getQualityID()))  : "";
                    Label lM = new Label(j++,startRow,sM,boldCenterFormat);
                    sheet.addCell(lM);
                }
                String totalM = overallDetail.getTotalMet() != null ? decimalFormat.format(overallDetail.getTotalMet())  : "";
                Label lTotalM = new Label(j++,startRow,totalM,boldCenterFormat);
                sheet.addCell(lTotalM);

                String totalM2 = overallDetail.getTotalMet2() != null ? decimalFormat.format(overallDetail.getTotalMet2())  : "";
                Label lTotalM2 = new Label(j++,startRow,totalM2,boldCenterFormat);
                sheet.addCell(lTotalM2);
                startRow += 3;
            }
            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }

    private int buildHeaderSummaryProductionReport(WritableSheet sheet,List<Quality> qualities,int startRow,String mainMaterialName, String productName,List<Long> originIDs, Map<Long,String> mapOriginName) throws WriteException {
        WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12, WritableFont.BOLD);

        WritableCellFormat cellBoldFormat = new WritableCellFormat(boldFont);
        cellBoldFormat.setWrap(true);
        cellBoldFormat.setAlignment(jxl.format.Alignment.CENTRE);
        cellBoldFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
        cellBoldFormat.setBackground(Colour.GRAY_50);
        cellBoldFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
        Integer noOrigin = originIDs.size();
        int index = 0;
        CellValue[] resValue = new CellValue[9 + qualities.size() + noOrigin];
        resValue[index++] = new CellValue(CellDataType.STRING,"");
        resValue[index++] = new CellValue(CellDataType.STRING,"");
        resValue[index++] = new CellValue(CellDataType.STRING,"");
        resValue[index++] = new CellValue(CellDataType.STRING,"Số cuộn");
        resValue[index++] = new CellValue(CellDataType.STRING,"T.Lượng (kg)");
        for(Long originID : originIDs){
            resValue[index++] = new CellValue(CellDataType.STRING, mapOriginName.get(originID) != null ? mapOriginName.get(originID) : "N/A");
        }
        resValue[index++] = new CellValue(CellDataType.STRING,"Số cuộn");
        resValue[index++] = new CellValue(CellDataType.STRING,"T.Lượng (kg)");
        for(Quality quality : qualities){
            resValue[index++] = new CellValue(CellDataType.STRING,quality.getName());
        }
        resValue[index++] = new CellValue(CellDataType.STRING,"Tổng");
        resValue[index++] = new CellValue(CellDataType.STRING,"");
        ExcelUtil.addRow(sheet, startRow, resValue,cellBoldFormat,cellBoldFormat,cellBoldFormat,cellBoldFormat);

        Label sttLabel = new Label(0,startRow - 1,"STT",cellBoldFormat);
        sheet.addCell(sttLabel);
        Label qcLabel = new Label(1,startRow - 1,"Quy cách (mmXmm)",cellBoldFormat);
        sheet.addCell(qcLabel);
        Label plLabel = new Label(2,startRow - 1,"Phân loại",cellBoldFormat);
        sheet.addCell(plLabel);
        Label qmLabel = new Label(8 + qualities.size() + noOrigin,startRow - 1,"Quy m2",cellBoldFormat);
        sheet.addCell(qmLabel);

        Label materialNameLabel = new Label(3,startRow - 1,mainMaterialName,cellBoldFormat);
        sheet.addCell(materialNameLabel);
        Label productNameLabel = new Label(5 + noOrigin,startRow - 1,productName,cellBoldFormat);
        sheet.addCell(productNameLabel);
        Label danhGia = new Label(7 + noOrigin,startRow - 1,"Chất lượng sản phẩm",cellBoldFormat);
        sheet.addCell(danhGia);

        sheet.mergeCells(0,startRow - 1,0,startRow);
        sheet.mergeCells(1,startRow - 1,1,startRow);
        sheet.mergeCells(2,startRow - 1,2,startRow);
        sheet.mergeCells(7 + qualities.size() + 1 + noOrigin,startRow - 1,7 + qualities.size() + 1 + noOrigin,startRow);

        sheet.mergeCells(3,startRow - 1,4 + noOrigin,startRow - 1);
        sheet.mergeCells(5 + noOrigin, startRow - 1, 6 + noOrigin, startRow - 1);
        sheet.mergeCells(7 + noOrigin, startRow - 1,7 + qualities.size() + noOrigin, startRow - 1);

        startRow++;
        return startRow;
    }


}
