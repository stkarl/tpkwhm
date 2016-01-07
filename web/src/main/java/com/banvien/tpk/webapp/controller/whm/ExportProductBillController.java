package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.ExportproductBean;
import com.banvien.tpk.core.dto.ExportproductbillBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.core.util.GeneratorUtils;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.dto.CellDataType;
import com.banvien.tpk.webapp.dto.CellValue;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.ExcelUtil;
import com.banvien.tpk.webapp.util.RequestUtil;
import jxl.Workbook;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.write.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.PrintWriter;
import java.lang.Boolean;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.*;


@Controller
public class ExportProductBillController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ExportproductbillService exportproductbillService;

    @Autowired
    private ProductService productService;

    @Autowired
    private UnitService unitService;

    @Autowired
    private CustomerService customerService;

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
    private ExporttypeService exporttypeService;

    @Autowired
    private ImportproductService importproductService;

    @Autowired
    private  ProductionPlanService productionPlanService;

    @Autowired
    private ExportproductService exportproductService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping("/whm/exportrootmaterialbill/edit.html")
    public ModelAndView keKhaiXuatTonDen(@ModelAttribute(Constants.FORM_MODEL_KEY) ExportproductbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/exportrootmaterialbill/edit");

        String crudaction = bean.getCrudaction();
        Exportproductbill pojo = bean.getPojo();
        Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
        pojo.setExportWarehouse(warehouse);
        bean.setLoginID(SecurityUtils.getLoginUserId());
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getExportProductBillID() != null && pojo.getExportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.update"));
                        this.exportproductbillService.updateExportRootMaterialBill(bean);
                        mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isUpdate=true&isBlackProduct="+bean.getIsBlackProduct());
                    } else {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.create"));
                        this.exportproductbillService.addExportRootMaterialBill(bean);
                        mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isAdd=true&isBlackProduct="+bean.getIsBlackProduct());
                    }
                    return mav;
                }
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage());
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }catch (DuplicateException de) {
                logger.error(de.getMessage());
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }
        }
        List<Importproduct> tempSelectedProducts = new ArrayList<Importproduct>();
        if(!bindingResult.hasErrors() && bean.getPojo().getExportProductBillID() != null && bean.getPojo().getExportProductBillID() > 0){
            try {
                Exportproductbill itemObj = this.exportproductbillService.findById(pojo.getExportProductBillID());
                bean.setPojo(itemObj);
                setEditable(bean.getPojo());
                List<Exportproduct> exportproducts = itemObj.getExportproducts();
                mav.addObject("exportProducts", exportproducts);
                for(Exportproduct exportproduct : exportproducts){
                    tempSelectedProducts.add(exportproduct.getImportproduct());
                }
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getExportProductBillID(), e);
            }
        }else{
            if(bean.getPojo().getCode() == null){
                bean.getPojo().setCode(GeneratorUtils.generatePXKTONCode());
            }
        }
        List<Importproduct> blackProducts = new ArrayList<Importproduct>();
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            if(bean.getIsBlackProduct()){
                blackProducts = this.importproductService.findAvailableBlackProductByWarehouse(SecurityUtils.getPrincipal().getWarehouseID());
            }else{
                blackProducts = this.importproductService.findAvailableNoneBlackProductByWarehouse(SecurityUtils.getPrincipal().getWarehouseID());
            }
        }
        if(tempSelectedProducts != null && tempSelectedProducts.size() > 0){
            blackProducts.addAll(tempSelectedProducts);
        }
        mav.addObject("blackProducts", blackProducts);
        addData2Model(mav,bean);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void addData2Model(ModelAndView mav, ExportproductbillBean bean) {
        mav.addObject("customers", customerService.findAll());
        List<Warehouse> warehouses = this.warehouseService.findAllActiveWarehouseExcludeID(SecurityUtils.getPrincipal().getWarehouseID());
        mav.addObject("warehouses", warehouses);
        mav.addObject("exporttypes", exporttypeService.findExcludeCode(Constants.EXPORT_TYPE_BTSC));
        List<ProductionPlan> productionPlans;
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            productionPlans = this. productionPlanService.findActivePlanByWarehouseAndType(SecurityUtils.getPrincipal().getWarehouseID(),Constants.EXPORT_TYPE_SAN_XUAT);
        }else{
            productionPlans = this. productionPlanService.findActivePlanByWarehouseAndType(null,Constants.EXPORT_TYPE_SAN_XUAT);
        }
        mav.addObject("productionplans",productionPlans);
        bean.setLoginID(SecurityUtils.getLoginUserId());
    }


    @RequestMapping(value={"/whm/exportrootmaterialbill/list.html"})
    public ModelAndView danhSachXuatTonDen(@ModelAttribute(Constants.LIST_MODEL_KEY) ExportproductbillBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/exportrootmaterialbill/list");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = exportproductbillService.deleteItems(bean.getCheckList());
                mav.addObject("totalDeleted", totalDeleted);
            }catch (Exception e) {
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        addData2Model(mav,bean);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        countNoBillofMonth(mav, bean.getIsBlackProduct());
        return mav;
    }

    private void countNoBillofMonth(ModelAndView mav, Boolean isBlack) {
        List<Exportproductbill> allBills = this.exportproductbillService.findAllByOrderAndDateLimit("importDate", isBlack, Constants.A_MONTH * 6);
        Map<Long,String> mapBillNoInMonth = new HashMap<Long, String>();
        if(allBills != null && allBills.size() > 0){
            Map<String,List<Exportproductbill>> mapMonthBills = new HashMap<String, List<Exportproductbill>>();
            for(Exportproductbill bill : allBills){
                String billDate = DateUtils.date2String(bill.getExportDate(), "MM/yyyy") ;
                if(mapMonthBills.get(billDate) != null){
                    mapMonthBills.get(billDate).add(bill);
                }else{
                    List<Exportproductbill> bills = new LinkedList<Exportproductbill>();
                    bills.add(bill);
                    mapMonthBills.put(billDate,bills);
                }
            }

            for(String month : mapMonthBills.keySet()){
                List<Exportproductbill> bills = mapMonthBills.get(month);
                Integer counter = 1;
                for(Exportproductbill bill : bills){
                    mapBillNoInMonth.put(bill.getExportProductBillID(), "#" + counter + "-" + month);
                    counter++;
                }
            }
        }
        mav.addObject("mapBillNoInMonth", mapBillNoInMonth);
    }

    private void showAlert(ModelAndView mav,Boolean isAdd, Boolean isUpdate, Boolean isError){
        if(isAdd){
            mav.addObject("alertType","success");
            mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.add.successful"));
        }else if(isUpdate){
            mav.addObject("alertType","success");
            mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.update.successful"));
        }else if(isError){
            mav.addObject("alertType","error");
            mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("error.occur"));
        }

    }

    private void executeSearch(ExportproductbillBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.exportproductbillService.search(bean);
        List<Exportproductbill> exportproductbills = (List<Exportproductbill>)results[1];

        for(Exportproductbill exportproductbill : exportproductbills){
            setEditable(exportproductbill);
        }
        bean.setListResult((List<Exportproductbill>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
    private void setEditable(Exportproductbill exportproductbill){
        if(!exportproductbill.getStatus().equals(Constants.CONFIRMED) && !exportproductbill.getStatus().equals(Constants.CONFIRMED_TRANSFER)
                && SecurityUtils.getLoginUserId().equals(exportproductbill.getCreatedBy().getUserID())){
            exportproductbill.setEditable(Boolean.TRUE);
        }
    }
    @RequestMapping("/whm/exportrootmaterialbill/view.html")
    public ModelAndView view(@ModelAttribute(Constants.FORM_MODEL_KEY) ExportproductbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/exportrootmaterialbill/view");

        String crudaction = bean.getCrudaction();
        Exportproductbill pojo = bean.getPojo();
        bean.setLoginID(SecurityUtils.getLoginUserId());
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if (StringUtils.isNotBlank(crudaction) && crudaction.equals("reject")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getExportProductBillID() != null && pojo.getExportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.reject"));
                        this.exportproductbillService.updateReject(bean.getPojo().getNote(),bean.getPojo().getExportProductBillID(),SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isUpdate=true&isBlackProduct="+bean.getIsBlackProduct());
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }
        }else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getExportProductBillID() != null && pojo.getExportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.confirm"));
                        this.exportproductbillService.updateConfirm(bean);
                        mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isUpdate=true&isBlackProduct="+bean.getIsBlackProduct());
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }
        }else if(StringUtils.isNotBlank(crudaction) && crudaction.equals("approve-transfer")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getExportProductBillID() != null && pojo.getExportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.confirm"));
                        this.exportproductbillService.updateConfirmTransfer(bean);
                        mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isUpdate=true&isBlackProduct="+bean.getIsBlackProduct());
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }
        }else if(StringUtils.isNotBlank(crudaction) && crudaction.equals("reject-transfer")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getExportProductBillID() != null && pojo.getExportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.reject"));
                        this.exportproductbillService.updateRejectTransfer(bean.getPojo().getNote(),bean.getPojo().getExportProductBillID(),SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isUpdate=true&isBlackProduct="+bean.getIsBlackProduct());
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getExportProductBillID() != null &&bean.getPojo().getExportProductBillID() > 0){
            try {
                Exportproductbill itemObj = this.exportproductbillService.findById(pojo.getExportProductBillID());
                bean.setPojo(itemObj);
                mav.addObject("exportProducts", itemObj.getExportproducts());
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getExportProductBillID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }


    @RequestMapping(value="/ajax/getAvailableBlackProduct.html")
    public void getAvailableBlackProduct(@RequestParam(value = "importProductID", required = false) Long importProductID, HttpServletResponse response)  {
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject obj = new JSONObject();
            if(importProductID != null) {
                Importproduct importproduct = this.importproductService.findById(importProductID);
                obj.put("name",importproduct.getProductname().getName());
                if(importproduct.getSize() != null){
                    obj.put("size",importproduct.getSize().getName());
                }
                obj.put("kg",importproduct.getQuantity2Pure());
                obj.put("cutOff",importproduct.getCutOff());
                obj.put("importBack",importproduct.getImportBack());
                if(importproduct.getProductname().getCode() != null && importproduct.getProductname().getCode().equals(Constants.PRODUCT_BLACK)){
                    obj.put("origin",importproduct.getOrigin() != null ? importproduct.getOrigin().getName() : "");
                }else{
                    obj.put("origin",importproduct.getColour() != null ? importproduct.getColour().getName() : (importproduct.getThickness() != null ? importproduct.getThickness().getName() : ""));
                    obj.put("met",importproduct.getQuantity1());
                }
            }
            out.print(obj);
            out.flush();
            out.close();
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    @RequestMapping("/whm/viewbyplan/exportproduct.html")
    public ModelAndView viewExportProductByPlan(@ModelAttribute(Constants.FORM_MODEL_KEY) ExportproductBean bean, BindingResult bindingResult,
                                                HttpServletRequest request,HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/viewbyplan/exportproduct");
        String crudaction = bean.getCrudaction();
        if(!bindingResult.hasErrors() && bean.getProductionPlanID() != null){
            try {
                ProductionPlan plan = this.productionPlanService.findByIdNoCommit(bean.getProductionPlanID());
                List<Importproduct> importproducts = this.exportproductService.findExportByPlan(bean.getProductionPlanID());
                mav.addObject("importproducts", importproducts);
                mav.addObject("plan", plan);
                if(StringUtils.isNotBlank(crudaction) && crudaction.equals("export")){
                    exportExportProduct2Excel(plan, importproducts, request, response);
                }
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getProductionPlanID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void exportExportProduct2Excel(ProductionPlan plan, List<Importproduct> importproducts, HttpServletRequest request, HttpServletResponse response) {
        try{
            String outputFileName = "/files/temp/PhieuXuatTon" + System.currentTimeMillis() + ".xls";
            String reportTemplate = request.getSession().getServletContext().getRealPath("/files/export/ExportProductTemplate.xls");
            String export2FileName = request.getSession().getServletContext().getRealPath(outputFileName);

            Workbook templateWorkbook = Workbook.getWorkbook(new File(reportTemplate));
            WritableWorkbook workbook = Workbook.createWorkbook(new File(export2FileName), templateWorkbook);

            WritableSheet sheet = workbook.getSheet(0);

            WritableFont normalFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.NO_BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    jxl.format.Colour.BLACK);

            WritableFont boldFont = new WritableFont(WritableFont.TIMES, 12,
                    WritableFont.BOLD, false,
                    UnderlineStyle.NO_UNDERLINE,
                    jxl.format.Colour.BLACK);
            WritableCellFormat normalFormat = new WritableCellFormat(normalFont);
            normalFormat.setAlignment(jxl.write.Alignment.CENTRE);
            normalFormat.setWrap(true);
            normalFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            DecimalFormat decimalFormat = new DecimalFormat("###,###");

            WritableCellFormat filterFormat = new WritableCellFormat(normalFont);

            WritableCellFormat headerFormat = new WritableCellFormat(boldFont);
            headerFormat.setAlignment(jxl.write.Alignment.CENTRE);
            headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
            headerFormat.setWrap(true);
            headerFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            headerFormat.setBackground(Colour.GREY_25_PERCENT);
            Label planL = new Label(1, 1, plan.getName(), filterFormat);
            sheet.addCell(planL);

            if(!importproducts.get(0).getProductname().getCode().equals(Constants.PRODUCT_BLACK)){
                Label productSpecific = new Label(6, 3, "Chủng loại SP", headerFormat);
                sheet.addCell(productSpecific);
            }

            int startRow = 4;
            int stt = 1;
            String originName;
            Double met = 0d;
            Double pure = 0d;
            for(Importproduct importproduct : importproducts){
                CellValue[] res = new CellValue[7];
                int i = 0;
                res[i++] = new CellValue(CellDataType.STRING, stt++);
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getProductname().getName());
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getProductCode() != null ? importproduct.getProductCode() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getSize() != null ? importproduct.getSize().getName() : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity1() != null ? decimalFormat.format(importproduct.getQuantity1())  : "");
                res[i++] = new CellValue(CellDataType.STRING, importproduct.getQuantity2Pure() != null ? decimalFormat.format(importproduct.getQuantity2Pure())  : "");
                if(importproducts.get(0).getProductname().getCode().equals(Constants.PRODUCT_BLACK)){
                    originName = importproduct.getOrigin() != null ? importproduct.getOrigin().getName() : "";
                }else {
                    originName = importproduct.getThickness() != null ? importproduct.getThickness().getName() : "";
                }
                res[i++] = new CellValue(CellDataType.STRING, originName);
                ExcelUtil.addRow(sheet, startRow++, res, normalFormat, normalFormat, normalFormat, normalFormat);
                met +=  importproduct.getQuantity1() != null ? importproduct.getQuantity1() : 0d;
                pure +=  importproduct.getQuantity2Pure() != null ? importproduct.getQuantity2Pure() : 0d;
            }

            WritableCellFormat boldCenterFormat = new WritableCellFormat(boldFont);
            boldCenterFormat.setWrap(true);
            boldCenterFormat.setAlignment(jxl.write.Alignment.CENTRE);
            boldCenterFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

            Label tong = new Label(0,startRow,"Tổng",boldCenterFormat);
            sheet.addCell(tong);
            sheet.mergeCells(0,startRow,2,startRow);

            Label cuon = new Label(3,startRow,importproducts.size() + " cuộn", boldCenterFormat);
            sheet.addCell(cuon);

            Label lMet = new Label(4,startRow, decimalFormat.format(met), boldCenterFormat);
            sheet.addCell(lMet);

            Label lPure = new Label(5,startRow, decimalFormat.format(pure), boldCenterFormat);
            sheet.addCell(lPure);

            Label blank = new Label(6,startRow, "", boldCenterFormat);
            sheet.addCell(blank);

            workbook.write();
            workbook.close();
            response.sendRedirect(request.getSession().getServletContext().getContextPath() + outputFileName);
        }
        catch(Exception ex){
            logger.error(ex.getMessage(), ex);
        }
    }

    @RequestMapping("/whm/exportproductbill/editbook.html")
    public ModelAndView editExportBook(@ModelAttribute(Constants.FORM_MODEL_KEY) ExportproductbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/exportproductbill/editbook");
        String crudaction = bean.getCrudaction();
        Exportproductbill pojo = bean.getPojo();
        Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
        pojo.setExportWarehouse(warehouse);
        bean.setLoginID(SecurityUtils.getLoginUserId());
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getExportProductBillID() != null && pojo.getExportProductBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.update"));
                        this.exportproductbillService.updateExportRootMaterialBill(bean);
                        mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isUpdate=true&isBlackProduct="+bean.getIsBlackProduct());
                    } else {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.create"));
                        this.exportproductbillService.addExportRootMaterialBill(bean);
                        mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isAdd=true&isBlackProduct="+bean.getIsBlackProduct());
                    }
                    return mav;
                }
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage());
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }catch (DuplicateException de) {
                logger.error(de.getMessage());
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html?isError=true&isBlackProduct="+bean.getIsBlackProduct());
            }
        }
        Map<Long,Boolean> tempExportedMap = new HashMap<Long, Boolean>();
        if(!bindingResult.hasErrors() && bean.getPojo().getExportProductBillID() != null && bean.getPojo().getExportProductBillID() > 0){
            try {
                Exportproductbill itemObj = this.exportproductbillService.findById(pojo.getExportProductBillID());
                if(itemObj.getBookProductBill() != null){
                    mav.addObject("bookedProducts", itemObj.getBookProductBill().getBookProducts());
                    bean.setPojo(itemObj);
                    setEditable(bean.getPojo());
                    List<Exportproduct> exportproducts = itemObj.getExportproducts();
                    mav.addObject("exportProducts", exportproducts);
                    for(Exportproduct exportproduct : exportproducts){
                        tempExportedMap.put(exportproduct.getImportproduct().getImportProductID(), Boolean.TRUE);
                    }
                    mav.addObject("tempExportedMap", tempExportedMap);
                }else{
                    return new ModelAndView("redirect:/whm/exportrootmaterialbill/list.html");
                }
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getExportProductBillID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value = "/ajax/product/bringback.html")
    public void confirmSubmittedScoreCardYear(@RequestParam("productid") Long productid,
                                              @RequestParam("exportid") Long exportid,
                                              HttpServletResponse response){
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            if(SecurityUtils.getPrincipal().getRole().equals(Constants.ADMIN_ROLE)){
                Boolean checker = this.exportproductService.updateBringProductBack(productid,exportid);
                if(checker){
                    object.put("msg", "success");
                }
            }
            out.print(object);
            out.flush();
            out.close();
        }catch (Exception e){
            log.error(e.getMessage(),e);
        }
    }
}
