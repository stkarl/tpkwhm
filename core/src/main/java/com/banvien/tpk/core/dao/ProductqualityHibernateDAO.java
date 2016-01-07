package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.ProductqualityDAO;
import com.banvien.tpk.core.domain.Productquality;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Productqualitys</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ProductqualityHibernateDAO extends
		AbstractHibernateDAO<Productquality, Long> implements
		ProductqualityDAO {

	/**
	 * Find Productquality by importProductID
	 */
	@SuppressWarnings("unchecked")
	public List<Productquality> findByImportProductID(Long importProductID) {
		return findByCriteria(Restrictions.eq("importproduct.importProductID", importProductID));
	}
	
	/**
	 * Find Productquality by qualityID
	 */
	@SuppressWarnings("unchecked")
	public List<Productquality> findByQualityID(Long qualityID) {
		return findByCriteria(Restrictions.eq("quality.qualityID", qualityID));
	}
	
	/**
	 * Find Productquality by unit1ID
	 */
	@SuppressWarnings("unchecked")
	public List<Productquality> findByUnit1ID(Long unit1ID) {
		return findByCriteria(Restrictions.eq("unit.unit1ID", unit1ID));
	}
	
	/**
	 * Find Productquality by quantity1
	 */
	public List<Productquality> findByQuantity1(Double quantity1) {
		return findByCriteria(Restrictions.eq("quantity1", quantity1));
	}
	
	/**
	 * Find Productquality by unit2ID
	 */
	@SuppressWarnings("unchecked")
	public List<Productquality> findByUnit2ID(Long unit2ID) {
		return findByCriteria(Restrictions.eq("unit.unit2ID", unit2ID));
	}
	
	/**
	 * Find Productquality by quantity2
	 */
	public List<Productquality> findByQuantity2(Double quantity2) {
		return findByCriteria(Restrictions.eq("quantity2", quantity2));
	}
	

}
