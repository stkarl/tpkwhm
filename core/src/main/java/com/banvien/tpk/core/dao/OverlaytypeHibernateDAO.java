package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.OverlaytypeDAO;
import com.banvien.tpk.core.domain.Overlaytype;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Overlaytypes</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class OverlaytypeHibernateDAO extends
		AbstractHibernateDAO<Overlaytype, Long> implements
		OverlaytypeDAO {

	/**
	 * Find Overlaytype by name
	 */
	public List<Overlaytype> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Overlaytype by code
	 */
	public List<Overlaytype> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Overlaytype by description
	 */
	public List<Overlaytype> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	

}
