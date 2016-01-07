package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.ExportmaterialbillBean;
import com.banvien.tpk.core.dto.SearchMaterialBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.core.util.GeneratorUtils;
import com.banvien.tpk.core.util.StringUtil;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.RequestUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
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
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.*;


@Controller
public class ExportMaterialBillController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ExportmaterialbillService exportmaterialbillService;

    @Autowired
    private MaterialService materialService;

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
    private ExporttypeService exporttypeService;

    @Autowired
    private ImportmaterialService importmaterialService;

    @Autowired
    private ProductionPlanService productionPlanService;

    @Autowired
    private MaterialcategoryService materialcategoryService;

    @Autowired
    private MachinecomponentService machinecomponentService;

    @Autowired
    private MachineService machineService;

    @Autowired
    private ExportmaterialService exportmaterialService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping("/whm/exportmaterialbill/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) ExportmaterialbillBean bean, BindingResult bindingResult,
            HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/exportmaterialbill/editbylist");

        String crudaction = bean.getCrudaction();
        Exportmaterialbill pojo = bean.getPojo();
        Warehouse warehouse = null;
        try {
            warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            mav.addObject("alertType", "error");
            mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isError=true");
            return mav;
        }
        pojo.setExportWarehouse(warehouse);
        bean.setLoginID(SecurityUtils.getLoginUserId());
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getExportMaterialBillID() != null && pojo.getExportMaterialBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.update"));
                        this.exportmaterialbillService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isUpdate=true");
                    } else {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.create"));
                        this.exportmaterialbillService.addNew(bean);
                        mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isAdd=true");
                    }
                    return mav;
                }
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage());
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
                mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isError=true");
            }catch (DuplicateException de) {
                logger.error(de.getMessage());
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
                mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isError=true");
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isError=true");
            }
        }
        Map<Long,Exportmaterial> tempSelectedMaterialMap = new HashMap<Long, Exportmaterial>();
        Integer billStatus = null;
        List<Exportmaterial> exportmaterials = new ArrayList<Exportmaterial>();
        if(!bindingResult.hasErrors() && bean.getPojo().getExportMaterialBillID() != null &&bean.getPojo().getExportMaterialBillID() > 0){
            try {
                Exportmaterialbill itemObj = this.exportmaterialbillService.findById(pojo.getExportMaterialBillID());
                billStatus = itemObj.getStatus();
                bean.setPojo(itemObj);
                setEditable(bean.getPojo());
                exportmaterials = itemObj.getExportmaterials();
                for(Exportmaterial exportmaterial : exportmaterials){
                    tempSelectedMaterialMap.put(exportmaterial.getImportmaterial().getImportMaterialID(), exportmaterial);
                }
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getExportMaterialBillID(), e);
            }
        }else{
            if(bean.getPojo().getCode() == null){
                bean.getPojo().setCode(GeneratorUtils.generatePXKPLCode());
            }
        }
        bean.setMaxPageItems(40);
        Object[] materialArr =  executeSearchMaterial(bean,request);
        List<Importmaterial> availabelMaterials = (List<Importmaterial>)materialArr[1];
        Integer totalAvailableMaterial = Integer.valueOf(materialArr[0].toString());
        if(tempSelectedMaterialMap != null && tempSelectedMaterialMap.size() > 0){
            for(Importmaterial importmaterial : availabelMaterials){
                if(tempSelectedMaterialMap.containsKey(importmaterial.getImportMaterialID())){
                    if(!billStatus.equals(Constants.REJECTED)){
                        importmaterial.setRemainQuantity(importmaterial.getRemainQuantity() + tempSelectedMaterialMap.get(importmaterial.getImportMaterialID()).getQuantity());
                    }
                    tempSelectedMaterialMap.remove(importmaterial.getImportMaterialID());
                }
            }
        }
        if(tempSelectedMaterialMap != null && !tempSelectedMaterialMap.isEmpty()){
            for(Exportmaterial exportmaterial : tempSelectedMaterialMap.values()){
                Importmaterial selectedMaterial = exportmaterial.getImportmaterial();
                if(!billStatus.equals(Constants.REJECTED)){
                    if(selectedMaterial.getRemainQuantity() > 0){
                        selectedMaterial.setRemainQuantity(selectedMaterial.getRemainQuantity() + exportmaterial.getQuantity());
                    }else{
                        selectedMaterial.setRemainQuantity(exportmaterial.getQuantity());
                        totalAvailableMaterial++;
                    }
                }
                availabelMaterials.add(selectedMaterial);
                bean.setMaxPageItems(bean.getMaxPageItems() + 1);
            }
        }
        Map<Long,Boolean> mapSelectedMaterial = new HashMap<Long, Boolean>();
        Map<Long,Double> mapSelectedMaterialValue = new HashMap<Long, Double>();
        Map<Long,Double> mapSelectedMaterialPrevValue = new HashMap<Long, Double>();
        for(Exportmaterial exportmaterial : exportmaterials){
            Long importMaterialID = exportmaterial.getImportmaterial().getImportMaterialID();
            exportmaterial.getImportmaterial().setDetailInfo(StringUtil.getDetailMaterialInfo(exportmaterial.getImportmaterial()));
            mapSelectedMaterial.put(importMaterialID,Boolean.TRUE);
            mapSelectedMaterialValue.put(importMaterialID,exportmaterial.getQuantity());
            mapSelectedMaterialPrevValue.put(importMaterialID,exportmaterial.getPrevious());
        }
        mav.addObject("mapSelectedMaterial", mapSelectedMaterial);
        mav.addObject("mapSelectedMaterialValue", mapSelectedMaterialValue);
        mav.addObject("mapSelectedMaterialPrevValue", mapSelectedMaterialPrevValue);
        mav.addObject("exportMaterials", exportmaterials);
        mav.addObject("availableMaterials", availabelMaterials);
        mav.addObject("totalAvailableMaterial", totalAvailableMaterial);
        addData2Model(mav,bean);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private Object[] executeSearchMaterial(ExportmaterialbillBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        SearchMaterialBean searchMaterialBean = new SearchMaterialBean(bean.getFromDate(),bean.getToDate(),bean.getCode(),SecurityUtils.getPrincipal().getWarehouseID(),bean.getMaterialID(),
                bean.getMarketID(),bean.getOriginID(),bean.getExpiredDate(),bean.getMaterialCategoryID(),bean.getFromQuantity(),bean.getToQuantity());
        searchMaterialBean.setFirstItem(bean.getFirstItem());
        searchMaterialBean.setSortDirection(bean.getSortDirection());
        searchMaterialBean.setSortExpression(bean.getSortExpression());
        searchMaterialBean.setMaxPageItems(bean.getMaxPageItems());
        searchMaterialBean.setForExport(Boolean.TRUE);
        searchMaterialBean.setLoginID(SecurityUtils.getLoginUserId());
        Object[] results = this.importmaterialService.searchMaterialsInStock(searchMaterialBean);
        return results;
    }

    private void addData2Model(ModelAndView mav, ExportmaterialbillBean bean) {
        mav.addObject("markets", marketService.findAll());
        mav.addObject("customers", customerService.findAll());
        List<Warehouse> warehouses = null;
        List<Machine> machines = null;
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            warehouses = this.warehouseService.findAllActiveWarehouseExcludeID(SecurityUtils.getPrincipal().getWarehouseID());
            machines = this.machineService.findAllActiveMachineByWarehouse(SecurityUtils.getPrincipal().getWarehouseID());
        }else{
            warehouses = this. warehouseService.findAll();
            machines = this.machineService.findAllActiveMachineByWarehouse(null);
        }
        mav.addObject("machines", machines);
        mav.addObject("warehouses", warehouses);
        mav.addObject("materials", materialService.findAssigned(SecurityUtils.getLoginUserId()));
        mav.addObject("units", unitService.findAll());
        mav.addObject("origins", originService.findAll());
        List<Exporttype> exporttypes = exporttypeService.findAll();
        if(!SecurityUtils.userHasAuthority(Constants.MODULE_XUAT_VT_BD)){
            exporttypes = exporttypeService.findExcludeCode(Constants.EXPORT_TYPE_BTSC);
        }
        if(!SecurityUtils.userHasAuthority(Constants.MODULE_XUAT_VT_SX)){
            exporttypes = exporttypeService.findExcludeCode(Constants.EXPORT_TYPE_SAN_XUAT);
        }
        mav.addObject("exporttypes", exporttypes);
        mav.addObject("materialCategories", materialcategoryService.findAssignedCate(SecurityUtils.getLoginUserId()));

        List<ProductionPlan> productionPlans;
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            productionPlans = this. productionPlanService.findByWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        }else{
            productionPlans = this. productionPlanService.findAll();
        }
        mav.addObject("productionPlans", productionPlans);
        bean.setLoginID(SecurityUtils.getLoginUserId());
    }


    @RequestMapping(value={"/whm/exportmaterialbill/list.html"})
    public ModelAndView list(@ModelAttribute(Constants.LIST_MODEL_KEY) ExportmaterialbillBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/exportmaterialbill/list");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = exportmaterialbillService.deleteItems(bean.getCheckList());
                mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("alertType","success");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.delete.successful"));
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
        countNoBillofMonth(mav);
        return mav;
    }

    private void countNoBillofMonth(ModelAndView mav) {
        List<Exportmaterialbill> allBills = this.exportmaterialbillService.findAllByOrderAndDateLimit("exportDate", Constants.A_MONTH * 6);
        Map<Long,String> mapBillNoInMonth = new HashMap<Long, String>();
        if(allBills != null && allBills.size() > 0){
            Map<String,List<Exportmaterialbill>> mapMonthBills = new HashMap<String, List<Exportmaterialbill>>();
            for(Exportmaterialbill bill : allBills){
                String billDate = DateUtils.date2String(bill.getExportDate(), "MM/yyyy") ;
                if(mapMonthBills.get(billDate) != null){
                    mapMonthBills.get(billDate).add(bill);
                }else{
                    List<Exportmaterialbill> bills = new LinkedList<Exportmaterialbill>();
                    bills.add(bill);
                    mapMonthBills.put(billDate,bills);
                }
            }

            for(String month : mapMonthBills.keySet()){
                List<Exportmaterialbill> bills = mapMonthBills.get(month);
                Integer counter = 1;
                for(Exportmaterialbill bill : bills){
                    mapBillNoInMonth.put(bill.getExportMaterialBillID(), "#" + counter + "-" + month);
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

    private void executeSearch(ExportmaterialbillBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.exportmaterialbillService.search(bean);
        List<Exportmaterialbill> exportmaterialbills = (List<Exportmaterialbill>)results[1];

        for(Exportmaterialbill exportmaterialbill : exportmaterialbills){
            setEditable(exportmaterialbill);
        }
        bean.setListResult(exportmaterialbills);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
    private void setEditable(Exportmaterialbill exportmaterialbill){
        if(!exportmaterialbill.getStatus().equals(Constants.CONFIRMED)
                && SecurityUtils.getLoginUserId().equals(exportmaterialbill.getCreatedBy().getUserID())){
            exportmaterialbill.setEditable(Boolean.TRUE);
        }
    }

    @RequestMapping("/whm/exportmaterialbill/view.html")
    public ModelAndView view(@ModelAttribute(Constants.FORM_MODEL_KEY) ExportmaterialbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/exportmaterialbill/view");

        String crudaction = bean.getCrudaction();
        Exportmaterialbill pojo = bean.getPojo();
        bean.setLoginID(SecurityUtils.getLoginUserId());
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if (StringUtils.isNotBlank(crudaction) && crudaction.equals("reject")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getExportMaterialBillID() != null && pojo.getExportMaterialBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.reject"));
                        this.exportmaterialbillService.updateReject(bean.getPojo().getNote(),bean.getPojo().getExportMaterialBillID(),SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isError=true");
            }
        }else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")){
            try {
                if(!bindingResult.hasErrors()) {
                    if(pojo.getExportMaterialBillID() != null && pojo.getExportMaterialBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.confirm"));
                        this.exportmaterialbillService.updateConfirm(bean);
                        mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/exportmaterialbill/list.html?isError=true");
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getExportMaterialBillID() != null &&bean.getPojo().getExportMaterialBillID() > 0){
            try {
                Exportmaterialbill itemObj = this.exportmaterialbillService.findById(pojo.getExportMaterialBillID());
                bean.setPojo(itemObj);
                for(Exportmaterial em : itemObj.getExportmaterials()){
                    em.getImportmaterial().setDetailInfo(StringUtil.getDetailMaterialInfo(em.getImportmaterial()));
                }
                mav.addObject("exportMaterials", itemObj.getExportmaterials());
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getExportMaterialBillID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value="/ajax/getAvailableMaterial.html")
    public void getAvailableMaterial(@RequestParam(value = "importMaterialID", required = false) Long importMaterialID, HttpServletResponse response)  {
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject obj = new JSONObject();
            Importmaterial importmaterial = null;
            String info = "";
            Double remainQuantity = 0d;
            if(importMaterialID != null) {
                importmaterial = this.importmaterialService.findById(importMaterialID);
            }
            if(importmaterial != null){
                info = StringUtil.getDetailMaterialInfo(importmaterial);
                remainQuantity = importmaterial.getRemainQuantity();
            }
            obj.put("info", info);
            obj.put("remainQuantity",remainQuantity);
            out.print(obj);
            out.flush();
            out.close();
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    @RequestMapping(value="/ajax/getComponentByMachine.html")
    public void getComponentByMachine(@RequestParam(value = "machineID", required = true) Long machineID, HttpServletResponse response)  {
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject obj = new JSONObject();
            obj.put("success", true);
            JSONArray array = new JSONArray();
            List<Machinecomponent> machinecomponents = this.machinecomponentService.findByMachineAndWarehouse(machineID,SecurityUtils.getPrincipal().getWarehouseID());
            if (machinecomponents != null && machinecomponents.size() > 0) {
                for (Machinecomponent machinecomponent : machinecomponents) {
                    JSONObject jsonO = new JSONObject();
                    jsonO.put("machineComponentID", machinecomponent.getMachineComponentID());
                    jsonO.put("name", machinecomponent.getName());
                    array.put(jsonO);
                }
            }
            obj.put("array", array);
            out.print(obj);
            out.flush();
            out.close();
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    @RequestMapping("/whm/viewbyplan/exportmaterial.html")
    public ModelAndView viewExportMaterialByPlan(@ModelAttribute(Constants.FORM_MODEL_KEY) ExportmaterialbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/viewbyplan/exportmaterial");

        if(!bindingResult.hasErrors() && bean.getProductionPlanID() != null){
            try {
                ProductionPlan plan = this.productionPlanService.findByIdNoCommit(bean.getProductionPlanID());
                List<Exportmaterial> exportmaterials = this.exportmaterialService.findExportByPlan(bean.getProductionPlanID());
                mav.addObject("exportmaterials", exportmaterials);
                mav.addObject("plan", plan);
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getProductionPlanID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }
}
