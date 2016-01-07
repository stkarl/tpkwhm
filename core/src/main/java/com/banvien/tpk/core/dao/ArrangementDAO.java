package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Arrangement;

import java.util.List;

/**
 * <p>Generic DAO layer for Arrangements</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ArrangementDAO extends GenericDAO<Arrangement,Long> {
	public List<Arrangement> findByName(String name);

    List<Arrangement> findByPlanIDs(List<Long> productionPlanIDs);
}