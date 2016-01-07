package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Exporttype;
/**
 * <p>Generic DAO layer for Exporttypes</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ExporttypeDAO extends GenericDAO<Exporttype,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildExporttypeDAO()
	 */
	  	 
	/**
	 * Find Exporttype by name
	 */
	public List<Exporttype> findByName(String name);

    List<Exporttype> findExcludeCode(String code);
}