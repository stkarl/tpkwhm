package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.ImportMaterialDataDTO;
import com.banvien.tpk.core.dto.ImportmaterialbillBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.core.util.CacheUtil;
import com.banvien.tpk.core.util.GeneratorUtils;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.RequestUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.*;


@Controller
public class ImportMaterialBillController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());
    private static final String MATERIAL_QUICK_IMPORT_KEY = "MaterialQuickImportKey";


    @Autowired
    private ImportmaterialbillService importmaterialbillService;

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
    private WarehouseMapService warehouseMapService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));

//        binder.registerCustomEditor(Timestamp.class, new CustomDateEditor("dd/MM/yyyy"));
    }
    
    @RequestMapping("/whm/importmaterialbill/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportmaterialbillBean bean, BindingResult bindingResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/whm/importmaterialbill/edit");

		String crudaction = bean.getCrudaction();
		Importmaterialbill pojo = bean.getPojo();
        Warehouse warehouse = new Warehouse();
        warehouse.setWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        pojo.setWarehouse(warehouse);
        bean.setLoginID(SecurityUtils.getLoginUserId());

		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				if(!bindingResult.hasErrors()) {
					if(pojo.getImportMaterialBillID() != null && pojo.getImportMaterialBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.update"));
						this.importmaterialbillService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isUpdate=true");
                    } else {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.create"));
						this.importmaterialbillService.addNew(bean);
                        mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isAdd=true");
                    }
                    return mav;
                }
			}catch (ObjectNotFoundException oe) {
				logger.error(oe.getMessage());
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
                mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isError=true");
            }catch (DuplicateException de) {
				logger.error(de.getMessage());
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
                mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isError=true");
            }catch(Exception e) {
				logger.error(e.getMessage(), e);
                mav.addObject("alertType", "error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isError=true");
            }
		}

        if(!bindingResult.hasErrors() && bean.getPojo().getImportMaterialBillID() != null &&bean.getPojo().getImportMaterialBillID() > 0){
            try {
                Importmaterialbill itemObj = this.importmaterialbillService.findById(pojo.getImportMaterialBillID());
                bean.setPojo(itemObj);
                setEditable(bean.getPojo());
                mav.addObject("importMaterials", itemObj.getImportMaterials());
            }
            catch (Exception e) {
                logger.error("Could not found item " + bean.getPojo().getImportMaterialBillID(), e);
            }
        }else{
            if(bean.getPojo().getCode() == null){
                bean.getPojo().setCode(GeneratorUtils.generatePNKPLCode());
            }

            String sessionId = request.getSession().getId();
            List<ImportMaterialDataDTO> importMaterialDataDTOs = (List<ImportMaterialDataDTO>) CacheUtil.getInstance().getValue(sessionId + MATERIAL_QUICK_IMPORT_KEY);
            CacheUtil.getInstance().remove(sessionId + MATERIAL_QUICK_IMPORT_KEY);
            if(importMaterialDataDTOs != null && importMaterialDataDTOs.size() > 0) {
                try {
                    List<Importmaterial> importMaterials = convertData2Show(importMaterialDataDTOs);
                    mav.addObject("importMaterials", importMaterials);
                }
                catch (Exception e) {
                    logger.error("Can not prepare data to view", e);
                }
            }
        }
        addData2Model(mav,bean);
		mav.addObject(Constants.FORM_MODEL_KEY, bean);
		return mav;
	}

    private List<Importmaterial> convertData2Show(List<ImportMaterialDataDTO> importMaterialDataDTOs) {
        List<Importmaterial> importMaterials = new ArrayList<Importmaterial>();
        Material material = new Material();
        material.setMaterialID(importMaterialDataDTOs.get(0).getMaterialID());
        Origin origin = new Origin();
        origin.setOriginID(importMaterialDataDTOs.get(0).getOriginID());
        for(ImportMaterialDataDTO importMaterialDataDTO : importMaterialDataDTOs){
            Importmaterial importmaterial = new Importmaterial();
            importmaterial.setMaterial(material);
            importmaterial.setOrigin(origin);
            importmaterial.setCode(importMaterialDataDTO.getCode());
            importmaterial.setQuantity(Double.valueOf(importMaterialDataDTO.getTotal()));
            if(StringUtils.isNotBlank(importMaterialDataDTO.getExpiredDate())){
                importmaterial.setExpiredDate(new Timestamp(DateUtils.string2Date(importMaterialDataDTO.getExpiredDate(), "dd/MM/yyyy").getTime()));
            }
            importMaterials.add(importmaterial);
        }
        return importMaterials;
    }

    private void setEditable(Importmaterialbill importmaterialbill){
        if(!importmaterialbill.getStatus().equals(Constants.CONFIRMED)
                && SecurityUtils.getLoginUserId().equals(importmaterialbill.getCreatedBy().getUserID())){
            importmaterialbill.setEditable(Boolean.TRUE);
        }
    }

    private void addData2Model(ModelAndView mav, ImportmaterialbillBean bean) {
        mav.addObject("markets", marketService.findAll());
        mav.addObject("customers", customerService.findAll());
        mav.addObject("warehouses", warehouseService.findAllActiveWarehouseExcludeID(null));
        mav.addObject("materials", materialService.findNoneMeasurement());
        mav.addObject("units", unitService.findAll());
        mav.addObject("origins", originService.findAll());
        List<WarehouseMap> warehouseMaps = new ArrayList<WarehouseMap>();
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            warehouseMaps = this.warehouseMapService.findByWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        }
        mav.addObject("warehouseMaps",warehouseMaps);
        bean.setLoginID(SecurityUtils.getLoginUserId());

    }


    @RequestMapping(value={"/whm/importmaterialbill/list.html"})
    public ModelAndView list(@ModelAttribute(Constants.LIST_MODEL_KEY) ImportmaterialbillBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/importmaterialbill/list");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = importmaterialbillService.deleteItems(bean.getCheckList());
				mav.addObject("totalDeleted", totalDeleted);
			}catch (Exception e) {
				log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
			}
		}
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        addData2Model(mav,bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        countNoBillofMonth(mav);
        return mav;
    }

    private void countNoBillofMonth(ModelAndView mav) {
        List<Importmaterialbill> allBills = this.importmaterialbillService.findAllByOrderAndDateLimit("importDate",Constants.A_MONTH*6);
        Map<Long,String> mapBillNoInMonth = new HashMap<Long, String>();
        if(allBills != null && allBills.size() > 0){
            Map<String,List<Importmaterialbill>> mapMonthBills = new HashMap<String, List<Importmaterialbill>>();
            for(Importmaterialbill bill : allBills){
                String billDate = DateUtils.date2String(bill.getImportDate(), "MM/yyyy") ;
                if(mapMonthBills.get(billDate) != null){
                    mapMonthBills.get(billDate).add(bill);
                }else{
                    List<Importmaterialbill> bills = new LinkedList<Importmaterialbill>();
                    bills.add(bill);
                    mapMonthBills.put(billDate,bills);
                }
            }

            for(String month : mapMonthBills.keySet()){
                List<Importmaterialbill> bills = mapMonthBills.get(month);
                Integer counter = 1;
                for(Importmaterialbill bill : bills){
                    mapBillNoInMonth.put(bill.getImportMaterialBillID(), "#" + counter + "-" + month);
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

    private void executeSearch(ImportmaterialbillBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.importmaterialbillService.search(bean);
        List<Importmaterialbill> importproductbills = (List<Importmaterialbill>)results[1];
        for(Importmaterialbill importmaterialbill : importproductbills){
            setEditable(importmaterialbill);
        }
        bean.setListResult((List<Importmaterialbill>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    @RequestMapping("/whm/importmaterialbill/view.html")
    public ModelAndView view(@ModelAttribute(Constants.FORM_MODEL_KEY) ImportmaterialbillBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/importmaterialbill/view");

        String crudaction = bean.getCrudaction();
        Importmaterialbill pojo = bean.getPojo();
        bean.setLoginID(SecurityUtils.getLoginUserId());
        if(!bindingResult.hasErrors()) {
            if (StringUtils.isNotBlank(crudaction) && crudaction.equals("reject")){
                try {
                    if(pojo.getImportMaterialBillID() != null && pojo.getImportMaterialBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.reject"));
                        this.importmaterialbillService.updateReject(bean.getPojo().getNote(),bean.getPojo().getImportMaterialBillID(),SecurityUtils.getLoginUserId());
                        mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isUpdate=true");
                    }
                    return mav;
                }catch(Exception e) {
                    logger.error(e.getMessage(), e);
                    mav.addObject("alertType", "error");
                    mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                    mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isError=true");
                }
            }else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")){
                try {
                    if(pojo.getImportMaterialBillID() != null && pojo.getImportMaterialBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.approve"));
                        this.importmaterialbillService.updateConfirm(bean);
                        mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isUpdate=true");
                    }
                    return mav;
                }catch(Exception e) {
                    logger.error(e.getMessage(), e);
                    mav.addObject("alertType", "error");
                    mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                    mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isError=true");
                }
            }else if (StringUtils.isNotBlank(crudaction) && crudaction.equals("update-money")){
                try {
                    if(pojo.getImportMaterialBillID() != null && pojo.getImportMaterialBillID() > 0) {
                        if(bean.getPojo().getNote() == null || !StringUtils.isNotBlank(bean.getPojo().getNote()))
                            bean.getPojo().setNote(this.getMessageSourceAccessor().getMessage("msg.approve.money"));
                        this.importmaterialbillService.updateConfirmMoney(bean);
                        mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isUpdate=true");
                    }
                    return mav;
                }catch(Exception e) {
                    logger.error(e.getMessage(), e);
                    mav.addObject("alertType", "error");
                    mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
                    mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isError=true");
                }
            }
            if(bean.getPojo().getImportMaterialBillID() != null &&bean.getPojo().getImportMaterialBillID() > 0){
                try {
                    Importmaterialbill itemObj = this.importmaterialbillService.findById(pojo.getImportMaterialBillID());
                    bean.setPojo(itemObj);
                    mav.addObject("importMaterials", itemObj.getImportMaterials());
                }
                catch (Exception e) {
                    logger.error("Could not found item " + bean.getPojo().getImportMaterialBillID(), e);
                }
            }
        }else{
            mav.addObject("alertType", "error");
            mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            mav = new ModelAndView("redirect:/whm/importmaterialbill/list.html?isError=true");
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }
}
