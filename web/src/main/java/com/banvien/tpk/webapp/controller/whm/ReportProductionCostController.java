package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ReportProductionCostController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private SizeService sizeService;

    @Autowired
    private ExportmaterialService exportMaterialService;

    @Autowired
    private ProductionPlanService productionPlanService;

    @Autowired
    private ProductnameService productnameService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/production/cost.html"})
    public ModelAndView searchProductionCost(SearchProductionCostBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/production/cost");
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        String crudaction = bean.getCrudaction();
        try {
            if(crudaction != null && StringUtils.isNotBlank(crudaction)){
                Object[] objects = this.exportMaterialService.reportProductionCost(bean);
                if(objects != null){
                    SummaryCostDTO result = (SummaryCostDTO) objects[0];
                    SummaryCostByProductDTO summaryResult = (SummaryCostByProductDTO) objects[1];
                    if(crudaction.equalsIgnoreCase("report")){
                        mav.addObject("result",result);
                        mav.addObject("summaryResult",summaryResult);

                    }
                    if(crudaction.equalsIgnoreCase("export")){

                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }
        addData2ModelMaterial(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }


    private void addData2ModelMaterial(ModelAndView mav){
        mav.addObject("sizes", this.sizeService.findAll());
        mav.addObject("productNames", this.productnameService.findAll());
        mav.addObject("productionPlans", this.productionPlanService.findAll());
    }
}
