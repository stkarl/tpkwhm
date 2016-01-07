package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE region</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Region implements Serializable {

	/**
	 * Attribute regionID.
	 */
	private Long regionID;
	
	/**
	 * Attribute name.
	 */
	private String name;

	/**
	 * <p> 
	 * </p>
	 * @return regionID
	 */
	public Long getRegionID() {
		return regionID;
	}

	/**
	 * @param regionID new value for regionID 
	 */
	public void setRegionID(Long regionID) {
		this.regionID = regionID;
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

}