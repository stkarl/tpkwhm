package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.WarehousemachinecomponentDAO;
import com.banvien.tpk.core.domain.Warehousemachinecomponent;

import org.hibernate.criterion.Restrictions;

/**
 * <p>Hibernate DAO layer for Warehousemachinecomponents</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class WarehousemachinecomponentHibernateDAO extends
		AbstractHibernateDAO<Warehousemachinecomponent, Long> implements
		WarehousemachinecomponentDAO {

	/**
	 * Find Warehousemachinecomponent by warehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<Warehousemachinecomponent> findByWarehouseID(Long warehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.warehouseID", warehouseID));
	}
	
	/**
	 * Find Warehousemachinecomponent by machineComponentID
	 */
	@SuppressWarnings("unchecked")
	public List<Warehousemachinecomponent> findByMachineComponentID(Long machineComponentID) {
		return findByCriteria(Restrictions.eq("machinecomponent.machineComponentID", machineComponentID));
	}
	
	/**
	 * Find Warehousemachinecomponent by quantity
	 */
	public List<Warehousemachinecomponent> findByQuantity(Integer quantity) {
		return findByCriteria(Restrictions.eq("quantity", quantity));
	}
	

}
