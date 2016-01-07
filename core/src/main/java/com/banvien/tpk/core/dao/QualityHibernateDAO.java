package com.banvien.tpk.core.dao;

import java.sql.SQLException;
import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.QualityDAO;
import com.banvien.tpk.core.domain.Quality;

import com.banvien.tpk.core.domain.Quality;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * <p>Hibernate DAO layer for Qualitys</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class QualityHibernateDAO extends
		AbstractHibernateDAO<Quality, Long> implements
		QualityDAO {

	/**
	 * Find Quality by name
	 */
	public List<Quality> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Quality by code
	 */
	public List<Quality> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Quality by description
	 */
	public List<Quality> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}

    @Override
    public List<Quality> findNonePPByOrder(final String order) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Quality>>() {
                    public List<Quality> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Quality WHERE code <> :code");
                        if(StringUtils.isNotBlank(order)){
                            sqlQuery.append(" order by ").append(order).append(" ASC");
                        }
                        Query query = session.createQuery(sqlQuery.toString());

                        query.setParameter("code", Constants.QUALITY_PP);
                        return (List<Quality>) query.list() ;
                    }
                });
    }


}
