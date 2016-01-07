package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Arrangement;
import com.banvien.tpk.core.domain.ArrangementDetail;
import com.banvien.tpk.core.dto.ArrangementBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.ArrangementService;
import com.banvien.tpk.core.service.ExportproductService;
import com.banvien.tpk.core.service.FixExpenseService;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.util.DateUtils;
import com.banvien.tpk.webapp.util.RequestUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
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
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ArrangementController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ArrangementService arrangementService;

    @Autowired
    private ExportproductService exportproductService;

    @Autowired
    private FixExpenseService fixExpenseService;


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }

    @RequestMapping("/whm/arrangement/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) ArrangementBean bean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/arrangement/edit");

		String crudaction = bean.getCrudaction();
		Arrangement pojo = bean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {

				if(!bindingResult.hasErrors()) {
					if(pojo.getArrangementID() != null && pojo.getArrangementID() > 0) {
						this.arrangementService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/arrangement/list.html?isUpdate=true");
                    } else {
						this.arrangementService.addNew(bean);
                        mav = new ModelAndView("redirect:/whm/arrangement/list.html?isAdd=true");
                    }
                    return mav;
                }
			}catch (ObjectNotFoundException oe) {
				logger.error(oe.getMessage(), oe);
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
        if(!bindingResult.hasErrors()&& bean.getPojo().getArrangementID() != null && bean.getPojo().getArrangementID() > 0) {
            try {
                Arrangement itemObj = this.arrangementService.findById(pojo.getArrangementID());
                bean.setPojo(itemObj);
                if(itemObj.getArrangementDetails() != null){
                    Map<Long,Double> mapExpenseValue = new HashMap<Long, Double>();
                    for(ArrangementDetail detail : itemObj.getArrangementDetails()){
                        mapExpenseValue.put(detail.getFixExpense().getFixExpenseID(), detail.getValue());
                    }
                    mav.addObject("mapExpenseValue", mapExpenseValue);
                }
            }
            catch (Exception e) {
                logger.error("Could not found news " + bean.getPojo().getArrangementID(), e);
            }
        }
        addDate2Model(mav, bean);
		mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
	}

    private void addDate2Model(ModelAndView mav, ArrangementBean bean) {
        mav.addObject("fixExpenses", this.fixExpenseService.findAll());
        Timestamp now = new Timestamp(System.currentTimeMillis());
        if(bean.getPojo().getFromDate() == null){
            bean.getPojo().setFromDate(now);
        }
        if(bean.getPojo().getToDate() == null){
            bean.getPojo().setToDate(now);
        }
    }


    @RequestMapping(value={"/whm/arrangement/list.html"})
    public ModelAndView list(ArrangementBean bean,HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/arrangement/list");
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = arrangementService.deleteItems(bean.getCheckList());
				mav.addObject("totalDeleted", totalDeleted);
			}catch (Exception e) {
				log.error(e.getMessage(), e);
                mav.addObject("alertType","error");
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
			}
		}
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }

    private void executeSearch(ArrangementBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.arrangementService.search(bean);
        bean.setListResult((List<Arrangement>)results[1]);
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

    @RequestMapping(value = "/ajax/arrangement/getblackinfo.html")
    public void confirmSubmittedScoreCardYear(@ModelAttribute(Constants.FORM_MODEL_KEY) ArrangementBean bean,
                                              HttpServletResponse response){
        try{
            if(bean.getToDate() != null){
                bean.setToDate(DateUtils.move2TheEndOfDay((Timestamp) bean.getToDate()));
            }
            response.setContentType("text/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            JSONObject object = new JSONObject();
            Double totalBlack = this.exportproductService.findTotalExportBlackProduct4ProductionByDate(bean.getFromDate(), bean.getToDate());
            if(totalBlack != null){
                object.put("totalBlack", totalBlack / 1000);
            }
            out.print(object);
            out.flush();
            out.close();
        }catch (Exception e){
            log.error(e.getMessage(),e);
        }
    }
}
