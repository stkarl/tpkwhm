package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Thickness;
/**
 * <p>Generic DAO layer for Thicknesss</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ThicknessDAO extends GenericDAO<Thickness,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildThicknessDAO()
	 */
	  	 
	/**
	 * Find Thickness by name
	 */
	public List<Thickness> findByName(String name);

	/**
	 * Find Thickness by code
	 */
	public List<Thickness> findByCode(String code);

	/**
	 * Find Thickness by description
	 */
	public List<Thickness> findByDescription(String description);

    List<Thickness> findAllByOrder(String order);
}