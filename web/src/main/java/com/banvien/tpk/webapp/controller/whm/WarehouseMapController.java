package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.domain.WarehouseMap;
import com.banvien.tpk.core.dto.WarehouseMapBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.WarehouseMapService;
import com.banvien.tpk.core.service.WarehouseService;
import com.banvien.tpk.security.SecurityUtils;
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
import java.util.ArrayList;
import java.util.List;

@Controller
public class WarehouseMapController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private WarehouseMapService warehousemapService;

    @Autowired
    private WarehouseService warehouseService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
	}
    
    @RequestMapping("/whm/warehousemap/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) WarehouseMapBean bean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/warehousemap/edit");

		String crudaction = bean.getCrudaction();
		WarehouseMap pojo = bean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				if(!bindingResult.hasErrors()) {
					if(pojo.getWarehouseMapID() != null && pojo.getWarehouseMapID() > 0) {
						this.warehousemapService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/warehousemap/list.html?isUpdate=true");
					} else {
						this.warehousemapService.addNew(bean);
                        mav = new ModelAndView("redirect:/whm/warehousemap/list.html?isAdd=true");
					}
                    return mav;
				}
			}catch (ObjectNotFoundException oe) {
				logger.error(oe.getMessage());
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
			}catch (DuplicateException de) {
				logger.error(de.getMessage());
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
			}catch(Exception e) {
				logger.error(e.getMessage(), e);
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
			}
		}
		if(!bindingResult.hasErrors()&& bean.getPojo().getWarehouseMapID() != null && bean.getPojo().getWarehouseMapID() > 0) {
			try {
                WarehouseMap itemObj = this.warehousemapService.findById(pojo.getWarehouseMapID());
				bean.setPojo(itemObj);
			}
			catch (Exception e) {
				logger.error("Could not found item " + bean.getPojo().getWarehouseMapID(), e);
			}
		}
        referenceData(mav);
		mav.addObject(Constants.FORM_MODEL_KEY, bean);
		return mav;
	}

    private void referenceData(ModelAndView mav) {
        List<Warehouse> warehouses = new ArrayList<Warehouse>();
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
           Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
            warehouses.add(warehouse);
        }else {
            warehouses = this.warehouseService.findByStatus(Constants.TPK_USER_ACTIVE);
        }
        mav.addObject("warehouses", warehouses);
    }


    @RequestMapping(value={"/whm/warehousemap/list.html"})
    public ModelAndView list(WarehouseMapBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/warehousemap/list");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = warehousemapService.deleteItems(bean.getCheckList());
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

    private void executeSearch(WarehouseMapBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.warehousemapService.search(bean);
        bean.setListResult((List<WarehouseMap>)results[1]);
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
}
