package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE origin</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Origin implements Serializable {

	/**
	 * Attribute originID.
	 */
	private Long originID;
	
	/**
	 * Attribute name.
	 */
	private String name;
	
	/**
	 * Attribute description.
	 */
	private String description;

	/**
	 * <p> 
	 * </p>
	 * @return originID
	 */
	public Long getOriginID() {
		return originID;
	}

	/**
	 * @param originID new value for originID 
	 */
	public void setOriginID(Long originID) {
		this.originID = originID;
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