package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.OweLog;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>Hibernate DAO layer for OweLogs</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class OweLogHibernateDAO extends
		AbstractHibernateDAO<OweLog, Long> implements
		OweLogDAO {


    @Override
    public List<Object> findCustomerInitialOwe(final List<Long> customerIds,final Date beforeDate) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Object>>() {
                    public List<Object> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT ol.customerId as customerId, SUM(ol.pay) as pay, ol.type as type FROM OweLog ol ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.customerID IN (:customerIds)")
                                .append(" AND (ol.payDate IS NOT NULL")
                                .append(" AND ol.payDate < :beforeDate)")
                                .append(" GROUP BY customerId, type")
                                .append(" UNION ALl ")
                                .append(" SELECT ol.customerId as customerId, SUM(ol.pay) as pay, ol.type as type FROM OweLog ol ")
                                .append(" WHERE 1 = 1")
                                .append(" AND ol.customerID IN (:customerIds)")
                                .append(" AND (ol.oweDate IS NOT NULL")
                                .append(" AND ol.oweDate < :beforeDate)")
                                .append(" GROUP BY customerId, type");
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        query.setParameterList("customerIds", customerIds);
                        query.setParameter("beforeDate", beforeDate);
                        return (List<Object>) query.list();
                    }
                });
    }

    @Override
    public List<OweLog> findCustomerPaid(final List<Long> customerIds,final Date fromDate,final Date toDate) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<OweLog>>() {
                    public List<OweLog> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM OweLog ol ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.customer.customerID IN (:customerIds)")
                                .append(" AND ol.payDate >= :fromDate")
                                .append(" AND ol.payDate <= :toDate");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("customerIds", customerIds);
                        query.setParameter("fromDate", fromDate);
                        query.setParameter("toDate", toDate);
                        return (List<OweLog>) query.list();
                    }
                });
    }

    @Override
    public List<OweLog> findCustomerMoneyBought(final List<Long> customerIds,final Date fromDate,final Date toDate) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<OweLog>>() {
                    public List<OweLog> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM OweLog ol ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.customer.customerID IN (:customerIds)")
                                .append(" AND ol.oweDate >= :fromDate")
                                .append(" AND ol.oweDate <= :toDate");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("customerIds", customerIds);
                        query.setParameter("fromDate", fromDate);
                        query.setParameter("toDate", toDate);
                        return (List<OweLog>) query.list();
                    }
                });
    }

    @Override
    public List<Object> findCustomerDueDate(final List<Long> customerIds,final Date beforeDate) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Object>>() {
                    public List<Object> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT ol.customerID, INTERVAL ol.dayAllow DAY + ol.oweDate FROM OweLog ol ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.customerID IN (:customerIds)")
                                .append(" AND ol.oweDate = (SELECT MAX(temp.oweDate) FROM OweLog temp WHERE")
                                .append("                    temp.customerID = ol.customerID AND temp.oweDate <= :beforeDate)");
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        query.setParameterList("customerIds", customerIds);
                        query.setParameter("beforeDate", beforeDate);
                        return (List<Object>) query.list();
                    }
                });
    }

    @Override
    public OweLog findOweByBookBill(final Long bookProductBillID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<OweLog>() {
                    public OweLog doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM OweLog ol ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.bookProductBill.bookProductBillID = :bookProductBillID AND oweDate IS NOT NULL");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("bookProductBillID", bookProductBillID);
                        return (OweLog) query.uniqueResult();
                    }
                });

    }

    @Override
    public List<OweLog> findPrePaidByBill(final Long bookProductBillID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<OweLog>>() {
                    public List<OweLog> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM OweLog ol ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.bookProductBill.bookProductBillID = :bookProductBillID AND payDate IS NOT NULL");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("bookProductBillID", bookProductBillID);
                        return (List<OweLog>) query.list();
                    }
                });
    }

    @Override
    public Double findCustomerOweUtilDate(final Long customerID,final Date date) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Double>() {
                    public Double doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer oweQuery = new StringBuffer("SELECT SUM(ol.pay) FROM OweLog ol ");
                        oweQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.oweDate IS NOT NULL AND ol.oweDate < :date AND ol.customer.customerID = :customerID");
                        Query query = session.createQuery(oweQuery.toString());
                        query.setParameter("customerID", customerID);
                        query.setParameter("date", date);
                        Double owe = query.uniqueResult() != null ? (Double) query.uniqueResult(): 0d;

                        StringBuffer payQuery = new StringBuffer("SELECT SUM(ol.pay) FROM OweLog ol ");
                        payQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.payDate IS NOT NULL AND ol.payDate < :date AND ol.customer.customerID = :customerID");
                        query = session.createQuery(payQuery.toString());
                        query.setParameter("customerID", customerID);
                        query.setParameter("date", date);
                        Double pay = query.uniqueResult() != null ? (Double) query.uniqueResult(): 0d;

                        return owe - pay;
                    }
                });
    }

    @Override
    public Map<Long,Double> findCustomersOweUtilDate(final List<Long> customerIDs,final Timestamp date) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Map<Long,Double>>() {
                    public Map<Long,Double> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer oweQuery = new StringBuffer("SELECT SUM(ol.pay) as pay,ol.customer.customerID as customerID  FROM OweLog ol ");
                        oweQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.oweDate IS NOT NULL AND ol.oweDate < :date AND ol.customer.customerID IN (:customerIDs)")
                                .append(" GROUP BY customerID");
                        Query query = session.createQuery(oweQuery.toString());
                        query.setParameterList("customerIDs", customerIDs);
                        query.setParameter("date", date);
                        List<Object[]> owes = query.list();

                        Map<Long,Double> mapCustomersOwe = new HashMap<Long, Double>();
                        if(owes != null){
                            for(Object[] objs : owes){
                                Double owe = (Double) objs[0];
                                Long customerID = (Long) objs[1];
                                mapCustomersOwe.put(customerID,owe);
                            }
                        }

                        StringBuffer payQuery = new StringBuffer("SELECT SUM(ol.pay) as pay,ol.customer.customerID as customerID FROM OweLog ol ");
                        payQuery.append(" WHERE 1 = 1")
                                .append(" AND ol.payDate IS NOT NULL AND ol.payDate < :date AND ol.customer.customerID IN (:customerIDs)")
                                .append(" GROUP BY customerID");
                        query = session.createQuery(payQuery.toString());
                        query.setParameterList("customerIDs", customerIDs);
                        query.setParameter("date", date);
                        List<Object[]> pays = query.list();
                        if(pays != null){
                            for(Object[] objs : pays){
                                Double pay = (Double) objs[0];
                                Long customerID = (Long) objs[1];
                                if(!mapCustomersOwe.containsKey(customerID)){
                                    mapCustomersOwe.put(customerID, 0 - pay);
                                }else{
                                    mapCustomersOwe.put(customerID, mapCustomersOwe.get(customerID) - pay);
                                }
                            }
                        }
                        return mapCustomersOwe;
                    }
                });
    }
}
