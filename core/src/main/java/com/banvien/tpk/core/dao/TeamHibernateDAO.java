package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Team;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * <p>Hibernate DAO layer for Teams</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class TeamHibernateDAO extends
		AbstractHibernateDAO<Team, Long> implements
		TeamDAO {

	/**
	 * Find Team by name
	 */
	public List<Team> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
}
