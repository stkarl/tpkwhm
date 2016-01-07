package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Machine;
/**
 * <p>Generic DAO layer for Machines</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface MachineDAO extends GenericDAO<Machine,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildMachineDAO()
	 */
	  	 
	/**
	 * Find Machine by name
	 */
	public List<Machine> findByName(String name);

	/**
	 * Find Machine by code
	 */
	public List<Machine> findByCode(String code);

	/**
	 * Find Machine by description
	 */
	public List<Machine> findByDescription(String description);

	/**
	 * Find Machine by lastMaintenanceDate
	 */
	public List<Machine> findByLastMaintenanceDate(Timestamp lastMaintenanceDate);

	/**
	 * Find Machine by nextMaintenance
	 */
	public List<Machine> findByNextMaintenance(Integer nextMaintenance);

	/**
	 * Find Machine by status
	 */
	public List<Machine> findByStatus(Integer status);

	/**
	 * Find Machine by warehouseID
	 */
	public List<Machine> findByWarehouseID(Long warehouseID);

    List<Machine> findAllActiveMachineByWarehouse(Long warehouseID);


    List<Machine> findWarningMachine(Long warehouseID);
}