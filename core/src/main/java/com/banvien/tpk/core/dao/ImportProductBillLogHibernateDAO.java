package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.ImportProductBillLog;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * <p>Hibernate DAO layer for ImportProductBillLogs</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ImportProductBillLogHibernateDAO extends
		AbstractHibernateDAO<ImportProductBillLog, Long> implements
		ImportProductBillLogDAO {

	/**
	 * Find ImportProductBillLog by name
	 */
	public List<ImportProductBillLog> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find ImportProductBillLog by code
	 */
	public List<ImportProductBillLog> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find ImportProductBillLog by sign
	 */
	public List<ImportProductBillLog> findBySign(String sign) {
		return findByCriteria(Restrictions.eq("sign", sign));
	}
	

}
