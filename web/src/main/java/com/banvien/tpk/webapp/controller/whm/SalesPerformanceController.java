package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Machine;
import com.banvien.tpk.core.domain.Maintenancehistory;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by KhanhChu on 12/9/2017.
 */
@Controller
public class SalesPerformanceController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private BookProductBillService bookProductBillService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private UserService userService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping(value={"/whm/report/salesPerformance.html"})
    public ModelAndView sellSummary(SalesPerformanceBean bean, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/sales_performance_report");
        if(bean.getToDate() == null){
            bean.setToDate(new Timestamp(System.currentTimeMillis()));
        }else{
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }

        if(bean.getFromDate() == null){
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis(bean.getToDate().getTime());
            calendar.set(Calendar.DATE, 1);
            bean.setFromDate(new Timestamp(calendar.getTimeInMillis()));
        }
        addDatesToView(bean, mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        if((bean.getToDate().getTime() - bean.getFromDate().getTime())/(24 * 3600000L) > 31 ||
                bean.getToDate().getTime() - bean.getFromDate().getTime() < 0){
            mav.addObject("alertType","alert");
            mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("invalid.date.range"));
            return mav;
        }

        if(bean.getCrudaction() != null && "report".equals(bean.getCrudaction())){
            computeSalesPerformance(bean, mav);
        }
        return mav;
    }

    private void addDatesToView(SalesPerformanceBean bean, ModelAndView mav) {
        List<Date> dates = new LinkedList<Date>();
        Date date = bean.getFromDate();
        while(date.before(bean.getToDate())){
            dates.add(date);
            date = DateUtils.addDate(date, 1);
        }
        mav.addObject("dates", dates);
    }

    private void computeSalesPerformance(SalesPerformanceBean bean, ModelAndView mav){
        try {
            List<SalePerformanceDTO> results = bookProductBillService.salesPerformance(bean);
            if(results != null && results.size() > 0){
                mav.addObject("results",results);
            }
        } catch (Exception e) {
            log.error(e.getMessage(),e);
        }
    }

    @RequestMapping(value = "/whm/spBoard.html")
    public ModelAndView salePerformanceBoadr(SalesPerformanceBean bean, HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("/whm/report/sales_performance_board");
    }

    @RequestMapping(value = "/ajax/salesPerformance.html")
    public ModelAndView machineLog(SalesPerformanceBean bean, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("/whm/report/sales_performance_tb");
//        Date toDate = DateUtils.string2Date("07112017", "ddMMyyyy");
//        bean.setToDate(new Timestamp(toDate.getTime()));
        if (bean.getToDate() == null) {
            bean.setToDate(new Timestamp(System.currentTimeMillis()));
        } else {
            bean.setToDate(DateUtils.move2TheEndOfDay(new Timestamp(bean.getToDate().getTime())));
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(bean.getToDate().getTime());
        calendar.set(Calendar.DATE, 1);
        bean.setFromDate(new Timestamp(calendar.getTimeInMillis()));
        computeSalesPerformance(bean, mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }
}
