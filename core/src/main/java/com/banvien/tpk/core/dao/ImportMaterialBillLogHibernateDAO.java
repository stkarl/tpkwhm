package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.ImportMaterialBillLog;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * <p>Hibernate DAO layer for ImportMaterialBillLogs</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ImportMaterialBillLogHibernateDAO extends
		AbstractHibernateDAO<ImportMaterialBillLog, Long> implements
		ImportMaterialBillLogDAO {

	/**
	 * Find ImportMaterialBillLog by name
	 */
	public List<ImportMaterialBillLog> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find ImportMaterialBillLog by code
	 */
	public List<ImportMaterialBillLog> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find ImportMaterialBillLog by sign
	 */
	public List<ImportMaterialBillLog> findBySign(String sign) {
		return findByCriteria(Restrictions.eq("sign", sign));
	}
	

}
