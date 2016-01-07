package com.banvien.tpk.core.domain;

import java.io.Serializable;


/**
 * <p>Pojo mapping TABLE setting</p>
 * <p></p>
 *
 * <p>Generated at Tue Jul 10 16:04:17 ICT 2012</p>
 * @author Salto-db Generator v1.1 / Hibernate pojos and xml mapping files.
 * 
 */
public class Setting implements Serializable {
    public static final String FIELD_NAME = "fieldName";

	/**
	 * Attribute settingID.
	 */
	private Long settingID;
	
	/**
	 * Attribute fieldName.
	 */
	private String fieldName;
	
	/**
	 * Attribute fieldValue.
	 */
	private String fieldValue;
	
	
	/* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return settingID
	 */
	public Long getSettingID() {
		return settingID;
	}

	/**
	 * @param settingID new value for settingID 
	 */
	public void setSettingID(Long settingID) {
		this.settingID = settingID;
	}
	
	/* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return fieldName
	 */
	public String getFieldName() {
		return fieldName;
	}

	/**
	 * @param fieldName new value for fieldName 
	 */
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	
	/* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return fieldValue
	 */
	public String getFieldValue() {
		return fieldValue;
	}

	/**
	 * @param fieldValue new value for fieldValue 
	 */
	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}
	


}