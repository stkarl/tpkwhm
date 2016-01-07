package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Warehouse;
/**
 * <p>Generic DAO layer for Warehouses</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface WarehouseDAO extends GenericDAO<Warehouse,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildWarehouseDAO()
	 */
	  	 
	/**
	 * Find Warehouse by name
	 */
	public List<Warehouse> findByName(String name);

	/**
	 * Find Warehouse by address
	 */
	public List<Warehouse> findByAddress(String address);

	/**
	 * Find Warehouse by status
	 */
	public List<Warehouse> findByStatus(Integer status);

	/**
	 * Find Warehouse by code
	 */
	public List<Warehouse> findByCode(String code);

    List<Warehouse> findAllActiveWarehouseExcludeID(Long excludeID);
}