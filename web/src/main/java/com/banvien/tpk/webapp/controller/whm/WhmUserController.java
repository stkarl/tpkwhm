package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.security.DesEncrypterUtils;
import com.banvien.tpk.webapp.editor.PojoEditor;
import com.banvien.tpk.webapp.util.RequestUtil;
import com.banvien.tpk.webapp.validator.UserValidator;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class WhmUserController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private UserService userService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private WarehouseService warehouseService;
    
    @Autowired
    private UserCustomerService userCustomerService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private UserModuleService userModuleService;
    
    @Autowired
    private ModuleService moduleService;

    @Autowired
    private UserMaterialCateService userMaterialCateService;
    
    @Autowired
    private MaterialcategoryService materialcategoryService;

    @Autowired
    private RegionService regionService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Warehouse.class, new PojoEditor(Warehouse.class, "warehouseID", Long.class));

    }

    @RequestMapping("/whm/user/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) UserBean userBean, BindingResult bindingResult, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/user/edit");

		String crudaction = userBean.getCrudaction();
		User pojo = userBean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				//validate
				userValidator.validate(userBean, bindingResult);

				if(!bindingResult.hasErrors()) {
					if(pojo.getUserID() != null && pojo.getUserID() >= 0) {
						this.userService.updateDcdtUser(userBean);
                        mav = new ModelAndView("redirect:/whm/user/list.html?isUpdate=true");
					} else {
						this.userService.addNewDcdtUser(userBean);
                        mav = new ModelAndView("redirect:/whm/user/list.html?isAdd=true");
					}
                    return mav;
				}
			}catch (ObjectNotFoundException oe) {
				logger.error(oe.getMessage());
				mav.addObject("errorMessage", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
			}catch (DuplicateException de) {
				logger.error(de.getMessage());
				mav.addObject("errorMessage", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
			}catch(Exception e) {
				logger.error(e.getMessage(), e);
				mav.addObject("errorMessage", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
			}
		}
		if(!bindingResult.hasErrors()&& userBean.getPojo().getUserID() != null && userBean.getPojo().getUserID() >= 0) {
			try {
				User itemObj = this.userService.findById(pojo.getUserID());
                itemObj.setPassword(DesEncrypterUtils.getInstance().decrypt(itemObj.getPassword()));
                userBean.setPojo(itemObj);
			}
			catch (Exception e) {
				logger.error("Could not found item " + userBean.getPojo().getUserID(), e);
			}
		}
        referenceData(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, userBean);
		return mav;
	}

    @RequestMapping(value={"/whm/user/list.html"})
    public ModelAndView list(UserBean bean, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/user/list");
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = userService.deleteItems(bean.getCheckList());
				mav.addObject("totalDeleted", totalDeleted);
			}catch (Exception e) {
				log.error(e.getMessage(), e);
				mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
			}
		}
        executeSearch(bean, request);
        referenceData(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }

    private void executeSearch(UserBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.userService.searchDCDTUser(bean);
        bean.setListResult((List<User>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
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
    private void referenceData(ModelAndView mav) {
        mav.addObject("warehouses", warehouseService.findAllActiveWarehouseExcludeID(null));
    }


    @RequestMapping(value={"/whm/user/usercustomer.html"})
    public ModelAndView list(CustomerBean bean, HttpServletRequest request, HttpServletResponse response,
                             @RequestParam(value = "isDeleted", required = false) Boolean isDeleted) {
        ModelAndView mav = new ModelAndView("/whm/user/usercustomer");
        if(bean.getUserID() != null){
            User user = this.userService.findByIdNoCommit(bean.getUserID());
            mav.addObject("user", user);
            Map<Long,Boolean> assignedCustomerMap = null;
            try{
                List<UserCustomer> userCustomers = null;
                if(bean.getCrudaction() != null && bean.getCrudaction().equals("update")){
                    this.userCustomerService.addAssignedCustomer(bean.getUserID(), bean.getCustomerIDs());
                    mav.addObject("alertType","success");
                    mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.update.successful"));
                }
                userCustomers = this.userCustomerService.findByUserID(bean.getUserID());
                if(userCustomers != null){
                    List<Customer> assignedCustomers = new ArrayList<Customer>();
                    assignedCustomerMap = new HashMap<Long, Boolean>();
                    for(UserCustomer userCustomer : userCustomers){
                        assignedCustomers.add(userCustomer.getCustomer());
                        assignedCustomerMap.put(userCustomer.getCustomer().getCustomerID(),Boolean.TRUE);
                    }
                    mav.addObject("assignedCustomerMap", assignedCustomerMap);
                    mav.addObject("assignedCustomers", userCustomers);
                }
            }
            catch (Exception e){
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("error.occur"));
            }
            searchCustomer(request,bean, assignedCustomerMap);
            mav.addObject(Constants.LIST_MODEL_KEY, bean);
        }else{
            mav = new ModelAndView("redirect:/whm/user/list.html");
        }
        mav.addObject("regions",regionService.findAll());
        if(isDeleted != null && isDeleted){
            mav.addObject("alertType","success");
            mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("delete.successful"));
        }
        return mav;
    }

    private void searchCustomer(HttpServletRequest request, CustomerBean customerBean, Map<Long, Boolean> assignedCustomerMap){
        RequestUtil.initSearchBean(request, customerBean);
        customerBean.setMaxPageItems(Integer.MAX_VALUE);
        Object[] results = this.customerService.search(customerBean);
        List<Customer> customers  = (List<Customer>)results[1];
        customers = filterOutCustomer(customers, assignedCustomerMap);
        customerBean.setListResult(customers);
        Integer total = Integer.valueOf(results[0].toString());
        if(assignedCustomerMap != null){
            total -= assignedCustomerMap.size();
        }
        customerBean.setTotalItems(total);
    }

    private List<Customer> filterOutCustomer(List<Customer> customers, Map<Long, Boolean> assignedCustomerMap) {
        List<Customer> result = new ArrayList<Customer>();
        if(assignedCustomerMap != null){
            for(Customer customer : customers){
                if(!assignedCustomerMap.containsKey(customer.getCustomerID())){
                    result.add(customer);
                }
            }
        }else {
            result.addAll(customers);
        }
        return result;
    }

    @RequestMapping(value="/ajax/removeUserCustomer.html")
    public void getProvinceByRegion(@RequestParam(value = "userCustomerID", required = true) Long userCustomerID, HttpServletResponse response)  {
        try{
            this.userCustomerService.deleteItem(userCustomerID);
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    @RequestMapping(value={"/whm/user/usermodule.html"})
    public ModelAndView userModule(ModuleBean bean, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/user/usermodule");
        if(bean.getUserID() != null){
            User user = this.userService.findByIdNoCommit(bean.getUserID());
            mav.addObject("user", user);
            try{
                List<UserModule> userModules = null;
                if(bean.getCrudaction() != null && bean.getCrudaction().equals("update")){
                    userModules = this.userModuleService.updateAssignedModule(bean.getUserID(), bean.getModuleIDs());
                    mav.addObject("alertType","success");
                    mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.update.successful"));
                }else{
                    userModules = this.userModuleService.findByUserID(bean.getUserID());
                }
                if(userModules != null){
                    Map<Long,Boolean> assignedModules = new HashMap<Long, Boolean>();
                    for(UserModule userModule : userModules){
                        assignedModules.put(userModule.getModule().getModuleID(),Boolean.TRUE);
                    }
                    mav.addObject("assignedModules", assignedModules);
                }
            }
            catch (Exception e){
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("error.occur"));
            }
            searchModule(request, bean);
            mav.addObject(Constants.LIST_MODEL_KEY, bean);
        }else{
            mav = new ModelAndView("redirect:/whm/user/list.html");
        }
        return mav;
    }

    private void searchModule(HttpServletRequest request,ModuleBean moduleBean){
        RequestUtil.initSearchBean(request, moduleBean);
        Object[] results = this.moduleService.search(moduleBean);
        moduleBean.setListResult((List<Module>)results[1]);
        moduleBean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    @RequestMapping(value={"/whm/user/usermaterialcate.html"})
    public ModelAndView userMaterialCate(MaterialcategoryBean bean, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/user/usermaterialcate");
        if(bean.getUserID() != null){
            User user = this.userService.findByIdNoCommit(bean.getUserID());
            mav.addObject("user", user);
            try{
                List<UserMaterialCate> userMaterialCates = null;
                if(bean.getCrudaction() != null && bean.getCrudaction().equals("update")){
                    userMaterialCates = this.userMaterialCateService.updateAssignedMaterialCate(bean.getUserID(), bean.getMaterialCateIDs());
                    mav.addObject("alertType","success");
                    mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.update.successful"));
                }else{
                    userMaterialCates = this.userMaterialCateService.findByUserID(bean.getUserID());
                }
                if(userMaterialCates != null){
                    Map<Long,Boolean> assignedMaterialCates = new HashMap<Long, Boolean>();
                    for(UserMaterialCate userMaterialCate : userMaterialCates){
                        assignedMaterialCates.put(userMaterialCate.getMaterialCategory().getMaterialCategoryID(),Boolean.TRUE);
                    }
                    mav.addObject("assignedMaterialCates", assignedMaterialCates);
                }
            }
            catch (Exception e){
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("error.occur"));
            }
            searchMaterialCate(request, bean);
            mav.addObject(Constants.LIST_MODEL_KEY, bean);
        }else{
            mav = new ModelAndView("redirect:/whm/user/list.html");
        }
        return mav;
    }

    private void searchMaterialCate(HttpServletRequest request,MaterialcategoryBean materialcategoryBean){
        RequestUtil.initSearchBean(request, materialcategoryBean);
        Object[] results = this.materialcategoryService.search(materialcategoryBean);
        materialcategoryBean.setListResult((List<Materialcategory>)results[1]);
        materialcategoryBean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
}
