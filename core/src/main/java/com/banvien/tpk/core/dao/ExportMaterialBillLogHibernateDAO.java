package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.ExportMaterialBillLog;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * <p>Hibernate DAO layer for ExportMaterialBillLogs</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ExportMaterialBillLogHibernateDAO extends
		AbstractHibernateDAO<ExportMaterialBillLog, Long> implements
		ExportMaterialBillLogDAO {

	/**
	 * Find ExportMaterialBillLog by name
	 */
	public List<ExportMaterialBillLog> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find ExportMaterialBillLog by code
	 */
	public List<ExportMaterialBillLog> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find ExportMaterialBillLog by sign
	 */
	public List<ExportMaterialBillLog> findBySign(String sign) {
		return findByCriteria(Restrictions.eq("sign", sign));
	}
	

}
