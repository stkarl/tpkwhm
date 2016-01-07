package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.WarehouseMap;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * <p>Hibernate DAO layer for WarehouseMaps</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class WarehouseMapHibernateDAO extends
		AbstractHibernateDAO<WarehouseMap, Long> implements
		WarehouseMapDAO {

	/**
	 * Find WarehouseMap by name
	 */
	public List<WarehouseMap> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find WarehouseMap by warehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<WarehouseMap> findByWarehouseID(Long warehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.warehouseID", warehouseID));
	}

}
