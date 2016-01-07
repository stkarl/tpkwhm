package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.MarketDAO;
import com.banvien.tpk.core.domain.Market;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Markets</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class MarketHibernateDAO extends
		AbstractHibernateDAO<Market, Long> implements
		MarketDAO {

	/**
	 * Find Market by name
	 */
	public List<Market> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Market by code
	 */
	public List<Market> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Market by description
	 */
	public List<Market> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	

}
