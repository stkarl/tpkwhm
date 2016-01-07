package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.BookProductBill;
import com.banvien.tpk.core.domain.UserCustomer;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;


public class UserCustomerHibernateDAO extends
		AbstractHibernateDAO<UserCustomer, Long> implements
		UserCustomerDAO {


    @Override
    public List<UserCustomer> findByUserID(final Long userID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<UserCustomer>>() {
                    public List<UserCustomer> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM UserCustomer b WHERE b.user.userID = :userID ");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("userID", userID);
                        return (List<UserCustomer>) query.list();
                    }
                });
    }
}
