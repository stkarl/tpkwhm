package com.banvien.tpk.core.dao;

import java.sql.SQLException;
import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.ExporttypeDAO;
import com.banvien.tpk.core.domain.Exporttype;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * <p>Hibernate DAO layer for Exporttypes</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ExporttypeHibernateDAO extends
		AbstractHibernateDAO<Exporttype, Long> implements
		ExporttypeDAO {

	/**
	 * Find Exporttype by name
	 */
	public List<Exporttype> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}

    @Override
    public List<Exporttype> findExcludeCode(final String code) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Exporttype>>() {
                    public List<Exporttype> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Exporttype et WHERE 1 = 1");
                        if(code != null){
                            sqlQuery.append(" AND et.code != :code");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if(code != null){
                            query.setParameter("code",code);
                        }
                        return (List<Exporttype>) query.list() ;
                    }
                });
    }


}
