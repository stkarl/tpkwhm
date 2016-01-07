package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Importproductbill;
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
 * <p>Hibernate DAO layer for Importproductbills</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ImportproductbillHibernateDAO extends
		AbstractHibernateDAO<Importproductbill, Long> implements
		ImportproductbillDAO {

	/**
	 * Find Importproductbill by warehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<Importproductbill> findByWarehouseID(Long warehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.warehouseID", warehouseID));
	}
	
	/**
	 * Find Importproductbill by code
	 */
	public List<Importproductbill> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Importproductbill by description
	 */
	public List<Importproductbill> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	
	/**
	 * Find Importproductbill by createdBy
	 */
	@SuppressWarnings("unchecked")
	public List<Importproductbill> findByCreatedBy(Long createdBy) {
		return findByCriteria(Restrictions.eq("user.createdBy", createdBy));
	}
	
	/**
	 * Find Importproductbill by createdDate
	 */
	public List<Importproductbill> findByCreatedDate(Timestamp createdDate) {
		return findByCriteria(Restrictions.eq("createdDate", createdDate));
	}
	
	/**
	 * Find Importproductbill by produceDate
	 */
	public List<Importproductbill> findByProduceDate(Timestamp produceDate) {
		return findByCriteria(Restrictions.eq("produceDate", produceDate));
	}
	
	/**
	 * Find Importproductbill by importDate
	 */
	public List<Importproductbill> findByImportDate(Timestamp importDate) {
		return findByCriteria(Restrictions.eq("importDate", importDate));
	}
	
	/**
	 * Find Importproductbill by status
	 */
	public List<Importproductbill> findByStatus(Integer status) {
		return findByCriteria(Restrictions.eq("status", status));
	}
	
	/**
	 * Find Importproductbill by updatedBy
	 */
	@SuppressWarnings("unchecked")
	public List<Importproductbill> findByUpdatedBy(Long updatedBy) {
		return findByCriteria(Restrictions.eq("user.updatedBy", updatedBy));
	}
	
	/**
	 * Find Importproductbill by updatedDate
	 */
	public List<Importproductbill> findByUpdatedDate(Timestamp updatedDate) {
		return findByCriteria(Restrictions.eq("updatedDate", updatedDate));
	}
	
	/**
	 * Find Importproductbill by totalMoney
	 */
	public List<Importproductbill> findByTotalMoney(Double totalMoney) {
		return findByCriteria(Restrictions.eq("totalMoney", totalMoney));
	}
	
	/**
	 * Find Importproductbill by note
	 */
	public List<Importproductbill> findByNote(String note) {
		return findByCriteria(Restrictions.eq("note", note));
	}
	
	/**
	 * Find Importproductbill by produceGroup
	 */
	public List<Importproductbill> findByProduceGroup(String produceGroup) {
		return findByCriteria(Restrictions.eq("produceGroup", produceGroup));
	}

    @Override
    public void deleteByCode(final String code) {
        getHibernateTemplate().execute(
                new HibernateCallback<Object>() {
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("DELETE FROM Importproductbill ipb WHERE ipb.code = :code ");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("code",code);
                        return query.executeUpdate();
                    }
                });
    }

    @Override
    public String getLatestPNKTON() {
        return getHibernateTemplate().execute(
                new HibernateCallback<String>() {
                    public String doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT MAX(CONVERT(SUBSTRING_INDEX(b.code,'-',-1),SIGNED INTEGER)) FROM Importproductbill b");
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        String code = query.uniqueResult() != null ? query.uniqueResult().toString() : "0";
                        return code;
                    }
                });
    }

    @Override
    public String getLatestPTNTON() {
        return getHibernateTemplate().execute(
                new HibernateCallback<String>() {
                    public String doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT MAX(CONVERT(SUBSTRING_INDEX(b.code,'-',-1),SIGNED INTEGER)) FROM Importproductbill b WHERE b.code REGEXP 'TNK-?[0-9]+$'");
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        String code = query.uniqueResult() != null ? query.uniqueResult().toString() : "0";
                        return code;
                    }
                });
    }

    @Override
    public void deleteBlankBill() {
        getHibernateTemplate().execute(
                new HibernateCallback<Object>() {
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("DELETE FROM Importproductbill ipb WHERE ipb.importProductBillID NOT IN (" +
                                " SELECT DISTINCT ip.importproductbill.importProductBillID FROM importproduct ip) AND ipb.parentBill.importProductBillID IS NOT NULL");
                        Query query = session.createQuery(sqlQuery.toString());
                        return query.executeUpdate();
                    }
                });
    }

    @Override
    public Importproductbill findByParentBill(final Long billID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Importproductbill>() {
                    public Importproductbill doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproductbill ipb WHERE ipb.parentBill.importProductBillID = :billID ");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("billID", billID);
                        return (Importproductbill) query.uniqueResult();
                    }
                });
    }

    @Override
    public List<Importproductbill> find4Contract(final Date fromDate,final Date toDate,final Long customerID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproductbill>>() {
                    public List<Importproductbill> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproductbill ipb WHERE ipb.produceGroup = :buyGroup ");
                        if (fromDate != null){
                            sqlQuery.append(" AND ipb.importDate >= :fromDate");
                        }
                        if (toDate != null){
                            sqlQuery.append(" AND ipb.importDate <= :toDate");
                        }
                        if (customerID != null && customerID > 0){
                            sqlQuery.append(" AND ipb.customer.customerID = :customerID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("buyGroup", Constants.MATERIAL_GROUP_BUY);
                        if(fromDate != null){
                            query.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                            query.setParameter("toDate", toDate);
                        }
                        if(customerID != null && customerID > 0){
                            query.setParameter("customerID", customerID);
                        }
                        return (List<Importproductbill>) query.list();
                    }
                });
    }

    @Override
    public List<Importproductbill> findAllByOrderAndDateLimit(final String orderBy, final Boolean black,final Long date) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproductbill>>() {
                    public List<Importproductbill> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproductbill ipb WHERE ipb.produceGroup = :buyGroup ");
                        if (date != null){
                            sqlQuery.append(" AND ipb.importDate >= :date");
                        }
                        if (StringUtils.isNotBlank(orderBy)){
                            sqlQuery.append(" ORDER BY :orderBy ASC");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if (date != null){
                            query.setParameter("date", new Timestamp(System.currentTimeMillis() - date));
                        }
                        if(black){
                            query.setParameter("buyGroup", Constants.PRODUCT_GROUP_BUY);
                        }else {
                            query.setParameter("buyGroup", Constants.PRODUCT_GROUP_PRODUCED);
                        }
                        if (StringUtils.isNotBlank(orderBy)){
                            query.setParameter("orderBy", orderBy);
                        }
                        return (List<Importproductbill>) query.list();
                    }
                });
    }

    @Override
    public List<Importproductbill> findByIds(final List<Long> billIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproductbill>>() {
                    public List<Importproductbill> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproductbill ipb WHERE ipb.importProductBillID IN (:billIDs) order by createdDate ");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("billIDs", billIDs);
                        return (List<Importproductbill>) query.list();
                    }
                });
    }


}
