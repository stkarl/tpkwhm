package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Size;

import java.util.List;
/**
 * <p>Generic DAO layer for Sizes</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface SizeDAO extends GenericDAO<Size,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildSizeDAO()
	 */
	  	 
	/**
	 * Find Size by name
	 */
	public List<Size> findByName(String name);

	/**
	 * Find Size by code
	 */
	public List<Size> findByCode(String code);

	/**
	 * Find Size by description
	 */
	public List<Size> findByDescription(String description);

    List<Size> findAllByOrder(String order);

    List<Size> findByIds(List<Long> sizeIds);
}