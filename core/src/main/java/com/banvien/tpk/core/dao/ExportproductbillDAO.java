package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Exportproductbill;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
/**
 * <p>Generic DAO layer for Exportproductbills</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ExportproductbillDAO extends GenericDAO<Exportproductbill,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildExportproductbillDAO()
	 */
	  	 
	/**
	 * Find Exportproductbill by receiver
	 */
	public List<Exportproductbill> findByReceiver(String receiver);

	/**
	 * Find Exportproductbill by customerID
	 */
	public List<Exportproductbill> findByCustomerID(Long customerID);

	/**
	 * Find Exportproductbill by exportTypeID
	 */
	public List<Exportproductbill> findByExportTypeID(Long exportTypeID);

	/**
	 * Find Exportproductbill by exportWarehouseID
	 */
	public List<Exportproductbill> findByExportWarehouseID(Long exportWarehouseID);

	/**
	 * Find Exportproductbill by receiveWarehouseID
	 */
	public List<Exportproductbill> findByReceiveWarehouseID(Long receiveWarehouseID);

	/**
	 * Find Exportproductbill by code
	 */
	public List<Exportproductbill> findByCode(String code);

	/**
	 * Find Exportproductbill by description
	 */
	public List<Exportproductbill> findByDescription(String description);

	/**
	 * Find Exportproductbill by createdBy
	 */
	public List<Exportproductbill> findByCreatedBy(Long createdBy);

	/**
	 * Find Exportproductbill by createdDate
	 */
	public List<Exportproductbill> findByCreatedDate(Timestamp createdDate);

	/**
	 * Find Exportproductbill by exportDate
	 */
	public List<Exportproductbill> findByExportDate(Timestamp exportDate);

	/**
	 * Find Exportproductbill by status
	 */
	public List<Exportproductbill> findByStatus(Integer status);

	/**
	 * Find Exportproductbill by updatedBy
	 */
	public List<Exportproductbill> findByUpdatedBy(Long updatedBy);

	/**
	 * Find Exportproductbill by updatedDate
	 */
	public List<Exportproductbill> findByUpdatedDate(Timestamp updatedDate);

	/**
	 * Find Exportproductbill by note
	 */
	public List<Exportproductbill> findByNote(String note);

	/**
	 * Find Exportproductbill by totalMoney
	 */
	public List<Exportproductbill> findByTotalMoney(Double totalMoney);

    String getLatestPXKTON();

    List<Object> findCustomerLatestBoughtDate(List<Long> customerIds, Date beforeDate);

    List<Exportproductbill> findAllByOrderAndDateLimit(String orderBy, Boolean black, Long date);

}