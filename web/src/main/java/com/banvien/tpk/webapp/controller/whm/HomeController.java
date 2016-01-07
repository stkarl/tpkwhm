package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.ColourBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
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
import java.sql.Timestamp;
import java.util.List;

@Controller
public class HomeController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private MachineService machineService;

    @Autowired
    private MachinecomponentService machinecomponentService;

    @Autowired
    private ImportmaterialService importmaterialService;

    @Autowired
    private ImportproductService importproductService;


    @InitBinder
    public void initBinder(WebDataBinder binder) {
	}
    
    @RequestMapping("/whm/home.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) ColourBean bean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/home");
        try{
            if(SecurityUtils.getPrincipal().getRole().equals(Constants.LANHDAO_ROLE) ||
                    SecurityUtils.getPrincipal().getRole().equals(Constants.QLTT_ROLE) ||
                    SecurityUtils.getPrincipal().getRole().equals(Constants.QLKHO_ROLE) ||
                    SecurityUtils.getPrincipal().getRole().equals(Constants.QLKD_ROLE) ||
                    SecurityUtils.getPrincipal().getRole().equals(Constants.QLKT_ROLE) ||
                    SecurityUtils.getPrincipal().getRole().equals(Constants.TRUONGCA_ROLE) ||
                    SecurityUtils.getPrincipal().getRole().equals(Constants.MODULE_MAY_THIET_BI)){
                if(!SecurityUtils.getPrincipal().getRole().equals(Constants.MODULE_MAY_THIET_BI) && !SecurityUtils.getPrincipal().getRole().equals(Constants.QLKT_ROLE)){
                    List<Importmaterial> warningMaterials = this.importmaterialService.findWarningMaterial(SecurityUtils.getPrincipal().getWarehouseID());
                    List<Importproduct> warningProducts = this.importproductService.findWarningProduct(SecurityUtils.getPrincipal().getWarehouseID());
                    mav.addObject("warningMaterials",warningMaterials);
                    mav.addObject("warningProducts",warningProducts);
                }
                List<Machine> warningMachines = this.machineService.findWarningMachine(SecurityUtils.getPrincipal().getWarehouseID());
                List<Machinecomponent> warningComponents = this.machinecomponentService.findWarningComponent(SecurityUtils.getPrincipal().getWarehouseID());

                for(Machine machine : warningMachines){
                    if(machine.getLastMaintenanceDate() != null && machine.getNextMaintenance() != null){
                        machine.setNeedMaintainDate(new Timestamp(machine.getLastMaintenanceDate().getTime() + Constants.A_DAY * machine.getNextMaintenance()));
                    }
                }

                for(Machinecomponent machinecomponent : warningComponents){
                    if(machinecomponent.getLastMaintenanceDate() != null && machinecomponent.getNextMaintenance() != null){
                        machinecomponent.setNeedMaintainDate(new Timestamp(machinecomponent.getLastMaintenanceDate().getTime() + Constants.A_DAY * machinecomponent.getNextMaintenance()));
                    }
                }
                mav.addObject("warningMachines",warningMachines);
                mav.addObject("warningComponents",warningComponents);
            }
        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }


		mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
	}
}
