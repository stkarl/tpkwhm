package com.banvien.tpk.webapp.validator;

import com.banvien.tpk.core.dto.SettingBean;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class SettingValidator extends ApplicationObjectSupport implements Validator {
	private transient final Log log = LogFactory.getLog(SettingValidator.class);

    public boolean supports(Class<?> aClass) {
        return SettingBean.class.isAssignableFrom(aClass);
    }
    /**
     * This method is called for validating Model Attribute
     */
    public void validate(Object o, Errors errors) {
        SettingBean cmd = (SettingBean)o;
        trimingField(cmd);
        validateRequiredValues(cmd, errors);
    }

    private void validateRequiredValues(SettingBean cmd, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.fieldName", "errors.required", new String[] {this.getMessageSourceAccessor().getMessage("support.region.form.fieldname")}, "non-empty value required.");
    }

    private void trimingField(SettingBean cmd) {
    	if(StringUtils.isNotEmpty(cmd.getPojo().getFieldName())) {
    		cmd.getPojo().setFieldName(cmd.getPojo().getFieldName().trim());
    	}

    }




}
