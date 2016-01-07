package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Province;
/**
 * <p>Generic DAO layer for Provinces</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ProvinceDAO extends GenericDAO<Province,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildProvinceDAO()
	 */
	  	 
	/**
	 * Find Province by name
	 */
	public List<Province> findByName(String name);

	/**
	 * Find Province by regionID
	 */
	public List<Province> findByRegionID(Long regionID);

}