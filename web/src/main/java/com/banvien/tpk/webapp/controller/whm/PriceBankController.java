package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.PriceBank;
import com.banvien.tpk.core.dto.PriceBankBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
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
import java.util.Date;
import java.util.List;

@Controller
public class PriceBankController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private PriceBankService priceBankService;

    @Autowired
    private ProductnameService productNameService;

    @Autowired
    private ColourService colourService;

    @Autowired
    private ThicknessService thicknessService;

    @Autowired
    private SizeService sizeService;

    @Autowired
    private QualityService qualityService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }
    
    @RequestMapping("/whm/pricebank/editlist.html")
	public ModelAndView editlist(@ModelAttribute(Constants.FORM_MODEL_KEY) PriceBankBean bean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/pricebank/editlist");

		String crudaction = bean.getCrudaction();
        if(bean.getEffectedDate() == null){
            bean.setEffectedDate(new Date(System.currentTimeMillis()));
        }
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				if(!bindingResult.hasErrors()) {
					this.priceBankService.addNew(bean);
                    mav.addObject("successMessage", this.getMessageSourceAccessor().getMessage("update.successful"));
                    mav = new ModelAndView("redirect:/whm/pricebank/list.html?isUpdate=true");
                    return mav;
                }
			}catch(Exception e) {
				logger.error(e.getMessage(), e);
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
			}
		}
        if(StringUtils.isNotBlank(bean.getType())){
            referenceData(mav, bean);
            mav.addObject(Constants.FORM_MODEL_KEY, bean);
            return mav;
        }else{
            return new ModelAndView("redirect:/whm/home.html");
        }
	}

    @RequestMapping("/whm/pricebank/list.html")
    public ModelAndView list(@ModelAttribute(Constants.LIST_MODEL_KEY) PriceBankBean bean,HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/whm/pricebank/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = this.priceBankService.deleteItems(bean.getCheckList());
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
        referenceData(mav,bean);
        showAlert(mav,bean.getIsAdd(),bean.getIsUpdate(),bean.getIsError());
        return mav;
    }
    private void executeSearch(PriceBankBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Object[] results = this.priceBankService.search(bean);
        bean.setListResult((List<PriceBank>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void referenceData(ModelAndView mav, PriceBankBean bean) {
        if(bean.getType().endsWith("M")){
            bean.setColour(Boolean.TRUE);
        }else{
            bean.setThickness(Boolean.TRUE);
        }
        mav.addObject("productName", productNameService.findEqualUnique("code",bean.getType()));
        mav.addObject("colours", colourService.findAllByOrder("name"));
        mav.addObject("thicknesses", thicknessService.findAllByOrder("name"));
        mav.addObject("sizes", sizeService.findAllByOrder("name"));
        mav.addObject("qualities", qualityService.findNonePPByOrder("name"));
    }


    @RequestMapping("/whm/pricebank/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) PriceBankBean bean, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("/whm/pricebank/edit");

        String crudaction = bean.getCrudaction();
        PriceBank pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try {

                if(!bindingResult.hasErrors()) {
                    if(pojo.getPriceBankID() != null && pojo.getPriceBankID() > 0) {
                        this.priceBankService.updateItem(bean);
                        mav = new ModelAndView("redirect:/whm/pricebank/list.html?isUpdate=true");
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
        if(!bindingResult.hasErrors()&& bean.getPojo().getPriceBankID() != null && bean.getPojo().getPriceBankID() > 0) {
            try {
                PriceBank itemObj = this.priceBankService.findById(pojo.getPriceBankID());
                bean.setPojo(itemObj);
            }
            catch (Exception e) {
                logger.error("Could not found news " + bean.getPojo().getPriceBankID(), e);
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
