package com.banvien.tpk.webapp.controller;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.UserBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.UserService;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.webapp.editor.CustomDateEditor;
import com.banvien.tpk.webapp.validator.MyProfileValidator;
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

import java.util.Date;

@Controller
public class MyProfileController extends ApplicationObjectSupport {
    private transient final Log log = LogFactory.getLog(getClass());

    @Autowired
    private UserService userService;

    @Autowired
    private MyProfileValidator myProfileValidator;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
	}
    
    @RequestMapping({"/profile.html", "/whm/myProfile.html"})
	public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) UserBean userBean, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("/profile");

		String crudaction = userBean.getCrudaction();
		User pojo = userBean.getPojo();
		if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
			try {
				//validate
				myProfileValidator.validate(userBean, bindingResult);

				if(!bindingResult.hasErrors()) {
					if(pojo.getUserID() != null && pojo.getUserID() > 0) {
						this.userService.updateProfile(userBean);
						mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("profile.update.successful"));
					}
					mav.addObject("success", true);

				}
			}catch (ObjectNotFoundException oe) {
				logger.error(oe.getMessage(), oe);
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
			}catch (DuplicateException de) {
				logger.error(de.getMessage(), de);
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("profile.update.duplicate"));
			}catch(Exception e) {
				logger.error(e.getMessage(), e);
				mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
			}
		}else if(!bindingResult.hasErrors()) {
			try {
				User itemObj = this.userService.findById(SecurityUtils.getLoginUserId());
				userBean.setPojo(itemObj);
			}
			catch (Exception e) {
				logger.error("Could not found news " + userBean.getPojo().getUserID(), e);
			}
		}

		mav.addObject(Constants.FORM_MODEL_KEY, userBean);
		return mav;
	}
    
    

}
