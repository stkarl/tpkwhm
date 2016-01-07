package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Materialcategory;
/**
 * <p>Generic DAO layer for Materialcategorys</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface MaterialcategoryDAO extends GenericDAO<Materialcategory,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildMaterialcategoryDAO()
	 */
	  	 
	/**
	 * Find Materialcategory by name
	 */
	public List<Materialcategory> findByName(String name);

	/**
	 * Find Materialcategory by code
	 */
	public List<Materialcategory> findByCode(String code);

	/**
	 * Find Materialcategory by description
	 */
	public List<Materialcategory> findByDescription(String description);

    List<Materialcategory> findAssignedCate(Long loginUserId);
}