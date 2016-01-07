package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Customer;
import com.banvien.tpk.core.dto.ReportBean;

/**
 * <p>Generic DAO layer for Customers</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface CustomerDAO extends GenericDAO<Customer,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildCustomerDAO()
	 */
	  	 
	/**
	 * Find Customer by name
	 */
	public List<Customer> findByName(String name);

	/**
	 * Find Customer by address
	 */
	public List<Customer> findByAddress(String address);

	/**
	 * Find Customer by regionID
	 */
	public List<Customer> findByRegionID(Long regionID);

	/**
	 * Find Customer by provinceID
	 */
	public List<Customer> findByProvinceID(Long provinceID);

	/**
	 * Find Customer by birthday
	 */
	public List<Customer> findByBirthday(Timestamp birthday);

	/**
	 * Find Customer by owe
	 */
	public List<Customer> findByOwe(Double owe);

	/**
	 * Find Customer by limit
	 */
	public List<Customer> findByLimit(Double limit);

	/**
	 * Find Customer by lastPayDate
	 */
	public List<Customer> findByLastPayDate(Timestamp lastPayDate);

	/**
	 * Find Customer by dayAllow
	 */
	public List<Customer> findByDayAllow(Integer dayAllow);

	/**
	 * Find Customer by status
	 */
	public List<Customer> findByStatus(Integer status);

    List<Customer> findByUser(Long loginUserId);

    List<Customer> findCustomerHasLiability(ReportBean bean);

    List<Customer> find4Report(ReportBean bean);

    List<Customer> findByIDs(List<Long> customerIDs);
}