package com.banvien.tpk.webapp.controller.whm;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Province;
import com.banvien.tpk.core.domain.Region;
import com.banvien.tpk.core.dto.ProvinceBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.ProvinceService;
import com.banvien.tpk.core.service.RegionService;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.editor.PojoEditor;
import com.banvien.tpk.webapp.util.RequestUtil;
import com.banvien.tpk.webapp.validator.ProvinceValidator;
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
public class ProvinceController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private ProvinceService provinceService;

    @Autowired
    private ProvinceValidator provinceValidator;

    @Autowired
    private RegionService regionService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Region.class, new PojoEditor(Region.class, "regionID", Long.class));
	}
    
    @RequestMapping("/whm/province/edit.html")
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) ProvinceBean provinceBean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/whm/province/edit");

		String crudaction = provinceBean.getCrudaction();
		Province pojo = provinceBean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				//validate
				provinceValidator.validate(provinceBean, bindingResult);

				if(!bindingResult.hasErrors()) {
					if(pojo.getProvinceID() != null && pojo.getProvinceID() > 0) {
						this.provinceService.updateItem(provinceBean);
                        mav = new ModelAndView("redirect:/whm/province/list.html?isUpdate=true");
					} else {
						this.provinceService.addNew(provinceBean);
                        mav = new ModelAndView("redirect:/whm/province/list.html?isAdd=true");
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
		if(!bindingResult.hasErrors()&& provinceBean.getPojo().getProvinceID() != null && provinceBean.getPojo().getProvinceID() > 0) {
			try {
                Province itemObj = this.provinceService.findById(pojo.getProvinceID());
				provinceBean.setPojo(itemObj);
			}
			catch (Exception e) {
				logger.error("Could not found item " + provinceBean.getPojo().getProvinceID(), e);
			}
		}
        referenceData(mav);
		mav.addObject(Constants.FORM_MODEL_KEY, provinceBean);
		return mav;
	}

    private void referenceData(ModelAndView mav) {
        mav.addObject("regions", regionService.findAllSortAsc());
    }


    @RequestMapping(value={"/whm/province/list.html"})
    public ModelAndView list(ProvinceBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/whm/province/list");
		if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
			Integer totalDeleted = 0;
			try {
				totalDeleted = provinceService.deleteItems(bean.getCheckList());
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

    private void executeSearch(ProvinceBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);

        Object[] results = this.provinceService.search(bean);
        bean.setListResult((List<Province>)results[1]);
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
