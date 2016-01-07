package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.User;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;


/**
 * <p>Hibernate DAO layer for Users</p>
 * <p>Generated at Thu Jun 14 18:28:11 GMT+07:00 2012</p>
 *
 * @author Salto-db Generator v1.1 / EJB3 + Spring/Hibernate DAO
 */
public class UserHibernateDAO extends
		AbstractHibernateDAO<User, Long> implements
		UserDAO {

    public UserHibernateDAO() {
		super(User.class);
	}

    @Override
    public User findByUsername(final String username) {
        return getHibernateTemplate().execute(
            new HibernateCallback<User>() {
                public User doInHibernate(Session session)
                        throws HibernateException, SQLException {
                    Query query = session
                            .createQuery("FROM User u WHERE u.userName = ?");
                    query.setParameter(0, username);
                    return (User) query.uniqueResult();
                }
            });
    }

    @Override
    public User findByUserIDAndPassword(final Long userID, final  String password) {
        return getHibernateTemplate().execute(
                new HibernateCallback<User>() {
                    public User doInHibernate(Session session)
                            throws HibernateException, SQLException {

                        Query query = session
                                .createQuery("FROM User u WHERE u.userID = :userID And u.password = :password");
                        query.setParameter("userID", userID);
                        query.setParameter("password", password);
                        return (User) query.uniqueResult();
                    }
                });
    }

    @Override
    public List<User> findByRoles(final List<String> roles) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<User>>() {
                    public List<User> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuilder sqlQuery = new StringBuilder();
                        sqlQuery.append("FROM User u");
                        if(roles != null && roles.size() > 0){
                            sqlQuery.append(" WHERE u.role IN (:roles)");
                        }
                        sqlQuery.append(" ORDER BY u.role, u.liveManager.userID");

                        Query query = session.createQuery(sqlQuery.toString());
                        if(roles != null && roles.size() > 0){
                            query.setParameterList("roles", roles);
                        }
                        return (List<User>) query.list();
                    }
                });
    }

    @Override
    public List<User> findListUserByName(final Long userID, final String userName) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<User>>() {
                    public List<User> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuilder sqlQuery = new StringBuilder();
                        sqlQuery.append("FROM User u where u.liveManager.userID = "+ userID +" AND u.userName like '%"+userName+"%'");
                        Query query = session.createQuery(sqlQuery.toString());
                        return (List<User>) query.list();
                    }
                });
    }

    @Override
    public List<User> findByIds(final List<Long> userIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<User>>() {
                    public List<User> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuilder sqlQuery = new StringBuilder();
                        sqlQuery.append("SELECT u FROM User u WHERE u.id IN(:userIDs)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("userIDs",userIDs);
                        return (List<User>) query.list();
                    }
                });
    }

    @Override
    public List<String> findAllRoles() {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<String>>() {
                    public List<String> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuilder sqlQuery = new StringBuilder();
                        sqlQuery.append("select distinct(u.Role) from User u ORDER BY u.Role ");
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        return (List<String>) query.list();
                    }
                });
    }

}
