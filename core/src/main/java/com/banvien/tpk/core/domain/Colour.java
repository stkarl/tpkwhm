package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE colour</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Colour implements Serializable {

	/**
	 * Attribute colourID.
	 */
	private Long colourID;
	
	/**
	 * Attribute name.
	 */
	private String name;
	
	/**
	 * Attribute code.
	 */
	private String code;
	
	/**
	 * Attribute sign.
	 */
	private String sign;

	/**
	 * <p> 
	 * </p>
	 * @return colourID
	 */
	public Long getColourID() {
		return colourID;
	}

	/**
	 * @param colourID new value for colourID 
	 */
	public void setColourID(Long colourID) {
		this.colourID = colourID;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name new value for name 
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code new value for code 
	 */
	public void setCode(String code) {
		this.code = code;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return sign
	 */
	public String getSign() {
		return sign;
	}

	/**
	 * @param sign new value for sign 
	 */
	public void setSign(String sign) {
		this.sign = sign;
	}

}