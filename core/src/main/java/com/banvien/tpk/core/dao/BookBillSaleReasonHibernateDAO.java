package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.BookBillSaleReason;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;


public class BookBillSaleReasonHibernateDAO extends
		AbstractHibernateDAO<BookBillSaleReason, Long> implements
		BookBillSaleReasonDAO {


    @Override
    public List<BookBillSaleReason> findByBookBillID(final Long bookBillID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<BookBillSaleReason>>() {
                    public List<BookBillSaleReason> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM BookBillSaleReason b WHERE b.bookingProductBill.bookingProductBillID = :bookBillID ");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("bookBillID", bookBillID);
                        return (List<BookBillSaleReason>) query.list();
                    }
                });
    }
}
