package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.UnitDAO;
import com.banvien.tpk.core.domain.Unit;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Units</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class UnitHibernateDAO extends
		AbstractHibernateDAO<Unit, Long> implements
		UnitDAO {

	/**
	 * Find Unit by name
	 */
	public List<Unit> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	

}
