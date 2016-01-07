package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.domain.MaterialMeasurement;
import com.banvien.tpk.core.domain.MaterialMeasurement;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.MaterialMeasurementBean;
import com.banvien.tpk.core.dto.MaterialMeasurementBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.MaterialMeasurementService;
import com.banvien.tpk.core.service.MaterialService;
import com.banvien.tpk.core.service.WarehouseService;
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
public class MeasureMaterialController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private MaterialService materialService;

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private MaterialMeasurementService materialMeasurementService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }
    
    @RequestMapping("/whm/materialmeasurement/editlist.html")
	public ModelAndView editlist(@ModelAttribute(Constants.FORM_MODEL_KEY) MaterialMeasurementBean bean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/materialmeasurement/editlist");

		String crudaction = bean.getCrudaction();
        bean.setLoginID(SecurityUtils.getLoginUserId());
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				if(!bindingResult.hasErrors()) {
					this.materialMeasurementService.addNew(bean);
                    mav.addObject("successMessage", this.getMessageSourceAccessor().getMessage("update.successful"));
                    mav = new ModelAndView("redirect:/whm/materialmeasurement/list.html?isUpdate=true");
                    return mav;
                }
			}catch(Exception e) {
				logger.error(e.getMessage(), e);
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
			}
		}
        List<Warehouse> warehouses = new ArrayList<Warehouse>();
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
            warehouses.add(warehouse);
        }else {
            warehouses = this.warehouseService.findByStatus(Constants.TPK_USER_ACTIVE);
        }
        mav.addObject("warehouses", warehouses);
        if(bean.getWarehouseID() == null){
            bean.setWarehouseID(warehouses.get(0).getWarehouseID());
        }
        referenceData(mav);
		mav.addObject(Constants.FORM_MODEL_KEY, bean);
		return mav;
	}

    @RequestMapping("/whm/materialmeasurement/list.html")
    public ModelAndView list(@ModelAttribute(Constants.LIST_MODEL_KEY) MaterialMeasurementBean bean,HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/whm/materialmeasurement/list");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = this.materialMeasurementService.deleteItems(bean.getCheckList());
                mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("alertType","success");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("delete.successful"));
            }catch (Exception e) {
                log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        referenceData(mav);
        List<Warehouse> warehouses = new ArrayList<Warehouse>();
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            Warehouse warehouse = this.warehouseService.findByIdNoCommit(SecurityUtils.getPrincipal().getWarehouseID());
            warehouses.add(warehouse);
        }else {
            warehouses = this.warehouseService.findByStatus(Constants.TPK_USER_ACTIVE);
        }
        mav.addObject("warehouses", warehouses);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }
    private void executeSearch(MaterialMeasurementBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.materialMeasurementService.search(bean);
        bean.setListResult((List<MaterialMeasurement>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void referenceData(ModelAndView mav) {
        List<Material> measureMaterialLanhs = this.materialService.findByCateCode(Constants.MATERIAL_GROUP_MEASURE_LANH);
        List<Material> measureMaterialMaus = this.materialService.findByCateCode(Constants.MATERIAL_GROUP_MEASURE_MAU);
        mav.addObject("materialLanhs", measureMaterialLanhs);
        mav.addObject("measureMaterialMaus", measureMaterialMaus);
    }


    @RequestMapping("/whm/materialmeasurement/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) MaterialMeasurementBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/materialmeasurement/edit");

        String crudaction = bean.getCrudaction();
        MaterialMeasurement pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {

                if(!bindingResult.hasErrors()) {
                    if(pojo.getMaterialMeasurementID() != null && pojo.getMaterialMeasurementID() > 0) {
                        this.materialMeasurementService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/materialmeasurement/list.html?isUpdate=true");
                    }
                    return mav;
                }
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage());
                mav.addObject("alertType","error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }catch (DuplicateException de) {
                logger.error(de.getMessage());
                mav.addObject("alertType","error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors()&& bean.getPojo().getMaterialMeasurementID() != null && bean.getPojo().getMaterialMeasurementID() > 0) {
            try {
                MaterialMeasurement itemObj = this.materialMeasurementService.findById(pojo.getMaterialMeasurementID());
                bean.setPojo(itemObj);
            }
            catch (Exception e) {
                logger.error("Could not found news " + bean.getPojo().getMaterialMeasurementID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
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
