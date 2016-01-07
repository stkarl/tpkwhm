package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Importmaterialbill;

import java.sql.Timestamp;
import java.util.List;
/**
 * <p>Generic DAO layer for Importmaterialbills</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ImportmaterialbillDAO extends GenericDAO<Importmaterialbill,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildImportmaterialbillDAO()
	 */
	  	 
	/**
	 * Find Importmaterialbill by customerID
	 */
	public List<Importmaterialbill> findByCustomerID(Long customerID);

	/**
	 * Find Importmaterialbill by warehouseID
	 */
	public List<Importmaterialbill> findByWarehouseID(Long warehouseID);

	/**
	 * Find Importmaterialbill by code
	 */
	public List<Importmaterialbill> findByCode(String code);

	/**
	 * Find Importmaterialbill by description
	 */
	public List<Importmaterialbill> findByDescription(String description);

	/**
	 * Find Importmaterialbill by createdBy
	 */
	public List<Importmaterialbill> findByCreatedBy(Long createdBy);

	/**
	 * Find Importmaterialbill by importDate
	 */
	public List<Importmaterialbill> findByImportDate(Timestamp importDate);

	/**
	 * Find Importmaterialbill by status
	 */
	public List<Importmaterialbill> findByStatus(Integer status);

	/**
	 * Find Importmaterialbill by updatedBy
	 */
	public List<Importmaterialbill> findByUpdatedBy(Long updatedBy);

	/**
	 * Find Importmaterialbill by updatedDate
	 */
	public List<Importmaterialbill> findByUpdatedDate(Timestamp updatedDate);

	/**
	 * Find Importmaterialbill by totalMoney
	 */
	public List<Importmaterialbill> findByTotalMoney(Double totalMoney);

	/**
	 * Find Importmaterialbill by note
	 */
	public List<Importmaterialbill> findByNote(String note);

    String getLatestPNKPL();

    List<Importmaterialbill> findAllByOrderAndDateLimit(String orderBy, Long date);
}