package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Module;

import java.util.List;

/**
 * <p>Generic DAO layer for Modules</p>
 * <p>Generated at Tue Jul 10 16:04:17 ICT 2012</p>
 *
 * @author Salto-db Generator v1.1 / EJB3 + Spring/Hibernate DAO
 */
public interface ModuleDAO extends GenericDAO<Module,Long> {

    List<Module> findItemsWithPrefix(String prefix);
}