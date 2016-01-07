package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.UserModule;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;


public class UserModuleHibernateDAO extends
		AbstractHibernateDAO<UserModule, Long> implements
		UserModuleDAO {


    @Override
    public List<UserModule> findByUserID(final Long userID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<UserModule>>() {
                    public List<UserModule> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM UserModule b WHERE b.user.userID = :userID ");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("userID", userID);
                        return (List<UserModule>) query.list();
                    }
                });
    }
}
