package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Machine;
import com.banvien.tpk.core.domain.Machinecomponent;
import com.banvien.tpk.core.domain.Maintenancehistory;
import com.banvien.tpk.core.dto.MaintenancehistoryBean;
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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class MaintenanceController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private MaintenanceHistoryService maintenanceHistoryService;

    @Autowired
    private MachineService machineService;

    @Autowired
    private MachinecomponentService machinecomponentService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
        binder.registerCustomEditor(Machine.class, new PojoEditor(Machine.class, "machineID", Long.class));
        binder.registerCustomEditor(Machinecomponent.class, new PojoEditor(Machinecomponent.class, "machineComponentID", Long.class));

    }
    
    @RequestMapping("/whm/maintenance/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) MaintenancehistoryBean bean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/maintenance/edit");

		String crudaction = bean.getCrudaction();
		Maintenancehistory pojo = bean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {

				if(!bindingResult.hasErrors()) {
					if(pojo.getMaintenanceHistoryID() != null && pojo.getMaintenanceHistoryID() > 0) {
						this.maintenanceHistoryService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/maintenance/list.html?isUpdate=true");
                    } else {
						this.maintenanceHistoryService.addNew(bean);
                        mav = new ModelAndView("redirect:/whm/maintenance/list.html?isAdd=true");
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
        if(!bindingResult.hasErrors()&& bean.getPojo().getMaintenanceHistoryID() != null && bean.getPojo().getMaintenanceHistoryID() > 0) {
            try {
                Maintenancehistory itemObj = this.maintenanceHistoryService.findById(pojo.getMaintenanceHistoryID());
                bean.setPojo(itemObj);
            }
            catch (Exception e) {
                logger.error("Could not found news " + bean.getPojo().getMaintenanceHistoryID(), e);
            }
        }

        addData2Model(mav);
		mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
	}

    private void addData2Model(ModelAndView mav){
        List<Machine> machines = this.machineService.findAllActiveMachineByWarehouse(SecurityUtils.getPrincipal().getWarehouseID());
        List<Machinecomponent> machinecomponents = getAllComponentOfMachines(machines);
        mav.addObject("machines", machines);
        mav.addObject("machineComponents", machinecomponents);
    }

    private List<Machinecomponent> getAllComponentOfMachines(List<Machine> machines) {
        List<Machinecomponent> machinecomponents = new ArrayList<Machinecomponent>();
        if(machines != null && machines.size() > 0){
            for(Machine machine : machines){
                if(machine.getMachinecomponents() != null && machine.getMachinecomponents().size() > 0){
                    for(Machinecomponent machinecomponent : machine.getMachinecomponents()){
                        if(machinecomponent.getStatus() != Constants.MACHINE_STOP){
                            machinecomponents.add(machinecomponent);
                            addComponents(machinecomponent,machinecomponents);
                        }
                    }
                }
            }
        }
        return machinecomponents;
    }

    private void addComponents(Machinecomponent machinecomponent, List<Machinecomponent> mainList){
        if(machinecomponent.getChildComponents() != null){
            for(Machinecomponent childComponent : machinecomponent.getChildComponents()){
                if(childComponent.getStatus() != Constants.MACHINE_STOP){
                    mainList.add(childComponent);
                    addComponents(childComponent,mainList);
                }
            }
        }
    }


    @RequestMapping(value={"/whm/maintenance/list.html"})
    public ModelAndView list(MaintenancehistoryBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/maintenance/list");
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = maintenanceHistoryService.deleteItems(bean.getCheckList());
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

    private void executeSearch(MaintenancehistoryBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.maintenanceHistoryService.search(bean);
        bean.setListResult((List<Maintenancehistory>)results[1]);
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
