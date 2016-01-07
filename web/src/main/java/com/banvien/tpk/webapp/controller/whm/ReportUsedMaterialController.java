package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.SearchUsedMaterialBean;
import com.banvien.tpk.core.dto.SummaryUsedMaterialDTO;
import com.banvien.tpk.core.dto.UsedMaterialDTO;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import jxl.Workbook;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.write.*;
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
public class ReportUsedMaterialController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private MarketService marketService;

    @Autowired
    private OriginService originService;

    @Autowired
    private MaterialService materialService;

    @Autowired
    private ExportmaterialService exportmaterialService;

    @Autowired
    private ProductionPlanService productionPlanService;

    @Autowired
    private ExporttypeService exporttypeService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/used/material.html"})
    public ModelAndView list(SearchUsedMaterialBean bean,HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/used/material");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToExportedDate() != null){
            bean.setToExportedDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToExportedDate().getTime())));
        }
        String crudaction = bean.getCrudaction();
        if(crudaction !=null && StringUtils.isNotBlank(crudaction)){
            try {
                if(bean.getCrudaction() != null && "report".equals(bean.getCrudaction())){
                    SummaryUsedMaterialDTO result = this.exportmaterialService.reportUsedMaterial(bean);
                    mav.addObject("result",result);
                }

                if(bean.getCrudaction() != null && "export".equals(bean.getCrudaction())){
                    SummaryUsedMaterialDTO result = this.exportmaterialService.reportUsedMaterial(bean);
                    mav.addObject("result",result);
                    exportUsedMaterial2Excel(bean, result, request, response);
                }
            } catch (Exception e) {
                log.error(e.getMessage(),e);
            }
        }
        addData2ModelMaterial(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void exportUsedMaterial2Excel(SearchUsedMaterialBean bean, SummaryUsedMaterialDTO result, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/VatTuSuDung_" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/UsedMaterial.xls");
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
            DecimalFormat decimalFormat = new DecimalFormat("###,###.##");
            DecimalFormat decimalFormat2 = new DecimalFormat("###,###.####");
            int startRow = 4;
            int stt = 1;

            List<UsedMaterialDTO> shareUsedMaterials = result.getShareUsedMaterials();
            List<UsedMaterialDTO> usedProducts = result.getUsedProducts();
            List<UsedMaterialDTO> usedMeasurementMaterials = result.getUsedMeasurementMaterials();
            Double totalMainProductKg = 0d;
            Double totalMainProductMet2 = 0d;
            Integer counter = 0;
            Double totalMet2 = 0d;
            Double totalKg = 0d;
            Double kgMet;
            Double kgTan;
            Double materialUsed;

            if(usedProducts != null && usedProducts.size() > 0){
                for(UsedMaterialDTO usedProduct : usedProducts){
                    totalKg = usedProduct.getTotalKgUsed();
                    totalMet2 = usedProduct.getTotalMUsed() * Integer.valueOf(usedProduct.getWidth()) / 1000;
                    counter++;
                    totalMainProductKg += totalKg;
                    totalMainProductMet2 += totalMet2;

                    addUsedMaterialRow(sheet,normalFormat,decimalFormat,decimalFormat2,startRow++,counter,usedProduct.getProductName().getName(),"Kg",totalKg,null,null);

                    if(usedProduct.getUsedMaterialDTOs() != null && usedProduct.getUsedMaterialDTOs().size() > 0){
                        for(UsedMaterialDTO usedMaterial : usedProduct.getUsedMaterialDTOs()){
                            counter++;
                            materialUsed = usedMaterial.getTotalUsed();
                            kgMet = totalMet2 > 0 ? materialUsed / totalMet2 : null;
                            kgTan = totalKg > 0 ? materialUsed * 1000 / totalKg : null;
                            addUsedMaterialRow(sheet,normalFormat, decimalFormat, decimalFormat2,startRow++,counter,usedMaterial.getMaterial().getName(),usedMaterial.getMaterial().getUnit().getName(),materialUsed,kgMet,kgTan);
                        }
                    }
                }
            }

            if(usedMeasurementMaterials != null && usedMeasurementMaterials.size() > 0){
                for(UsedMaterialDTO usedMaterial : usedMeasurementMaterials){
                    counter++;
                    materialUsed = usedMaterial.getTotalUsed();
                    kgMet = totalMet2 > 0 ? materialUsed / totalMainProductMet2 : null;
                    kgTan = totalKg > 0 ? materialUsed * 1000 / totalMainProductKg : null;
                    addUsedMaterialRow(sheet,normalFormat, decimalFormat, decimalFormat2,startRow++,counter,usedMaterial.getMaterial().getName(),usedMaterial.getMaterial().getUnit().getName(),materialUsed,kgMet,kgTan);
                }
            }

            if(shareUsedMaterials != null && shareUsedMaterials.size() > 0){
                for(UsedMaterialDTO usedMaterial : shareUsedMaterials){
                    counter++;
                    materialUsed = usedMaterial.getTotalUsed();
                    kgMet = totalMet2 > 0 ? materialUsed / totalMainProductMet2 : null;
                    kgTan = totalKg > 0 ? materialUsed * 1000 / totalMainProductKg : null;
                    addUsedMaterialRow(sheet,normalFormat, decimalFormat, decimalFormat2,startRow++,counter,usedMaterial.getMaterial().getName(),usedMaterial.getMaterial().getUnit().getName(),materialUsed,kgMet,kgTan);
                }
            }
            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }

    private void addUsedMaterialRow(WritableSheet sheet, WritableCellFormat normalFormat, DecimalFormat decimalFormat, DecimalFormat decimalFormat2, Integer startRow, Integer counter, String name, String unitName, Double usedQuantity, Double kgMet, Double kgTan) throws WriteException {
        CellValue[] res = new CellValue[6];
        int i = 0;
        res[i++] = new CellValue(CellDataType.STRING, counter);
        res[i++] = new CellValue(CellDataType.STRING, name);
        res[i++] = new CellValue(CellDataType.STRING, unitName);
        res[i++] = new CellValue(CellDataType.STRING, usedQuantity != null ? decimalFormat.format(usedQuantity) : "");
        res[i++] = new CellValue(CellDataType.STRING, kgMet != null ?  decimalFormat2.format(kgMet) : "");
        res[i++] = new CellValue(CellDataType.STRING, kgTan != null ?  decimalFormat.format(kgTan) : "");
        ExcelUtil.addRow(sheet, startRow, res, normalFormat, normalFormat, normalFormat, normalFormat);
    }


    private void addData2ModelMaterial(ModelAndView mav){
        List<Warehouse> warehouses = new ArrayList<Warehouse>();
        if(SecurityUtils.getPrincipal().getWarehouseID()!=null){
            Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
            warehouses.add(warehouse);
        }else{
            warehouses = this.warehouseService.findByStatus(Constants.TPK_USER_ACTIVE);
        }
        mav.addObject("warehouses", warehouses);
        mav.addObject("materials", this.materialService.findAll());
        mav.addObject("origins", this.originService.findAll());
        mav.addObject("markets", this.marketService.findAll());
        mav.addObject("productionPlans", this.productionPlanService.findAll());
        mav.addObject("exportTypes", this.exporttypeService.findAll());

    }
}
