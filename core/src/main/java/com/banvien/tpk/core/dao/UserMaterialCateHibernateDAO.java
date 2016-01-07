package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.UserMaterialCate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;


public class UserMaterialCateHibernateDAO extends
		AbstractHibernateDAO<UserMaterialCate, Long> implements
		UserMaterialCateDAO {


    @Override
    public List<UserMaterialCate> findByUserID(final Long userID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<UserMaterialCate>>() {
                    public List<UserMaterialCate> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM UserMaterialCate b WHERE b.user.userID = :userID ");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("userID", userID);
                        return (List<UserMaterialCate>) query.list();
                    }
                });
    }
}
