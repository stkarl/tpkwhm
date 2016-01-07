package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Stiffness;
/**
 * <p>Generic DAO layer for Stiffnesss</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface StiffnessDAO extends GenericDAO<Stiffness,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildStiffnessDAO()
	 */
	  	 
	/**
	 * Find Stiffness by name
	 */
	public List<Stiffness> findByName(String name);

	/**
	 * Find Stiffness by code
	 */
	public List<Stiffness> findByCode(String code);

	/**
	 * Find Stiffness by description
	 */
	public List<Stiffness> findByDescription(String description);

}