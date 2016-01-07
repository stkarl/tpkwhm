package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE warehouse</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Warehouse implements Serializable {

	/**
	 * Attribute warehouseID.
	 */
	private Long warehouseID;
	
	/**
	 * Attribute name.
	 */
	private String name;
	
	/**
	 * Attribute address.
	 */
	private String address;
	
	/**
	 * Attribute status.
	 */
	private Integer status;
	
	/**
	 * Attribute code.
	 */
	private String code;

	
	/**
	 * <p> 
	 * </p>
	 * @return warehouseID
	 */
	public Long getWarehouseID() {
		return warehouseID;
	}

	/**
	 * @param warehouseID new value for warehouseID 
	 */
	public void setWarehouseID(Long warehouseID) {
		this.warehouseID = warehouseID;
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
	 * @return address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address new value for address 
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return status
	 */
	public Integer getStatus() {
		return status;
	}

	/**
	 * @param status new value for status 
	 */
	public void setStatus(Integer status) {
		this.status = status;
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
}