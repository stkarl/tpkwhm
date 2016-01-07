package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Origin;
/**
 * <p>Generic DAO layer for Origins</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface OriginDAO extends GenericDAO<Origin,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildOriginDAO()
	 */
	  	 
	/**
	 * Find Origin by name
	 */
	public List<Origin> findByName(String name);

	/**
	 * Find Origin by description
	 */
	public List<Origin> findByDescription(String description);

}