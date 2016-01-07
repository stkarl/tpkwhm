package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Overlaytype;
/**
 * <p>Generic DAO layer for Overlaytypes</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface OverlaytypeDAO extends GenericDAO<Overlaytype,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildOverlaytypeDAO()
	 */
	  	 
	/**
	 * Find Overlaytype by name
	 */
	public List<Overlaytype> findByName(String name);

	/**
	 * Find Overlaytype by code
	 */
	public List<Overlaytype> findByCode(String code);

	/**
	 * Find Overlaytype by description
	 */
	public List<Overlaytype> findByDescription(String description);

}