package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Productname;

import java.util.List;
/**
 * <p>Generic DAO layer for Productnames</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ProductnameDAO extends GenericDAO<Productname,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildProductnameDAO()
	 */
	  	 
	/**
	 * Find Productname by name
	 */
	public List<Productname> findByName(String name);

	/**
	 * Find Productname by code
	 */
	public List<Productname> findByCode(String code);

	/**
	 * Find Productname by description
	 */
	public List<Productname> findByDescription(String description);

}