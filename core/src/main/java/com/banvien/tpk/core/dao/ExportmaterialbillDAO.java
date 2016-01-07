package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Exportmaterialbill;

import java.sql.Timestamp;
import java.util.List;
/**
 * <p>Generic DAO layer for Exportmaterialbills</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ExportmaterialbillDAO extends GenericDAO<Exportmaterialbill,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildExportmaterialbillDAO()
	 */
	  	 
	/**
	 * Find Exportmaterialbill by receiver
	 */
	public List<Exportmaterialbill> findByReceiver(String receiver);

	/**
	 * Find Exportmaterialbill by exportTypeID
	 */
	public List<Exportmaterialbill> findByExportTypeID(Long exportTypeID);

	/**
	 * Find Exportmaterialbill by exportWarehouseID
	 */
	public List<Exportmaterialbill> findByExportWarehouseID(Long exportWarehouseID);

	/**
	 * Find Exportmaterialbill by receiveWarehouseID
	 */
	public List<Exportmaterialbill> findByReceiveWarehouseID(Long receiveWarehouseID);

	/**
	 * Find Exportmaterialbill by code
	 */
	public List<Exportmaterialbill> findByCode(String code);

	/**
	 * Find Exportmaterialbill by description
	 */
	public List<Exportmaterialbill> findByDescription(String description);

	/**
	 * Find Exportmaterialbill by createdBy
	 */
	public List<Exportmaterialbill> findByCreatedBy(Long createdBy);

	/**
	 * Find Exportmaterialbill by createdDate
	 */
	public List<Exportmaterialbill> findByCreatedDate(Timestamp createdDate);

	/**
	 * Find Exportmaterialbill by exportDate
	 */
	public List<Exportmaterialbill> findByExportDate(Timestamp exportDate);

	/**
	 * Find Exportmaterialbill by status
	 */
	public List<Exportmaterialbill> findByStatus(Integer status);

	/**
	 * Find Exportmaterialbill by updatedBy
	 */
	public List<Exportmaterialbill> findByUpdatedBy(Long updatedBy);

	/**
	 * Find Exportmaterialbill by updatedDate
	 */
	public List<Exportmaterialbill> findByUpdatedDate(Timestamp updatedDate);

	/**
	 * Find Exportmaterialbill by note
	 */
	public List<Exportmaterialbill> findByNote(String note);

    String getLatestPXKPL();

    List<Exportmaterialbill> findAllByOrderAndDateLimit(String orderBy, Long date);
}