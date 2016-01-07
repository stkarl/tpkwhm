package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Machinecomponent;
import com.banvien.tpk.core.domain.Machine;
import com.banvien.tpk.core.domain.Maintenancehistory;
import com.banvien.tpk.core.dto.MachinecomponentBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.MachineService;
import com.banvien.tpk.core.service.MachinecomponentService;
import com.banvien.tpk.core.service.MaintenanceHistoryService;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.editor.PojoEditor;
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
import java.util.ArrayList;
import java.util.List;

@Controller
public class MachineComponentController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private MachinecomponentService machinecomponentService;

    @Autowired
    private MachineService machineService;

    @Autowired
    private MaintenanceHistoryService maintenanceHistoryService;



    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Timestamp.class, new CustomDateEditor("dd/MM/yyyy"));
        binder.registerCustomEditor(Machine.class, new PojoEditor(Machine.class, "machineID", Long.class));
    }
    
    @RequestMapping("/whm/machinecomponent/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) MachinecomponentBean bean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/machinecomponent/edit");

		String crudaction = bean.getCrudaction();
		Machinecomponent pojo = bean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {

				if(!bindingResult.hasErrors()) {
					if(pojo.getMachineComponentID() != null && pojo.getMachineComponentID() > 0) {
						this.machinecomponentService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/machinecomponent/list.html?isUpdate=true");
                    } else {
						this.machinecomponentService.addNew(bean);
                        mav = new ModelAndView("redirect:/whm/machinecomponent/list.html?isAdd=true");
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
        if(!bindingResult.hasErrors()&& bean.getPojo().getMachineComponentID() != null && bean.getPojo().getMachineComponentID() > 0) {
            try {
                Machinecomponent itemObj = this.machinecomponentService.findById(pojo.getMachineComponentID());
                itemObj.setMachine(getMachineOfComponent(itemObj));
                bean.setPojo(itemObj);
            }
            catch (Exception e) {
                logger.error("Could not found news " + bean.getPojo().getMachineComponentID(), e);
            }
        }else if(bean.getPojo().getStatus() == null){
            bean.getPojo().setStatus(Constants.MACHINE_NORMAL);
        }
        addData2Model(mav);
		mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
	}

    private void addData2Model(ModelAndView mav){
        mav.addObject("machines", this.machineService.findAllActiveMachineByWarehouse(SecurityUtils.getPrincipal().getWarehouseID()));
    }



    @RequestMapping(value={"/whm/machinecomponent/list.html"})
    public ModelAndView list(MachinecomponentBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/machinecomponent/list");
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = machinecomponentService.deleteItems(bean.getCheckList());
				mav.addObject("totalDeleted", totalDeleted);
			}catch (Exception e) {
				log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
			}
		}
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        addData2Model(mav);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }

    private void executeSearch(MachinecomponentBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.machinecomponentService.search(bean);
        List<Machinecomponent> machinecomponents = (List<Machinecomponent>)results[1];
        for(Machinecomponent machinecomponent : machinecomponents){
            Machine machine = getMachineOfComponent(machinecomponent);
            machinecomponent.setMachine(machine);
        }
        bean.setListResult(machinecomponents);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }


    private Machine getMachineOfComponent(Machinecomponent machinecomponent) {
        if(machinecomponent.getMachine() != null){
            return machinecomponent.getMachine();
        }else{
            return getMachineOfComponent(machinecomponent.getParent());
        }
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

    @RequestMapping("/whm/machinecomponent/view.html")
    public ModelAndView viewDetail(@ModelAttribute(Constants.FORM_MODEL_KEY) MachinecomponentBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/machinecomponent/view");

        Machinecomponent pojo = bean.getPojo();
        if(!bindingResult.hasErrors()&& bean.getPojo().getMachineComponentID() != null && bean.getPojo().getMachineComponentID() > 0) {
            try {
                Machinecomponent itemObj = this.machinecomponentService.findById(pojo.getMachineComponentID());
                addData2MachineComponent(itemObj);
                bean.setPojo(itemObj);
            }
            catch (Exception e) {
                logger.error("Could not found news " + bean.getPojo().getMachineComponentID(), e);
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    private void addData2MachineComponent(Machinecomponent machinecomponent) {
        Maintenancehistory log = this.maintenanceHistoryService.findLastestMachineComponent(machinecomponent.getMachineComponentID());
        machinecomponent.setLatestMaintenance(log);
    }
}
