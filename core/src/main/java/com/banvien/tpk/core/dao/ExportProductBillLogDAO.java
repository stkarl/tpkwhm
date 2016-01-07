package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.ExportProductBillLog;

import java.util.List;

/**
 * <p>Generic DAO layer for ExportProductBillLogs</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ExportProductBillLogDAO extends GenericDAO<ExportProductBillLog,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildExportProductBillLogDAO()
	 */
	  	 
	/**
	 * Find ExportProductBillLog by name
	 */
	public List<ExportProductBillLog> findByName(String name);

	/**
	 * Find ExportProductBillLog by code
	 */
	public List<ExportProductBillLog> findByCode(String code);

	/**
	 * Find ExportProductBillLog by sign
	 */
	public List<ExportProductBillLog> findBySign(String sign);

}