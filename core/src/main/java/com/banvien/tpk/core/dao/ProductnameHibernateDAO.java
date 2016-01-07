package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Productname;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Productnames</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ProductnameHibernateDAO extends
		AbstractHibernateDAO<Productname, Long> implements
		ProductnameDAO {

	/**
	 * Find Productname by name
	 */
	public List<Productname> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Productname by code
	 */
	public List<Productname> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Productname by description
	 */
	public List<Productname> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}

}
