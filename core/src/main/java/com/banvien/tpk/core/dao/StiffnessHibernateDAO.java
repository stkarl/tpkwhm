package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.StiffnessDAO;
import com.banvien.tpk.core.domain.Stiffness;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Stiffnesss</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class StiffnessHibernateDAO extends
		AbstractHibernateDAO<Stiffness, Long> implements
		StiffnessDAO {

	/**
	 * Find Stiffness by name
	 */
	public List<Stiffness> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Stiffness by code
	 */
	public List<Stiffness> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Stiffness by description
	 */
	public List<Stiffness> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	

}
