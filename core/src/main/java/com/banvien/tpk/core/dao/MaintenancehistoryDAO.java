package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Maintenancehistory;
/**
 * <p>Generic DAO layer for Maintenancehistorys</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface MaintenancehistoryDAO extends GenericDAO<Maintenancehistory,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildMaintenancehistoryDAO()
	 */
	  	 
	/**
	 * Find Maintenancehistory by botcher
	 */
	public List<Maintenancehistory> findByBotcher(String botcher);

	/**
	 * Find Maintenancehistory by machineID
	 */
	public List<Maintenancehistory> findByMachineID(Long machineID);

	/**
	 * Find Maintenancehistory by machineComponentID
	 */
	public List<Maintenancehistory> findByMachineComponentID(Long machineComponentID);

	/**
	 * Find Maintenancehistory by note
	 */
	public List<Maintenancehistory> findByNote(String note);

	/**
	 * Find Maintenancehistory by maintenanceDate
	 */
	public List<Maintenancehistory> findByMaintenanceDate(Timestamp maintenanceDate);

    Maintenancehistory findLatestMachine(Long machineID);

    Maintenancehistory findLastestMachineComponent(Long machineComponentID);

    List<Maintenancehistory> findLatestForComponentsOfMachine(Long machineID);

    List<Maintenancehistory> findLatestForComponentsOfParentComponent(Long machineComponentID);

    List<Maintenancehistory> findByMachine(Long machineID);

    List<Maintenancehistory> findByMachineComponent(Long machineComponentID);

}