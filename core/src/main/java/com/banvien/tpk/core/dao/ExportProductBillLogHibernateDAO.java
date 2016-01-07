package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.ExportProductBillLog;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * <p>Hibernate DAO layer for ExportProductBillLogs</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ExportProductBillLogHibernateDAO extends
		AbstractHibernateDAO<ExportProductBillLog, Long> implements
		ExportProductBillLogDAO {

	/**
	 * Find ExportProductBillLog by name
	 */
	public List<ExportProductBillLog> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find ExportProductBillLog by code
	 */
	public List<ExportProductBillLog> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find ExportProductBillLog by sign
	 */
	public List<ExportProductBillLog> findBySign(String sign) {
		return findByCriteria(Restrictions.eq("sign", sign));
	}
	

}
