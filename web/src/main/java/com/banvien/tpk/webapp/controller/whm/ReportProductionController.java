package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Importmaterial;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.Quality;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.ProducedProductBean;
import com.banvien.tpk.core.dto.ProducedProductDTO;
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
import java.util.*;

@Controller
public class ReportProductionController extends ApplicationObjectSupport {
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
    private QualityService qualityService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/produce/product.html"})
    public ModelAndView list(ProducedProductBean bean,HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/production/product");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        String crudaction = bean.getCrudaction();
        if(crudaction!= null && crudaction.equals(Constants.ACTION_SEARCH)){
            executeSearch(bean, request);
        }
        if(crudaction!= null && crudaction.equals(Constants.ACTION_EXPORT)){
            bean.setMaxPageItems(Integer.MAX_VALUE);
            executeSearch(bean, request);
            exportProduction2Excel(bean, request, response);
        }
        addData2Model(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }


    private void executeSearch(ProducedProductBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        List<ProducedProductDTO> dtos = this.importProductService.reportProducedProduct(bean);
        calMaterialStick(dtos);
        bean.setListResult(dtos);
        bean.setTotalItems(dtos.size());
        if(bean.getProductNameID()!= null && bean.getProductNameID() > 0){
            if(dtos != null && dtos.size() > 0 && dtos.get(0).getProducedProducts() != null && dtos.get(0).getProducedProducts().size() > 0){
                bean.setProductNameCode(dtos.get(0).getProducedProducts().get(0).getProductname().getCode());
            }
        }else{
            bean.setProductNameCode(null);
        }
    }

    private void calMaterialStick(List<ProducedProductDTO> dtos) {
        for(ProducedProductDTO dto : dtos){
            Importproduct mainMaterial = dto.getMainMaterial();
            List<Importproduct> producedProducts = dto.getProducedProducts();
            Double totalMain = mainMaterial.getImportBack() != null ? mainMaterial.getQuantity2Pure() - mainMaterial.getImportBack() : mainMaterial.getQuantity2Pure();
            Double cut = mainMaterial.getCutOff() != null ? mainMaterial.getCutOff() : 0d;
            Double tempProducedKg = 0d;
            Double tempProducedM = 0d;
            Double totalCore = 0d;
            Double w;
            try{
                String[] sizeArr = StringUtils.split(mainMaterial.getSize().getName(), "x");
                w = Double.valueOf(sizeArr[sizeArr.length-1]) / 1000;
                for(Importproduct importproduct : producedProducts){
                    tempProducedKg += importproduct.getQuantity2Pure();
                    tempProducedM += importproduct.getQuantity1() != null ? importproduct.getQuantity1() : 0d;
                    if(importproduct.getCore() != null){
//                        totalCore += Double.valueOf(importproduct.getCore());
                    }
                }
            }catch (Exception e){
                log.error(e.getMessage(),e);
                w = 0d;
            }

            dto.setTotalStick((tempProducedKg - totalCore) - (totalMain - cut));
            dto.setProductsKg(tempProducedKg);
            dto.setProductsM2(tempProducedM * w);
        }
    }

    private void addData2Model(ModelAndView mav){
        List<Warehouse> warehouses = new ArrayList<Warehouse>();
        if(SecurityUtils.getPrincipal().getWarehouseID()!=null){
            Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
            warehouses.add(warehouse);
        }else{
            warehouses = this.warehouseService.findByStatus(Constants.TPK_USER_ACTIVE);
        }
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


    private void exportProduction2Excel(ProducedProductBean bean, HttpServletRequest request, HttpServletResponse response) {
        try{
            List<Quality> qualities = this.qualityService.findAll();
            String outputFileName = "/files/temp/BaoCaoSanXuat" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/BaoCaoSanXuat.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);

            WritableSheet sheet = workbook.getSheet(0);

            WritableFont normalFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    Colour.BLACK);
            WritableCellFormat normalFormat = new WritableCellFormat(normalFont);
            normalFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            normalFormat.setAlignment(Alignment.CENTRE);
            normalFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
            normalFormat.setWrap(true);
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            DecimalFormat decimalFormat2 = new DecimalFormat("###,###.###");

            int startRow = 4;
            int stt = 1;

            Double materialKg = 0d;
            Double materialM = 0d;
            Double materialCutOff = 0d;
            Double productKg = 0d;
            Double overallQuality = 0d;
            Map<Long,Double> mapQuality = new HashMap<Long, Double>();
            String originName;
            for(ProducedProductDTO tableList : bean.getListResult()){
                int index = 0;
                originName = "";
                Importproduct mainMaterial = tableList.getMainMaterial();
                if(mainMaterial != null && mainMaterial.getOrigin() != null){
                    originName = mainMaterial.getOrigin().getName();
                }else if(mainMaterial != null && mainMaterial.getMainUsedMaterial() != null && mainMaterial.getMainUsedMaterial().getOrigin() != null){
                    originName = mainMaterial.getMainUsedMaterial().getOrigin().getName();
                }
                Double totalStick = tableList.getTotalStick() != null ? tableList.getTotalStick() : 0d;
                Double productsKg = tableList.getProductsKg() != null ? tableList.getProductsKg() : 0d;
                Double productsM2 = tableList.getProductsM2() != null ? tableList.getProductsM2() : 0d;
                Double mQualityPure =  mainMaterial.getImportBack() != null ? mainMaterial.getQuantity2Pure() - mainMaterial.getImportBack() : mainMaterial.getQuantity2Pure();
                Double kgOkg = mQualityPure != null && mQualityPure != 0 ? totalStick / mQualityPure : 0d;
                materialKg += mQualityPure;
                Double quantity1 = mainMaterial.getQuantity1() != null ? mainMaterial.getQuantity1() : 0d;
                materialM += quantity1;
                Double cutOff = mainMaterial.getCutOff() != null ? mainMaterial.getCutOff() : 0d;
                materialCutOff += cutOff;
                for(Importproduct product : tableList.getProducedProducts()){
                    CellValue[] res = new CellValue[23];
                    int i = 0;
                    Timestamp saveDate = product.getProduceDate() != null ? product.getProduceDate() : product.getImportDate() != null ? product.getImportDate() : null;
                    res[i++] = new CellValue(CellDataType.STRING, stt++);
                    res[i++] = new CellValue(CellDataType.STRING, saveDate != null ? DateUtils.date2String(saveDate,"dd/MM/yyyy") : "");
                    if(index == 0){
                        res[i++] = new CellValue(CellDataType.STRING, mainMaterial.getProductname().getName());
                        res[i++] = new CellValue(CellDataType.STRING, mainMaterial.getSize() != null ? mainMaterial.getSize().getName() : "");
                        res[i++] = new CellValue(CellDataType.STRING, mainMaterial.getProductCode());
                        res[i++] = new CellValue(CellDataType.STRING, originName);
                        res[i++] = new CellValue(CellDataType.STRING, mQualityPure > 0 ? decimalFormat.format(mQualityPure)  : "");
                        res[i++] = new CellValue(CellDataType.STRING, quantity1 > 0 ? decimalFormat.format(quantity1)  : "");
                        res[i++] = new CellValue(CellDataType.STRING, cutOff > 0 ? decimalFormat.format(cutOff)  : "");
                    }else{
                        res[i++] = new CellValue(CellDataType.STRING, "");
                        res[i++] = new CellValue(CellDataType.STRING, "");
                        res[i++] = new CellValue(CellDataType.STRING, "");
                        res[i++] = new CellValue(CellDataType.STRING, "");
                        res[i++] = new CellValue(CellDataType.STRING, "");
                        res[i++] = new CellValue(CellDataType.STRING, "");
                        res[i++] = new CellValue(CellDataType.STRING, "");
                    }
                    String az = product.getThickness() != null ? product.getThickness().getName() : null;
                    res[i++] = new CellValue(CellDataType.STRING, az != null ? product.getProductname().getName() + "(" + az + ")" : product.getProductname().getName());
                    res[i++] = new CellValue(CellDataType.STRING, product.getProductCode());
                    Double qualityPure = product.getQuantity2Pure() != null ? product.getQuantity2Pure() : 0d;
                    res[i++] = new CellValue(CellDataType.STRING, qualityPure > 0 ? decimalFormat.format(qualityPure)  : "");
                    productKg += qualityPure;
                    res[i++] = new CellValue(CellDataType.STRING, product.getCore() != null ? product.getCore() : "");
                    Double totalQuality = 0d;
                    for(Quality quality : qualities){
                        Double subQuality = product.getQualityQuantityMap().get(quality.getQualityID()) != null ? product.getQualityQuantityMap().get(quality.getQualityID()) : 0d;
                        res[i++] = new CellValue(CellDataType.STRING, subQuality > 0 ? decimalFormat.format(subQuality)  : "");
                        totalQuality += subQuality;

                        if(!mapQuality.containsKey(quality.getQualityID())){
                            mapQuality.put(quality.getQualityID(),subQuality);
                        }else{
                            mapQuality.put(quality.getQualityID(),subQuality + mapQuality.get(quality.getQualityID()));
                        }
                    }
                    overallQuality += totalQuality;
                    res[i++] = new CellValue(CellDataType.STRING, totalQuality != 0 ? decimalFormat2.format(totalQuality)  : "");
                    res[i++] = new CellValue(CellDataType.STRING, kgOkg != 0 ? decimalFormat2.format(kgOkg)  : "");
                    res[i++] = new CellValue(CellDataType.STRING, kgOkg != 0 ? decimalFormat2.format(kgOkg * qualityPure / (totalQuality * WebCommonUtils.productWidth(product.getSize().getName())))  : "");
                    res[i++] = new CellValue(CellDataType.STRING, totalQuality != 0 ? decimalFormat2.format(qualityPure / totalQuality)  : "");
                    res[i++] = new CellValue(CellDataType.STRING, product.getNote() != null ? product.getNote() : "");
                    String team = product.getImportproductbill().getProductionPlan() != null ? product.getImportproductbill().getProductionPlan().getShift().getName() + " - " + product.getImportproductbill().getProductionPlan().getTeam().getName() : "";
                    res[i++] = new CellValue(CellDataType.STRING, team);
                    ExcelUtil.addRow(sheet, startRow++, res, normalFormat, normalFormat, normalFormat, normalFormat);
                    index++;
                }
                int countProduct = tableList.getProducedProducts().size();
                if(countProduct > 1){
                    sheet.mergeCells(2,startRow - countProduct,2,startRow - 1);
                    sheet.mergeCells(3,startRow - countProduct,3,startRow - 1);
                    sheet.mergeCells(4,startRow - countProduct,4,startRow - 1);
                    sheet.mergeCells(5,startRow - countProduct,5,startRow - 1);
                    sheet.mergeCells(6,startRow - countProduct,6,startRow - 1);
                    sheet.mergeCells(7,startRow - countProduct,7,startRow - 1);
                    sheet.mergeCells(8,startRow - countProduct,8,startRow - 1);
                }
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
            sheet.mergeCells(0,startRow,3,startRow);

            Label cuon = new Label(4,startRow,bean.getListResult().size() + " cuộn",boldCenterFormat);
            sheet.addCell(cuon);
            sheet.mergeCells(4,startRow,5,startRow);

            String sMaterialKg = materialKg > 0 ? decimalFormat.format(materialKg)  : "";
            Label lMaterialKg = new Label(6,startRow,sMaterialKg,boldCenterFormat);
            sheet.addCell(lMaterialKg);

            String sMaterialM = materialM > 0 ? decimalFormat.format(materialM)  : "";
            Label lMaterialM = new Label(7,startRow,sMaterialM,boldCenterFormat);
            sheet.addCell(lMaterialM);

            String sMaterialCutOff = materialCutOff > 0 ? decimalFormat.format(materialCutOff)  : "";
            Label lMaterialCutOff = new Label(8,startRow,sMaterialCutOff,boldCenterFormat);
            sheet.addCell(lMaterialCutOff);

            Label blank1 = new Label(9,startRow,"",boldCenterFormat);
            sheet.addCell(blank1);
            sheet.mergeCells(9,startRow,10,startRow);

            String sProductKg = productKg > 0 ? decimalFormat.format(productKg)  : "";
            Label lProductKg = new Label(11,startRow,sProductKg,boldCenterFormat);
            sheet.addCell(lProductKg);

            Label blank2 = new Label(12,startRow,"",boldCenterFormat);
            sheet.addCell(blank2);
            int j = 13;
            for(Quality quality : qualities){
                String sQuality = mapQuality.get(quality.getQualityID()) > 0 ? decimalFormat.format(mapQuality.get(quality.getQualityID()))  : "";
                Label lQuality = new Label(j++,startRow,sQuality,boldCenterFormat);
                sheet.addCell(lQuality);
            }

            String sOverallQuality = overallQuality > 0 ? decimalFormat.format(overallQuality)  : "";
            Label lOverallQuality = new Label(j++,startRow,sOverallQuality,boldCenterFormat);
            sheet.addCell(lOverallQuality);

            Label blank3 = new Label(j,startRow,"",boldCenterFormat);
            sheet.addCell(blank3);
            sheet.mergeCells(j,startRow,j + 4,startRow);

            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }
}
