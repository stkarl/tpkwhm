package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Quality;
/**
 * <p>Generic DAO layer for Qualitys</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface QualityDAO extends GenericDAO<Quality,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildQualityDAO()
	 */
	  	 
	/**
	 * Find Quality by name
	 */
	public List<Quality> findByName(String name);

	/**
	 * Find Quality by code
	 */
	public List<Quality> findByCode(String code);

	/**
	 * Find Quality by description
	 */
	public List<Quality> findByDescription(String description);

    List<Quality> findNonePPByOrder(String order);
}