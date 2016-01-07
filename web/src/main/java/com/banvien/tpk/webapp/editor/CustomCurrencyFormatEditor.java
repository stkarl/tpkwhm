package com.banvien.tpk.webapp.editor;

import java.beans.PropertyEditorSupport;

/**
 * Created with IntelliJ IDEA.
 * User: Quoc Viet
 * Date: 10/26/13
 * Time: 2:43 PM
 * To change this template use File | Settings | File Templates.
 */
public class CustomCurrencyFormatEditor extends PropertyEditorSupport{
    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        setValue(text.replaceAll("\\,", ""));
    }
}
