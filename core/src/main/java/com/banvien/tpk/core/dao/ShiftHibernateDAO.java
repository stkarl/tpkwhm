package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Shift;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * <p>Hibernate DAO layer for Shifts</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ShiftHibernateDAO extends
		AbstractHibernateDAO<Shift, Long> implements
		ShiftDAO {

	/**
	 * Find Shift by name
	 */
	public List<Shift> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
}
