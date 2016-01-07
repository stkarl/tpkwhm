package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Exportmaterialbill;
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
 * <p>Hibernate DAO layer for Exportmaterialbills</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ExportmaterialbillHibernateDAO extends
		AbstractHibernateDAO<Exportmaterialbill, Long> implements
		ExportmaterialbillDAO {

	/**
	 * Find Exportmaterialbill by receiver
	 */
	public List<Exportmaterialbill> findByReceiver(String receiver) {
		return findByCriteria(Restrictions.eq("receiver", receiver));
	}
	
	/**
	 * Find Exportmaterialbill by exportTypeID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportmaterialbill> findByExportTypeID(Long exportTypeID) {
		return findByCriteria(Restrictions.eq("exporttype.exportTypeID", exportTypeID));
	}
	
	/**
	 * Find Exportmaterialbill by exportWarehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportmaterialbill> findByExportWarehouseID(Long exportWarehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.exportWarehouseID", exportWarehouseID));
	}
	
	/**
	 * Find Exportmaterialbill by receiveWarehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportmaterialbill> findByReceiveWarehouseID(Long receiveWarehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.receiveWarehouseID", receiveWarehouseID));
	}
	
	/**
	 * Find Exportmaterialbill by code
	 */
	public List<Exportmaterialbill> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Exportmaterialbill by description
	 */
	public List<Exportmaterialbill> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	
	/**
	 * Find Exportmaterialbill by createdBy
	 */
	@SuppressWarnings("unchecked")
	public List<Exportmaterialbill> findByCreatedBy(Long createdBy) {
		return findByCriteria(Restrictions.eq("user.createdBy", createdBy));
	}
	
	/**
	 * Find Exportmaterialbill by createdDate
	 */
	public List<Exportmaterialbill> findByCreatedDate(Timestamp createdDate) {
		return findByCriteria(Restrictions.eq("createdDate", createdDate));
	}
	
	/**
	 * Find Exportmaterialbill by exportDate
	 */
	public List<Exportmaterialbill> findByExportDate(Timestamp exportDate) {
		return findByCriteria(Restrictions.eq("exportDate", exportDate));
	}
	
	/**
	 * Find Exportmaterialbill by status
	 */
	public List<Exportmaterialbill> findByStatus(Integer status) {
		return findByCriteria(Restrictions.eq("status", status));
	}
	
	/**
	 * Find Exportmaterialbill by updatedBy
	 */
	@SuppressWarnings("unchecked")
	public List<Exportmaterialbill> findByUpdatedBy(Long updatedBy) {
		return findByCriteria(Restrictions.eq("user.updatedBy", updatedBy));
	}
	
	/**
	 * Find Exportmaterialbill by updatedDate
	 */
	public List<Exportmaterialbill> findByUpdatedDate(Timestamp updatedDate) {
		return findByCriteria(Restrictions.eq("updatedDate", updatedDate));
	}
	
	/**
	 * Find Exportmaterialbill by note
	 */
	public List<Exportmaterialbill> findByNote(String note) {
		return findByCriteria(Restrictions.eq("note", note));
	}

    @Override
    public String getLatestPXKPL() {
        return getHibernateTemplate().execute(
                new HibernateCallback<String>() {
                    public String doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT MAX(CONVERT(SUBSTRING_INDEX(b.code,'-',-1),SIGNED INTEGER)) FROM Exportmaterialbill b");
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        String code = query.uniqueResult() != null ? query.uniqueResult().toString() : "0";
                        return code;
                    }
                });
    }

    @Override
    public List<Exportmaterialbill> findAllByOrderAndDateLimit(final String orderBy,final Long date) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Exportmaterialbill>>() {
                    public List<Exportmaterialbill> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Exportmaterialbill ipb WHERE 1 = 1 ");
                        if (date != null){
                            sqlQuery.append(" AND ipb.exportDate >= :date");
                        }
                        if (StringUtils.isNotBlank(orderBy)){
                            sqlQuery.append(" ORDER BY :orderBy ASC");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if (date != null){
                            query.setParameter("date", new Timestamp(System.currentTimeMillis() - date));
                        }
                        if (StringUtils.isNotBlank(orderBy)){
                            query.setParameter("orderBy", orderBy);
                        }
                        return (List<Exportmaterialbill>) query.list();
                    }
                });
    }


}
