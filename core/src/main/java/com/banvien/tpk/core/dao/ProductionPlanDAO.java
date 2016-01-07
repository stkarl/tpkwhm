package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.ProductionPlan;

import java.util.List;

/**
 * <p>Generic DAO layer for ProductionPlans</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ProductionPlanDAO extends GenericDAO<ProductionPlan,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildProductionPlanDAO()
	 */
	  	 
	/**
	 * Find ProductionPlan by name
	 */
	public List<ProductionPlan> findByName(String name);

	/**
	 * Find ProductionPlan by warehouseID
	 */
	public List<ProductionPlan> findByWarehouseID(Long warehouseID);

	List<Object[]> getProductionDetail(List<Long> planIds);
}