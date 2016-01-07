package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Importproductbill;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
/**
 * <p>Generic DAO layer for Importproductbills</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ImportproductbillDAO extends GenericDAO<Importproductbill,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildImportproductbillDAO()
	 */
	  	 
	/**
	 * Find Importproductbill by warehouseID
	 */
	public List<Importproductbill> findByWarehouseID(Long warehouseID);

	/**
	 * Find Importproductbill by code
	 */
	public List<Importproductbill> findByCode(String code);

	/**
	 * Find Importproductbill by description
	 */
	public List<Importproductbill> findByDescription(String description);

	/**
	 * Find Importproductbill by createdBy
	 */
	public List<Importproductbill> findByCreatedBy(Long createdBy);

	/**
	 * Find Importproductbill by createdDate
	 */
	public List<Importproductbill> findByCreatedDate(Timestamp createdDate);

	/**
	 * Find Importproductbill by produceDate
	 */
	public List<Importproductbill> findByProduceDate(Timestamp produceDate);

	/**
	 * Find Importproductbill by importDate
	 */
	public List<Importproductbill> findByImportDate(Timestamp importDate);

	/**
	 * Find Importproductbill by status
	 */
	public List<Importproductbill> findByStatus(Integer status);

	/**
	 * Find Importproductbill by updatedBy
	 */
	public List<Importproductbill> findByUpdatedBy(Long updatedBy);

	/**
	 * Find Importproductbill by updatedDate
	 */
	public List<Importproductbill> findByUpdatedDate(Timestamp updatedDate);

	/**
	 * Find Importproductbill by totalMoney
	 */
	public List<Importproductbill> findByTotalMoney(Double totalMoney);

	/**
	 * Find Importproductbill by note
	 */
	public List<Importproductbill> findByNote(String note);

	/**
	 * Find Importproductbill by produceGroup
	 */
	public List<Importproductbill> findByProduceGroup(String produceGroup);

    void deleteByCode(String code);

    String getLatestPNKTON();

    String getLatestPTNTON();

    void deleteBlankBill();

    Importproductbill findByParentBill(Long billID);

    List<Importproductbill> find4Contract(Date fromDate, Date toDate, Long customerID);

    List<Importproductbill> findAllByOrderAndDateLimit(String orderBy, Boolean black, Long date);

    List<Importproductbill> findByIds(List<Long> billIDs);
}