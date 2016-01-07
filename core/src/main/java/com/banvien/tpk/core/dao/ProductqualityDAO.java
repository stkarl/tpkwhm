package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Productquality;
/**
 * <p>Generic DAO layer for Productqualitys</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ProductqualityDAO extends GenericDAO<Productquality,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildProductqualityDAO()
	 */
	  	 
	/**
	 * Find Productquality by importProductID
	 */
	public List<Productquality> findByImportProductID(Long importProductID);

	/**
	 * Find Productquality by qualityID
	 */
	public List<Productquality> findByQualityID(Long qualityID);

	/**
	 * Find Productquality by unit1ID
	 */
	public List<Productquality> findByUnit1ID(Long unit1ID);

	/**
	 * Find Productquality by quantity1
	 */
	public List<Productquality> findByQuantity1(Double quantity1);

	/**
	 * Find Productquality by unit2ID
	 */
	public List<Productquality> findByUnit2ID(Long unit2ID);

	/**
	 * Find Productquality by quantity2
	 */
	public List<Productquality> findByQuantity2(Double quantity2);

}