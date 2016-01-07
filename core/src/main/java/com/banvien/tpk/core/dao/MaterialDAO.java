package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.dto.MaterialBean;

/**
 * <p>Generic DAO layer for Materials</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface MaterialDAO extends GenericDAO<Material,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildMaterialDAO()
	 */
	  	 
	/**
	 * Find Material by name
	 */
	public List<Material> findByName(String name);

	/**
	 * Find Material by code
	 */
	public List<Material> findByCode(String code);

	/**
	 * Find Material by description
	 */
	public List<Material> findByDescription(String description);

	/**
	 * Find Material by materialCategoryID
	 */

    Object[] searchByBean(MaterialBean bean, int firstItem, int maxPageItems, String sortExpression, String sortDirection);

    List<Material> findByCateCode(String cateCode);

    List<Material> findNoneMeasurement();

    List<Material> findAssigned(Long userID);

}