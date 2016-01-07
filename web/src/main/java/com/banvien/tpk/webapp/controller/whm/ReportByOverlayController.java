package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.domain.Colour;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import com.banvien.tpk.webapp.util.RequestUtil;
import com.banvien.tpk.webapp.util.WebCommonUtils;
import jxl.Workbook;
import jxl.format.*;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.*;
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
import java.util.*;

@Controller
public class ReportByOverlayController extends ApplicationObjectSupport {
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

    @RequestMapping(value={"/whm/report/byoverlay.html"})
    public ModelAndView list(ProducedProductBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/byoverlay");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        bean.setReportOverlay(Boolean.TRUE);
        bean.setMaxPageItems(Integer.MAX_VALUE);
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        try {
            if(bean.getCrudaction() != null && "report".equals(bean.getCrudaction())){
                List<SummaryByOverlayDTO> results = this.importProductService.summaryByOverlay(bean);
                mav.addObject("results", results);
            }

            if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
                List<SummaryByOverlayDTO> results = this.importProductService.summaryByOverlay(bean);
                mav.addObject("results", results);
                exportOverlayReport2Excel(bean,results, request, response);
            }
        } catch (Exception e) {
            log.error(e.getMessage(),e);
        }
        addData2ModelProduct(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void exportOverlayReport2Excel(ProducedProductBean bean, List<SummaryByOverlayDTO> results, HttpServletRequest request, HttpServletResponse response) {
        try{
            Map<Long,String> mapOriginName = WebCommonUtils.buildMapOriginName(this.originService.findAll());
            List<Quality> qualities = this.qualityService.findAll();
            String outputFileName = "/files/temp/TongHopQuyCach_LopPhu_" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/TongHopSanXuat.xls");
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
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            int startRow = 3;
            int stt = 1;
            for(SummaryByOverlayDTO result : results){
                Integer noOrigin = 0;
                for(Long overlayID : result.getMapOverlayOrigins().keySet()){
                    noOrigin += result.getMapOverlayOrigins().get(overlayID).size();
                }
                startRow = buildHeaderOverlayReport(sheet,result.getOverlayTypes(), qualities, startRow, result.getMaterialName(), result.getProductName(), result.getMapOverlayOrigins(), mapOriginName, noOrigin);
                for(Size size : result.getSizes()){
                    Long sizeID = size.getSizeID();

                    CellValue[] res = new CellValue[2 + noOrigin + (3 + qualities.size())*result.getOverlayTypes().size()];
                    int i = 0;
                    res[i++] = new CellValue(CellDataType.STRING, stt++);
                    res[i++] = new CellValue(CellDataType.STRING, size.getName() != null ? size.getName() : "");
                    for(Overlaytype overlaytype : result.getOverlayTypes()){
                        Long overlayID = overlaytype.getOverlayTypeID();
                        SummaryDetailByOverlayDTO detail = result.getMapSizeOverlayDetail().get(sizeID) != null && result.getMapSizeOverlayDetail().get(sizeID).get(overlayID) != null ? result.getMapSizeOverlayDetail().get(sizeID).get(overlayID) : new SummaryDetailByOverlayDTO();
                        res[i++] = new CellValue(CellDataType.STRING, detail.getMaterialKg() != null ? decimalFormat.format(detail.getMaterialKg())  : "");
                        for(Long originID : result.getMapOverlayOrigins().get(overlayID)){
                            res[i++] = new CellValue(CellDataType.STRING, detail.getMapOriginQuantity() != null && detail.getMapOriginQuantity().get(originID) != null ? decimalFormat.format(detail.getMapOriginQuantity().get(originID))  : "");
                        }
                        res[i++] = new CellValue(CellDataType.STRING, detail.getProductKg() != null ? decimalFormat.format(detail.getProductKg()) : "");
                        for(Quality quality : qualities){
                            Long qualityID = quality.getQualityID();
                            res[i++] = new CellValue(CellDataType.STRING,detail.getMapQualityMet() !=null && detail.getMapQualityMet().get(qualityID) != null ? decimalFormat.format(detail.getMapQualityMet().get(qualityID))  : "");
                        }
                        res[i++] = new CellValue(CellDataType.STRING, detail.getProductMet() != null ? decimalFormat.format(detail.getProductMet()) : "");
                    }
                    ExcelUtil.addRow(sheet, startRow++, res, normalFormat, normalFormat, normalFormat, normalFormat);
                }

                WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12,
                        WritableFont.BOLD, false,
                        UnderlineStyle.NO_UNDERLINE,
                        jxl.format.Colour.BLACK);
                WritableCellFormat boldCenterFormat = new WritableCellFormat(boldFont);
                boldCenterFormat.setWrap(true);
                boldCenterFormat.setAlignment(jxl.write.Alignment.CENTRE);
                boldCenterFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

                Label tong = new Label(0,startRow,"Tổng:",boldCenterFormat);
                sheet.addCell(tong);
                sheet.mergeCells(0,startRow,1,startRow);
                int j = 2;
                for(Overlaytype overlaytype : result.getOverlayTypes()){
                    Long overlayID = overlaytype.getOverlayTypeID();
                    SummaryDetailByOverlayDTO detailTotal = result.getMapTotalSummary().get(overlayID) != null ? result.getMapTotalSummary().get(overlayID) : new SummaryDetailByOverlayDTO();
                    String mKg = detailTotal.getMaterialKg() != null ? decimalFormat.format(detailTotal.getMaterialKg())  : "";
                    Label lKg = new Label(j++,startRow,mKg,boldCenterFormat);
                    sheet.addCell(lKg);
                    for(Long originID : result.getMapOverlayOrigins().get(overlayID)){
                        String originKg = result.getMapOverlayOriginQuantity().get(overlayID).get(originID)  != null ? decimalFormat.format(result.getMapOverlayOriginQuantity().get(overlayID).get(originID))  : "";
                        Label lpOriginKg = new Label(j++,startRow,originKg,boldCenterFormat);
                        sheet.addCell(lpOriginKg);
                    }
                    String pKg = detailTotal.getProductKg() != null ? decimalFormat.format(detailTotal.getProductKg())  : "";
                    Label lpKg = new Label(j++,startRow,pKg,boldCenterFormat);
                    sheet.addCell(lpKg);
                    for(Quality quality : qualities){
                        String sM = detailTotal.getMapQualityMet().get(quality.getQualityID()) != null ? decimalFormat.format(detailTotal.getMapQualityMet().get(quality.getQualityID()))  : "";
                        Label lM = new Label(j++,startRow,sM,boldCenterFormat);
                        sheet.addCell(lM);
                    }
                    String totalM = detailTotal.getProductMet() != null ? decimalFormat.format(detailTotal.getProductMet())  : "";
                    Label lTotalM = new Label(j++,startRow,totalM,boldCenterFormat);
                    sheet.addCell(lTotalM);
                }

                startRow += 4;
            }
            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }

    private int buildHeaderOverlayReport(WritableSheet sheet,List<Overlaytype> overlaytypes, List<Quality> qualities, int startRow, String mainMaterialName, String productName, Map<Long,List<Long>> mapOverlayOrigins, Map<Long,String> mapOriginName, Integer noOrigin) throws WriteException {
        Integer noQuality = qualities.size();
        Integer noOverlay = overlaytypes.size();
        WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12, WritableFont.BOLD);
        WritableCellFormat cellBoldFormat = new WritableCellFormat(boldFont);
        cellBoldFormat.setWrap(true);
        cellBoldFormat.setAlignment(jxl.format.Alignment.CENTRE);
        cellBoldFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
        cellBoldFormat.setBackground(jxl.format.Colour.GRAY_50);
        cellBoldFormat.setVerticalAlignment(VerticalAlignment.CENTRE);

        int index = 0;
        CellValue[] resValue = new CellValue[2 + + noOrigin + (3 + qualities.size())*noOverlay];
        resValue[index++] = new CellValue(CellDataType.STRING,"STT");
        resValue[index++] = new CellValue(CellDataType.STRING,"Quy cách");
        for(Overlaytype overlaytype : overlaytypes){
            resValue[index++] = new CellValue(CellDataType.STRING,"T.L(kg)");
            for(Long originID : mapOverlayOrigins.get(overlaytype.getOverlayTypeID())){
                resValue[index++] = new CellValue(CellDataType.STRING, originID != null ? mapOriginName.get(originID) : "N/A");
            }
            resValue[index++] = new CellValue(CellDataType.STRING,"T.L(kg)");
            for(Quality quality : qualities){
                resValue[index++] = new CellValue(CellDataType.STRING,quality.getName());
            }
            resValue[index++] = new CellValue(CellDataType.STRING,"Mét");
        }
        ExcelUtil.addRow(sheet, startRow, resValue,cellBoldFormat,cellBoldFormat,cellBoldFormat,cellBoldFormat);

        sheet.mergeCells(0,startRow - 2,1,startRow - 1);
        Label blank1 = new Label(0,startRow - 2,"",cellBoldFormat);
        sheet.addCell(blank1);

        int k = 2;
        for(Overlaytype overlaytype : overlaytypes){
            Label materialNameLabel = new Label(k,startRow - 1,mainMaterialName,cellBoldFormat);
            sheet.addCell(materialNameLabel);
            sheet.mergeCells(k,startRow - 1,k + mapOverlayOrigins.get(overlaytype.getOverlayTypeID()).size(), startRow - 1);

            Label productNameLabel = new Label(k + 1 + mapOverlayOrigins.get(overlaytype.getOverlayTypeID()).size(), startRow - 1, productName, cellBoldFormat);
            sheet.addCell(productNameLabel);

            sheet.mergeCells(k + 1 + mapOverlayOrigins.get(overlaytype.getOverlayTypeID()).size(),startRow - 1,k + noQuality + 2 + mapOverlayOrigins.get(overlaytype.getOverlayTypeID()).size(),startRow - 1);
            k += 3 + noQuality + + mapOverlayOrigins.get(overlaytype.getOverlayTypeID()).size();
        }

        int h = 2;
        for(Overlaytype overlaytype : overlaytypes){
            Label overlayName = new Label(h,startRow - 2,overlaytype.getName(),cellBoldFormat);
            sheet.addCell(overlayName);
            sheet.mergeCells(h,startRow - 2,h + noQuality + 2 + mapOverlayOrigins.get(overlaytype.getOverlayTypeID()).size(),startRow - 2);
            h += 3 + noQuality + mapOverlayOrigins.get(overlaytype.getOverlayTypeID()).size();
        }
        startRow++;
        return startRow;
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

}
