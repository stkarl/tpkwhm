package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.OriginDAO;
import com.banvien.tpk.core.domain.Origin;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Origins</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class OriginHibernateDAO extends
		AbstractHibernateDAO<Origin, Long> implements
		OriginDAO {

	/**
	 * Find Origin by name
	 */
	public List<Origin> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Origin by description
	 */
	public List<Origin> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	

}
