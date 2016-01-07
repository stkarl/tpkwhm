package com.banvien.tpk.webapp.validator;

import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.UserBean;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.UserService;
import com.banvien.tpk.security.DesEncrypterUtils;
import com.banvien.tpk.webapp.util.CommonUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


@Component
public class MyProfileValidator extends ApplicationObjectSupport implements Validator {
	private transient final Log log = LogFactory.getLog(MyProfileValidator.class);
    private UserService userService;
    
	@Autowired
    public void setUserService(UserService userService) {
		this.userService = userService;
	}

    
    public boolean supports(Class<?> aClass) {
        return UserBean.class.isAssignableFrom(aClass);
    }
    /**
     * This method is called for validating Model Attribute
     */
    public void validate(Object o, Errors errors) {
        UserBean cmd = (UserBean)o;
        trimingField(cmd);
        validateRequiredValues(cmd, errors);
        validateFormat(cmd, errors);
        validateDuplicate(cmd, errors);
    }

    private void validateRequiredValues(UserBean cmd, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.fullname", "errors.required", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.fullname")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.email", "errors.required", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.email")}, "non-empty value required.");
        if (StringUtils.isNotBlank(cmd.getOldPassword())) {
            ValidationUtils.rejectIfEmpty(errors, "newPassword", "errors.required", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.newpassword")}, "non-empty value required.");
            ValidationUtils.rejectIfEmpty(errors, "confirmedPassword", "errors.required", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.confirmedpassword")}, "non-empty value required.");
            if (!cmd.getNewPassword().equals(cmd.getConfirmedPassword())) {
                ValidationUtils.rejectIfEmpty(errors, "newPassword", "errors.required", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.newpassword")}, " was missed match.");
            }
        }
    }

    private void trimingField(UserBean cmd) {
    	if(StringUtils.isNotEmpty(cmd.getPojo().getFullname())) {
    		cmd.getPojo().setFullname(cmd.getPojo().getFullname().trim());
    	}
    	if(StringUtils.isNotEmpty(cmd.getPojo().getEmail())) {
    		cmd.getPojo().setEmail(cmd.getPojo().getEmail().trim());
    	}
    }

    private void validateFormat(UserBean cmd, Errors errors) {
        if (StringUtils.isNotEmpty(cmd.getPojo().getEmail()) && !CommonUtil.isValidEmail(cmd.getPojo().getEmail())) {
            errors.rejectValue("pojo.email", "errors.invalid.format", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.email")}, "Invalid format");
        }
    }

    private void validateDuplicate(UserBean cmd, Errors errors) {
    	//Email
    	if(StringUtils.isNotBlank(cmd.getPojo().getEmail())) {
    		try {
    			User user = this.userService.findByEmail(cmd.getPojo().getEmail());
                if(user != null) {
                    if(cmd.getPojo().getUserID() != null &&
                            !user.getUserID().equals(cmd.getPojo().getUserID()))
                    errors.rejectValue("pojo.email", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.email")}, "Value has been chosen.");
                }
    		} catch (ObjectNotFoundException ex) {
    			// true
    		}
    	}

        if (StringUtils.isNotEmpty(cmd.getOldPassword())) {
            if (cmd.getPojo().getUserID() != null && cmd.getPojo().getUserID() > 0) {
                try{
                    User user = this.userService.findById(cmd.getPojo().getUserID());
                    if (!DesEncrypterUtils.getInstance().encrypt(cmd.getOldPassword()).equals(user.getPassword())) {
                        errors.rejectValue("oldPassword", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.password")}, "Old password not match.");
                    }
                }catch (ObjectNotFoundException ex) {

                }
            }
        }
    }

}
