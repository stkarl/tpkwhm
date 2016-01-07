package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.ProvinceDAO;
import com.banvien.tpk.core.domain.Province;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Provinces</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ProvinceHibernateDAO extends
		AbstractHibernateDAO<Province, Long> implements
		ProvinceDAO {

	/**
	 * Find Province by name
	 */
	public List<Province> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Province by regionID
	 */
	@SuppressWarnings("unchecked")
	public List<Province> findByRegionID(Long regionID) {
		return findByCriteria(Restrictions.eq("region.regionID", regionID));
	}
	

}
