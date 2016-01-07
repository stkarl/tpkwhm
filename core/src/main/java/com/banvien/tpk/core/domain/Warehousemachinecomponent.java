package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE warehousemachinecomponent</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Warehousemachinecomponent implements Serializable {

	/**
	 * Attribute warehouseMachineComponentID.
	 */
	private Long warehouseMachineComponentID;
	
	/**
	 * Attribute warehouse
	 */
	 private Warehouse warehouse;	

	/**
	 * Attribute machinecomponent
	 */
	 private Machinecomponent machinecomponent;	

	/**
	 * Attribute quantity.
	 */
	private Integer quantity;
	
	
	/**
	 * <p> 
	 * </p>
	 * @return warehouseMachineComponentID
	 */
	public Long getWarehouseMachineComponentID() {
		return warehouseMachineComponentID;
	}

	/**
	 * @param warehouseMachineComponentID new value for warehouseMachineComponentID 
	 */
	public void setWarehouseMachineComponentID(Long warehouseMachineComponentID) {
		this.warehouseMachineComponentID = warehouseMachineComponentID;
	}
	
	/**
	 * get warehouse
	 */
	public Warehouse getWarehouse() {
		return this.warehouse;
	}
	
	/**
	 * set warehouse
	 */
	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}

	/**
	 * get machinecomponent
	 */
	public Machinecomponent getMachinecomponent() {
		return this.machinecomponent;
	}
	
	/**
	 * set machinecomponent
	 */
	public void setMachinecomponent(Machinecomponent machinecomponent) {
		this.machinecomponent = machinecomponent;
	}

	/**
	 * <p> 
	 * </p>
	 * @return quantity
	 */
	public Integer getQuantity() {
		return quantity;
	}

	/**
	 * @param quantity new value for quantity 
	 */
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	


}