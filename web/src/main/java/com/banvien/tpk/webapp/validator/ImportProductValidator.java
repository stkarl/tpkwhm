package com.banvien.tpk.webapp.validator;

import com.banvien.tpk.core.dto.ItemInfoDTO;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ImportProductValidator extends ApplicationObjectSupport implements Validator {
	private transient final Log log = LogFactory.getLog(ImportProductValidator.class);

    public boolean supports(Class<?> aClass) {
        return ItemInfoDTO.class.isAssignableFrom(aClass);
    }
    /**
     * This method is called for validating Model Attribute
     */
    public void validate(Object o, Errors errors) {
        ItemInfoDTO cmd = (ItemInfoDTO)o;
//        trimingField(cmd);
        validateRequiredValues(cmd, errors);
    }

    private void validateRequiredValues(ItemInfoDTO itemInfoDTO, Errors errors) {
        if (itemInfoDTO.getProductName() == null || itemInfoDTO.getProductName().getProductNameID() == null || itemInfoDTO.getProductName().getProductNameID() < 0) {
            errors.rejectValue("name", "errors.require.name", new String[] {this.getMessageSourceAccessor().getMessage("errors.require.name")}, "Name required");
        }
        if (itemInfoDTO.getCode() == null || !StringUtils.isNotBlank(itemInfoDTO.getCode())) {
            errors.rejectValue("code", "errors.require.code", new String[] {this.getMessageSourceAccessor().getMessage("errors.require.code")}, "Code required");
        }
    }

    private void trimingField(ItemInfoDTO cmd) {
//    	if(StringUtils.isNotEmpty(cmd.getPojo().getName())) {
//    		cmd.getPojo().setName(cmd.getPojo().getName().trim());
//    	}

    }




}
