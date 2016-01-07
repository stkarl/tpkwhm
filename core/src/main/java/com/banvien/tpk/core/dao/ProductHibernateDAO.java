package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.ProductDAO;
import com.banvien.tpk.core.domain.Product;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Products</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ProductHibernateDAO extends
		AbstractHibernateDAO<Product, Long> implements
		ProductDAO {

	/**
	 * Find Product by name
	 */
	public List<Product> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Product by code
	 */
	public List<Product> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Product by description
	 */
	public List<Product> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	
	/**
	 * Find Product by productNameID
	 */
	@SuppressWarnings("unchecked")
	public List<Product> findByProductNameID(Long productNameID) {
		return findByCriteria(Restrictions.eq("productname.productNameID", productNameID));
	}
	
	/**
	 * Find Product by sizeID
	 */
	@SuppressWarnings("unchecked")
	public List<Product> findBySizeID(Long sizeID) {
		return findByCriteria(Restrictions.eq("size.sizeID", sizeID));
	}
	
	/**
	 * Find Product by colourID
	 */
	@SuppressWarnings("unchecked")
	public List<Product> findByColourID(Long colourID) {
		return findByCriteria(Restrictions.eq("colour.colourID", colourID));
	}
	
	/**
	 * Find Product by thicknessID
	 */
	@SuppressWarnings("unchecked")
	public List<Product> findByThicknessID(Long thicknessID) {
		return findByCriteria(Restrictions.eq("thickness.thicknessID", thicknessID));
	}
	
	/**
	 * Find Product by stiffnessID
	 */
	@SuppressWarnings("unchecked")
	public List<Product> findByStiffnessID(Long stiffnessID) {
		return findByCriteria(Restrictions.eq("stiffness.stiffnessID", stiffnessID));
	}
	
	/**
	 * Find Product by overlayTypeID
	 */
	@SuppressWarnings("unchecked")
	public List<Product> findByOverlayTypeID(Long overlayTypeID) {
		return findByCriteria(Restrictions.eq("overlaytype.overlayTypeID", overlayTypeID));
	}
	

}
