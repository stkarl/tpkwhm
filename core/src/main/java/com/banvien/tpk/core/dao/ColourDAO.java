package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Colour;
/**
 * <p>Generic DAO layer for Colours</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ColourDAO extends GenericDAO<Colour,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildColourDAO()
	 */
	  	 
	/**
	 * Find Colour by name
	 */
	public List<Colour> findByName(String name);

	/**
	 * Find Colour by code
	 */
	public List<Colour> findByCode(String code);

	/**
	 * Find Colour by sign
	 */
	public List<Colour> findBySign(String sign);

    List<Colour> findAllByOrder(String name);
}