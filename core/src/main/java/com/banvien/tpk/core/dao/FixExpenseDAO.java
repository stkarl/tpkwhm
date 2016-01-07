package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.FixExpense;

import java.util.List;

/**
 * <p>Generic DAO layer for FixExpenses</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface FixExpenseDAO extends GenericDAO<FixExpense,Long> {
	public List<FixExpense> findByName(String name);
    List<FixExpense> findAllByOrder(String name);
}