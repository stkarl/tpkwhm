package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.BookProductBill;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class BookProductBillHibernateDAO extends
		AbstractHibernateDAO<BookProductBill, Long> implements
		BookProductBillDAO {

	@SuppressWarnings("unchecked")
	public List<BookProductBill> findByCustomerID(Long customerID) {
		return findByCriteria(Restrictions.eq("customer.customerID", customerID));
	}

	@SuppressWarnings("unchecked")
	public List<BookProductBill> findByCreatedBy(Long createdBy) {
		return findByCriteria(Restrictions.eq("user.createdBy", createdBy));
	}
	public List<BookProductBill> findByStatus(Integer status) {
		return findByCriteria(Restrictions.eq("status", status));
	}

    @Override
    public BookProductBill findWaitingBillByUserCustomerAndDate(final Long loginUserId, final Long customerID, final Timestamp deliveryDate) {
        return getHibernateTemplate().execute(
                new HibernateCallback<BookProductBill>() {
                    public BookProductBill doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM BookProductBill b WHERE (b.status = :wait OR b.status = :rejected) AND b.createdBy.userID = :loginUserId ");
                        if(customerID != null){
                            sqlQuery.append(" AND b.customer.customerID = :customerID");
                        }else{
                            sqlQuery.append(" AND b.customer IS NULL");
                        }
                        if(deliveryDate != null){
                            sqlQuery.append(" AND b.deliveryDate = :deliveryDate");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("wait", Constants.BOOK_WAIT_CONFIRM);
                        query.setParameter("rejected", Constants.BOOK_REJECTED);

                        query.setParameter("loginUserId", loginUserId);
                        if(customerID != null){
                            query.setParameter("customerID", customerID);
                        }
                        if(deliveryDate != null){
                            query.setParameter("deliveryDate", deliveryDate);
                        }
                        return (BookProductBill) query.uniqueResult();
                    }
                });
    }

    @Override
    public String getLatestBookBillNumber() {
        return getHibernateTemplate().execute(
                new HibernateCallback<String>() {
                    public String doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT MAX(CONVERT(SUBSTRING_INDEX(b.description,'-',-1),SIGNED INTEGER)) FROM BookProductBill b");
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        String code = query.uniqueResult() != null ? query.uniqueResult().toString() : "0";
                        return code;
                    }
                });
    }

}
