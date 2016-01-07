package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Machinecomponent;
/**
 * <p>Generic DAO layer for Machinecomponents</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface MachinecomponentDAO extends GenericDAO<Machinecomponent,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildMachinecomponentDAO()
	 */
	  	 
	/**
	 * Find Machinecomponent by name
	 */
	public List<Machinecomponent> findByName(String name);

	/**
	 * Find Machinecomponent by code
	 */
	public List<Machinecomponent> findByCode(String code);

	/**
	 * Find Machinecomponent by description
	 */
	public List<Machinecomponent> findByDescription(String description);

	/**
	 * Find Machinecomponent by lastMaintenanceDate
	 */
	public List<Machinecomponent> findByLastMaintenanceDate(Timestamp lastMaintenanceDate);

	/**
	 * Find Machinecomponent by nextMaintenance
	 */
	public List<Machinecomponent> findByNextMaintenance(Integer nextMaintenance);

	/**
	 * Find Machinecomponent by status
	 */
	public List<Machinecomponent> findByStatus(Integer status);

	/**
	 * Find Machinecomponent by machineID
	 */
	public List<Machinecomponent> findByMachineID(Long machineID);

    List<Machinecomponent> findByMachineAndWarehouse(Long machineID, Long warehouseID);

    List<Machinecomponent> findWarningComponent(Long warehouseID);

    List<Machinecomponent> findAllActiveComponentByWarehouse(Long warehouseID);
}