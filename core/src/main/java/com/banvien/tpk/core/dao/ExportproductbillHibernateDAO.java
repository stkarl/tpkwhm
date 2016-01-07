package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Exportproductbill;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Exportproductbills</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ExportproductbillHibernateDAO extends
		AbstractHibernateDAO<Exportproductbill, Long> implements
		ExportproductbillDAO {

	/**
	 * Find Exportproductbill by receiver
	 */
	public List<Exportproductbill> findByReceiver(String receiver) {
		return findByCriteria(Restrictions.eq("receiver", receiver));
	}
	
	/**
	 * Find Exportproductbill by customerID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproductbill> findByCustomerID(Long customerID) {
		return findByCriteria(Restrictions.eq("customer.customerID", customerID));
	}
	
	/**
	 * Find Exportproductbill by exportTypeID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproductbill> findByExportTypeID(Long exportTypeID) {
		return findByCriteria(Restrictions.eq("exporttype.exportTypeID", exportTypeID));
	}
	
	/**
	 * Find Exportproductbill by exportWarehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproductbill> findByExportWarehouseID(Long exportWarehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.exportWarehouseID", exportWarehouseID));
	}
	
	/**
	 * Find Exportproductbill by receiveWarehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproductbill> findByReceiveWarehouseID(Long receiveWarehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.receiveWarehouseID", receiveWarehouseID));
	}
	
	/**
	 * Find Exportproductbill by code
	 */
	public List<Exportproductbill> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Exportproductbill by description
	 */
	public List<Exportproductbill> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	
	/**
	 * Find Exportproductbill by createdBy
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproductbill> findByCreatedBy(Long createdBy) {
		return findByCriteria(Restrictions.eq("user.createdBy", createdBy));
	}
	
	/**
	 * Find Exportproductbill by createdDate
	 */
	public List<Exportproductbill> findByCreatedDate(Timestamp createdDate) {
		return findByCriteria(Restrictions.eq("createdDate", createdDate));
	}
	
	/**
	 * Find Exportproductbill by exportDate
	 */
	public List<Exportproductbill> findByExportDate(Timestamp exportDate) {
		return findByCriteria(Restrictions.eq("exportDate", exportDate));
	}
	
	/**
	 * Find Exportproductbill by status
	 */
	public List<Exportproductbill> findByStatus(Integer status) {
		return findByCriteria(Restrictions.eq("status", status));
	}
	
	/**
	 * Find Exportproductbill by updatedBy
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproductbill> findByUpdatedBy(Long updatedBy) {
		return findByCriteria(Restrictions.eq("user.updatedBy", updatedBy));
	}
	
	/**
	 * Find Exportproductbill by updatedDate
	 */
	public List<Exportproductbill> findByUpdatedDate(Timestamp updatedDate) {
		return findByCriteria(Restrictions.eq("updatedDate", updatedDate));
	}
	
	/**
	 * Find Exportproductbill by note
	 */
	public List<Exportproductbill> findByNote(String note) {
		return findByCriteria(Restrictions.eq("note", note));
	}
	
	/**
	 * Find Exportproductbill by totalMoney
	 */
	public List<Exportproductbill> findByTotalMoney(Double totalMoney) {
		return findByCriteria(Restrictions.eq("totalMoney", totalMoney));
	}

    @Override
    public String getLatestPXKTON() {
        return getHibernateTemplate().execute(
                new HibernateCallback<String>() {
                    public String doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT MAX(CONVERT(SUBSTRING_INDEX(b.code,'-',-1),SIGNED INTEGER)) FROM Exportproductbill b");
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        String code = query.uniqueResult() != null ? query.uniqueResult().toString() : "0";
                        return code;
                    }
                });
    }

    @Override
    public List<Object> findCustomerLatestBoughtDate(final List<Long> customerIds,final Date beforeDate) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Object>>() {
                    public List<Object> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT ol.customer, ol.oweDate FROM OweLog ol ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.customer.customerID IN (:customerIds)")
                                .append(" AND ol.oweDate = (SELECT MAX(temp.oweDate) FROM  OweLog temp WHERE")
                                .append("                    temp.customer = ol.customer AND temp.oweDate <= :beforeDate)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("customerIds", customerIds);
                        query.setParameter("beforeDate", beforeDate);
                        return (List<Object>) query.list();
                    }
                });
    }

    @Override
    public List<Exportproductbill> findAllByOrderAndDateLimit(final String orderBy,final Boolean black,final Long date) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Exportproductbill>>() {
                    public List<Exportproductbill> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Exportproductbill ipb WHERE 1 = 1 ");
                        if(black){
                            sqlQuery.append(" AND EXISTS(SELECT 1 FROM Exportproduct ep WHERE ep.exportproductbill.exportProductBillID = ipb.exportProductBillID")
                                    .append(" AND ep.importproduct.productname.code = '").append(Constants.PRODUCT_BLACK).append("')");
                        }else{
                            sqlQuery.append(" AND EXISTS(SELECT 1 FROM Exportproduct ep WHERE ep.exportproductbill.exportProductBillID = ipb.exportProductBillID")
                                    .append(" AND ep.importproduct.productname.code <> '").append(Constants.PRODUCT_BLACK).append("')");
                        }
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
                        return (List<Exportproductbill>) query.list();
                    }
                });
    }


}
