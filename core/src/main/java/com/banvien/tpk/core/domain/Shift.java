package com.banvien.tpk.core.domain;

import java.io.Serializable;


/**
 * <p>Pojo mapping TABLE shift</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Shift implements Serializable {

	/**
	 * Attribute shiftID.
	 */
	private Long shiftID;
	
	/**
	 * Attribute name.
	 */
	private String name;

	/**
	 * <p> 
	 * </p>
	 * @return shiftID
	 */
	public Long getShiftID() {
		return shiftID;
	}

	/**
	 * @param shiftID new value for shiftID 
	 */
	public void setShiftID(Long shiftID) {
		this.shiftID = shiftID;
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