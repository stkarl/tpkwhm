package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.ProductionPlan;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.ProductionPlanBean;
import com.banvien.tpk.core.service.ProductionPlanService;
import com.banvien.tpk.core.service.ShiftService;
import com.banvien.tpk.core.service.TeamService;
import com.banvien.tpk.core.service.WarehouseService;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.RequestUtil;
import com.banvien.tpk.webapp.validator.ProductionPlanValidator;
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
public class ProductionPlanController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ProductionPlanService productionplanService;

    @Autowired
    private ProductionPlanValidator productionplanValidator;

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private ShiftService shiftService;

    @Autowired
    private TeamService teamService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }
    
    @RequestMapping("/whm/productionplan/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) ProductionPlanBean productionplanBean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/productionplan/edit");

		String crudaction = productionplanBean.getCrudaction();
		ProductionPlan pojo = productionplanBean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				//validate
				productionplanValidator.validate(productionplanBean, bindingResult);

				if(!bindingResult.hasErrors()) {
					if(pojo.getProductionPlanID() != null && pojo.getProductionPlanID() > 0) {
						this.productionplanService.updateItem(productionplanBean);
                        mav = new ModelAndView("redirect:/whm/productionplan/list.html?isUpdate=true");
					} else {
						this.productionplanService.addNew(productionplanBean);
                        mav = new ModelAndView("redirect:/whm/productionplan/list.html?isAdd=true");
					}
                    return mav;
				}
			}catch(Exception e) {
				logger.error(e.getMessage(), e);
                mav = new ModelAndView("redirect:/whm/productionplan/list.html?isError=true");
            }
		}
		if(!bindingResult.hasErrors()&& productionplanBean.getPojo().getProductionPlanID() != null && productionplanBean.getPojo().getProductionPlanID() > 0) {
			try {
                ProductionPlan itemObj = this.productionplanService.findById(pojo.getProductionPlanID());
				productionplanBean.setPojo(itemObj);
			}
			catch (Exception e) {
				logger.error("Could not found item " + productionplanBean.getPojo().getProductionPlanID(), e);
			}
		}
        referenceData(mav);
		mav.addObject(Constants.FORM_MODEL_KEY, productionplanBean);
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
        mav.addObject("shifts", this.shiftService.findAll());
        mav.addObject("teams", this.teamService.findAll());

    }


    @RequestMapping(value={"/whm/productionplan/list.html"})
    public ModelAndView list(ProductionPlanBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/productionplan/list");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = productionplanService.deleteItems(bean.getCheckList());
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

    private void getProductionDetail(ModelAndView mav, ProductionPlanBean bean) {
        List<Long> planIds = new ArrayList<Long>();
        for(ProductionPlan plan : bean.getListResult()){
            planIds.add(plan.getProductionPlanID());
        }
        Map<Long, String> mapPlanNote = productionplanService.getProductionDetail(planIds);
        mav.addObject("mapPlanNote", mapPlanNote);
    }

    private void executeSearch(ProductionPlanBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);

        Object[] results = this.productionplanService.search(bean);
        bean.setListResult((List<ProductionPlan>)results[1]);
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
            mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("add.plan.exception.msg"));
        }
    }

    @RequestMapping(value={"/whm/importproductbill/byplan.html"})
    public ModelAndView importProductByPlan(ProductionPlanBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/productionplan/byplan");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        executeSearchActivePlan(bean, request);
        referenceData(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }
    private void executeSearchActivePlan(ProductionPlanBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);

        Object[] results = this.productionplanService.searchActivePlan(bean);
        bean.setListResult((List<ProductionPlan>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    @RequestMapping(value="/ajax/getPlanByType.html")
    public void getDistributorByRegion(@RequestParam(value = "exportTypeCode", required = true) String exportTypeCode, HttpServletResponse response)  {
        try{
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject obj = new JSONObject();
            obj.put("success", true);
            JSONArray array = new JSONArray();
            List<ProductionPlan> plans = this.productionplanService.findActivePlanByWarehouseAndType(SecurityUtils.getPrincipal().getWarehouseID(),exportTypeCode);
            if (plans != null && plans.size() > 0) {
                for (ProductionPlan productionPlan : plans) {
                    JSONObject jsonO = new JSONObject();
                    jsonO.put("productionPlanID", productionPlan.getProductionPlanID());
                    jsonO.put("name", productionPlan.getName());
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

    @RequestMapping(value={"/whm/productionplan/productbyplan.html"})
    public ModelAndView viewExportProductByPlan(ProductionPlanBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/productionplan/productbyplan");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        executeSearch(bean, request);
        referenceData(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/whm/productionplan/importproductbyplan.html"})
    public ModelAndView viewImportExportProductByPlan(ProductionPlanBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/productionplan/importproductbyplan");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        executeSearch(bean, request);
        getProductionDetail(mav,bean);
        referenceData(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/whm/productionplan/materialbyplan.html"})
    public ModelAndView viewExportMaterialByPlan(ProductionPlanBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/productionplan/materialbyplan");
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        bean.setProduce(Boolean.FALSE);
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        executeSearch(bean, request);
        referenceData(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }
}
