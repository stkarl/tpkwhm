package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.LocationHistory;
import com.banvien.tpk.core.domain.WarehouseMap;
import com.banvien.tpk.core.dto.LocationHistoryBean;
import com.banvien.tpk.core.service.LocationHistoryService;
import com.banvien.tpk.core.service.MaterialService;
import com.banvien.tpk.core.service.ProductnameService;
import com.banvien.tpk.core.service.WarehouseMapService;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.RequestUtil;
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
public class LocationHistoryController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private LocationHistoryService locationHistoryService;

    @Autowired
    private MaterialService materialService;

    @Autowired
    private ProductnameService productnameService;

    @Autowired
    private WarehouseMapService warehouseMapService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));

    }

    @RequestMapping(value = "/whm/location/history.html")
    public ModelAndView changeLocationHistory(LocationHistoryBean bean,HttpServletRequest request) {
        if(bean.getToDate() != null){
            bean.setToDate(DateUtils.move2TheEndOfDay((Timestamp) bean.getToDate()));
        }
        bean.setLoginWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        ModelAndView mav = new ModelAndView("/whm/location/history");
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        addData2Model(mav);
        return mav;
    }

    private void addData2Model(ModelAndView mav) {
        List<WarehouseMap> warehouseMaps;
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            warehouseMaps = this.warehouseMapService.findByWarehouseID(SecurityUtils.getPrincipal().getWarehouseID());
        }else{
            warehouseMaps = this.warehouseMapService.findAll();
        }
        mav.addObject("warehouseMaps",warehouseMaps);
        mav.addObject("materials",this.materialService.findNoneMeasurement());
        mav.addObject("productNames",this.productnameService.findAll());
    }

    private void executeSearch(LocationHistoryBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.locationHistoryService.search(bean);
        bean.setListResult((List<LocationHistory>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

   
}
