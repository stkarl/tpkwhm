package com.banvien.tpk.webapp.validator;

import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.UserBean;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.UserService;

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
public class UserValidator extends ApplicationObjectSupport implements Validator {
	private transient final Log log = LogFactory.getLog(UserValidator.class);
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
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.userName", "errors.required", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.username")}, "non-empty value required.");

    }

    private void trimingField(UserBean cmd) {
    	if(StringUtils.isNotEmpty(cmd.getPojo().getFullname())) {
    		cmd.getPojo().setFullname(cmd.getPojo().getFullname().trim());
    	}
    	if(StringUtils.isNotEmpty(cmd.getPojo().getUserName())) {
    		cmd.getPojo().setUserName(cmd.getPojo().getUserName().trim());
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
    	//Username
    	if(StringUtils.isNotBlank(cmd.getPojo().getUserName())) {
    		try {
    			User user = this.userService.findByUsername(cmd.getPojo().getUserName());
                if(user != null) {
                    if(cmd.getPojo().getUserID() != null &&
                            !user.getUserID().equals(cmd.getPojo().getUserID()))
                    errors.rejectValue("pojo.userName", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("admin.user.form.username")}, "Value has been chosen.");
                }
    		} catch (ObjectNotFoundException ex) {
    			// true
    		}	
    	}
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
    }

    public int validateImportDuplicateUSERNAME(String username)
    {
    	//Username
    	if(StringUtils.isNotBlank(username)) {
    		try {
    			User user = this.userService.findByUsername(username);
                if(user != null)
                    return -1;
    		} catch (ObjectNotFoundException ex) {
    			// true
    		}
    	}
        return 1;
    }
    public int validateImportDuplicateEMAIL(String email)
    {
    	//Email
    	if(StringUtils.isNotBlank(email)) {
    		try {
    			User user = this.userService.findByEmail(email);
                if(user != null)
                    return -1;
    		} catch (ObjectNotFoundException ex) {
    			// true
    		}
    	}
        return 1;
    }
    public int validateUserExist(String userName)
    {
        //Username
        if(StringUtils.isNotBlank(userName)) {
            try {
                User user = this.userService.findByUsername(userName);
                if(user != null)
                    return 1;
            } catch (ObjectNotFoundException ex) {
                return -1;
            }
        }
        return -1;
    }
    public int validateUserCodeExist(String userCode)
    {
        //Usercode
        if(StringUtils.isNotBlank(userCode)) {
            try {
                User user = this.userService.findByUserCode(userCode);
                if(user != null)
                    return 1;
            } catch (ObjectNotFoundException ex) {
                return -1;
            }
        }
        return -1;
    }
}
