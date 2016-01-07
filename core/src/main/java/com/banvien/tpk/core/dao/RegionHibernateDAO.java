package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.RegionDAO;
import com.banvien.tpk.core.domain.Region;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Regions</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class RegionHibernateDAO extends
		AbstractHibernateDAO<Region, Long> implements
		RegionDAO {

	/**
	 * Find Region by name
	 */
	public List<Region> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	

}
