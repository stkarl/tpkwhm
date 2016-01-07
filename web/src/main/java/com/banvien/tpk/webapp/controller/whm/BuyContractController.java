package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.BuyContract;
import com.banvien.tpk.core.domain.Customer;
import com.banvien.tpk.core.dto.BuyContractBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.BuyContractService;
import com.banvien.tpk.core.service.CustomerService;
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
import java.util.Date;
import java.util.List;

@Controller
public class BuyContractController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private BuyContractService buyContractService;

    @Autowired
    private CustomerService customerService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Customer.class, new PojoEditor(Customer.class, "customerID", Long.class));
        binder.registerCustomEditor(Date.class, new CustomDateEditor("dd/MM/yyyy"));
    }
    
    @RequestMapping("/whm/buycontract/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) BuyContractBean buyContractBean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/buycontract/edit");
        buyContractBean.setLoginID(SecurityUtils.getLoginUserId());
		String crudaction = buyContractBean.getCrudaction();
		BuyContract pojo = buyContractBean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {

				if(!bindingResult.hasErrors()) {
					if(pojo.getBuyContractID() != null && pojo.getBuyContractID() > 0) {
						this.buyContractService.updateItem(buyContractBean);
                        mav = new ModelAndView("redirect:/whm/buycontract/list.html?isUpdate=true");
					} else {
						this.buyContractService.addNew(buyContractBean);
                        mav = new ModelAndView("redirect:/whm/buycontract/list.html?isAdd=true");
					}
                    return mav;
				}
			}catch (ObjectNotFoundException oe) {
				logger.error(oe.getMessage());
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
			}catch (DuplicateException de) {
				logger.error(de.getMessage());
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.duplicate"));
			}catch(Exception e) {
				logger.error(e.getMessage(), e);
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
			}
		}
		if(!bindingResult.hasErrors()&& buyContractBean.getPojo().getBuyContractID() != null && buyContractBean.getPojo().getBuyContractID() > 0) {
			try {
                BuyContract itemObj = this.buyContractService.findById(pojo.getBuyContractID());
				buyContractBean.setPojo(itemObj);
			}
			catch (Exception e) {
				logger.error("Could not found item " + buyContractBean.getPojo().getBuyContractID(), e);
			}
		}
        referenceData(mav);
		mav.addObject(Constants.FORM_MODEL_KEY, buyContractBean);
		return mav;
	}

    private void referenceData(ModelAndView mav) {
        mav.addObject("customers", customerService.findAll());
    }


    @RequestMapping(value={"/whm/buycontract/list.html"})
    public ModelAndView list(BuyContractBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/buycontract/list");
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = buyContractService.deleteItems(bean.getCheckList());
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

    private void executeSearch(BuyContractBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);

        Object[] results = this.buyContractService.search(bean);
        bean.setListResult((List<BuyContract>)results[1]);
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
