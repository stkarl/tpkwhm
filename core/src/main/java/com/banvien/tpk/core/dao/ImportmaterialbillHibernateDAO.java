package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Importmaterialbill;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Importmaterialbills</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ImportmaterialbillHibernateDAO extends
		AbstractHibernateDAO<Importmaterialbill, Long> implements
		ImportmaterialbillDAO {

	/**
	 * Find Importmaterialbill by customerID
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterialbill> findByCustomerID(Long customerID) {
		return findByCriteria(Restrictions.eq("customer.customerID", customerID));
	}
	
	/**
	 * Find Importmaterialbill by warehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterialbill> findByWarehouseID(Long warehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.warehouseID", warehouseID));
	}
	
	/**
	 * Find Importmaterialbill by code
	 */
	public List<Importmaterialbill> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Importmaterialbill by description
	 */
	public List<Importmaterialbill> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	
	/**
	 * Find Importmaterialbill by createdBy
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterialbill> findByCreatedBy(Long createdBy) {
		return findByCriteria(Restrictions.eq("user.createdBy", createdBy));
	}
	
	/**
	 * Find Importmaterialbill by importDate
	 */
	public List<Importmaterialbill> findByImportDate(Timestamp importDate) {
		return findByCriteria(Restrictions.eq("importDate", importDate));
	}
	
	/**
	 * Find Importmaterialbill by status
	 */
	public List<Importmaterialbill> findByStatus(Integer status) {
		return findByCriteria(Restrictions.eq("status", status));
	}
	
	/**
	 * Find Importmaterialbill by updatedBy
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterialbill> findByUpdatedBy(Long updatedBy) {
		return findByCriteria(Restrictions.eq("user.updatedBy", updatedBy));
	}
	
	/**
	 * Find Importmaterialbill by updatedDate
	 */
	public List<Importmaterialbill> findByUpdatedDate(Timestamp updatedDate) {
		return findByCriteria(Restrictions.eq("updatedDate", updatedDate));
	}
	
	/**
	 * Find Importmaterialbill by totalMoney
	 */
	public List<Importmaterialbill> findByTotalMoney(Double totalMoney) {
		return findByCriteria(Restrictions.eq("totalMoney", totalMoney));
	}
	
	/**
	 * Find Importmaterialbill by note
	 */
	public List<Importmaterialbill> findByNote(String note) {
		return findByCriteria(Restrictions.eq("note", note));
	}

    @Override
    public String getLatestPNKPL() {
        return getHibernateTemplate().execute(
                new HibernateCallback<String>() {
                    public String doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT MAX(CONVERT(SUBSTRING_INDEX(b.code,'-',-1),SIGNED INTEGER)) FROM Importmaterialbill b");
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        String code = query.uniqueResult() != null ? query.uniqueResult().toString() : "0";
                        return code;
                    }
                });
    }

    @Override
    public List<Importmaterialbill> findAllByOrderAndDateLimit(final String orderBy,final Long date) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importmaterialbill>>() {
                    public List<Importmaterialbill> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importmaterialbill im ");
                        if (date != null){
                            sqlQuery.append(" WHERE im.importDate >= :date");
                        }
                        if (StringUtils.isNotBlank(orderBy)){
                            sqlQuery.append(" ORDER BY :orderBy ASC");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if (StringUtils.isNotBlank(orderBy)){
                            query.setParameter("orderBy", orderBy);
                        }
                        if (date != null){
                            query.setParameter("date", new Timestamp(System.currentTimeMillis() - date));
                        }
                        return (List<Importmaterialbill>) query.list();
                    }
                });
    }
}
