package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE market</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Market implements Serializable {

	/**
	 * Attribute marketID.
	 */
	private Long marketID;
	
	/**
	 * Attribute name.
	 */
	private String name;
	
	/**
	 * Attribute code.
	 */
	private String code;
	
	/**
	 * Attribute description.
	 */
	private String description;

	/**
	 * <p> 
	 * </p>
	 * @return marketID
	 */
	public Long getMarketID() {
		return marketID;
	}

	/**
	 * @param marketID new value for marketID 
	 */
	public void setMarketID(Long marketID) {
		this.marketID = marketID;
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
	 * @return description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description new value for description 
	 */
	public void setDescription(String description) {
		this.description = description;
	}


}