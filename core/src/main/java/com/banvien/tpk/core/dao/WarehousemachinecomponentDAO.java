package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Warehousemachinecomponent;
/**
 * <p>Generic DAO layer for Warehousemachinecomponents</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface WarehousemachinecomponentDAO extends GenericDAO<Warehousemachinecomponent,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildWarehousemachinecomponentDAO()
	 */
	  	 
	/**
	 * Find Warehousemachinecomponent by warehouseID
	 */
	public List<Warehousemachinecomponent> findByWarehouseID(Long warehouseID);

	/**
	 * Find Warehousemachinecomponent by machineComponentID
	 */
	public List<Warehousemachinecomponent> findByMachineComponentID(Long machineComponentID);

	/**
	 * Find Warehousemachinecomponent by quantity
	 */
	public List<Warehousemachinecomponent> findByQuantity(Integer quantity);

}