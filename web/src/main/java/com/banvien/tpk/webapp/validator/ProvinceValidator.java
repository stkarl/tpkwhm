package com.banvien.tpk.webapp.validator;

import com.banvien.tpk.core.dto.ProvinceBean;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


@Component
public class ProvinceValidator extends ApplicationObjectSupport implements Validator {
	private transient final Log log = LogFactory.getLog(ProvinceValidator.class);

    public boolean supports(Class<?> aClass) {
        return ProvinceBean.class.isAssignableFrom(aClass);
    }
    /**
     * This method is called for validating Model Attribute
     */
    public void validate(Object o, Errors errors) {
        ProvinceBean cmd = (ProvinceBean)o;
        trimingField(cmd);
        validateRequiredValues(cmd, errors);
    }

    private void validateRequiredValues(ProvinceBean cmd, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[] {this.getMessageSourceAccessor().getMessage("support.district.form.name")}, "non-empty value required.");
    }

    private void trimingField(ProvinceBean cmd) {
    	if(StringUtils.isNotEmpty(cmd.getPojo().getName())) {
    		cmd.getPojo().setName(cmd.getPojo().getName().trim());
    	}

    }




}
