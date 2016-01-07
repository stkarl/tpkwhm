package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Setting;

import java.util.List;

/**
 * <p>Generic DAO layer for Settings</p>
 * <p>Generated at Tue Jul 10 16:04:17 ICT 2012</p>
 *
 * @author Salto-db Generator v1.1 / EJB3 + Spring/Hibernate DAO
 */
public interface SettingDAO extends GenericDAO<Setting,Long> {

    List<Setting> findItemsWithPrefix(String prefix);
}