package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Product;
/**
 * <p>Generic DAO layer for Products</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ProductDAO extends GenericDAO<Product,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildProductDAO()
	 */
	  	 
	/**
	 * Find Product by name
	 */
	public List<Product> findByName(String name);

	/**
	 * Find Product by code
	 */
	public List<Product> findByCode(String code);

	/**
	 * Find Product by description
	 */
	public List<Product> findByDescription(String description);

	/**
	 * Find Product by productNameID
	 */
	public List<Product> findByProductNameID(Long productNameID);

	/**
	 * Find Product by sizeID
	 */
	public List<Product> findBySizeID(Long sizeID);

	/**
	 * Find Product by colourID
	 */
	public List<Product> findByColourID(Long colourID);

	/**
	 * Find Product by thicknessID
	 */
	public List<Product> findByThicknessID(Long thicknessID);

	/**
	 * Find Product by stiffnessID
	 */
	public List<Product> findByStiffnessID(Long stiffnessID);

	/**
	 * Find Product by overlayTypeID
	 */
	public List<Product> findByOverlayTypeID(Long overlayTypeID);

}