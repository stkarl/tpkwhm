package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Size;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Sizes</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class SizeHibernateDAO extends
		AbstractHibernateDAO<Size, Long> implements
		SizeDAO {

	/**
	 * Find Size by name
	 */
	public List<Size> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Size by code
	 */
	public List<Size> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Size by description
	 */
	public List<Size> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}

    @Override
    public List<Size> findAllByOrder(final String order) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Size>>() {
                    public List<Size> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Size ");
                        if(StringUtils.isNotBlank(order)){
                            sqlQuery.append(" order by ").append(order).append(" ASC");
                        }
                        Query query = session.createQuery(sqlQuery.toString());

                        return (List<Size>) query.list() ;
                    }
                });
    }

    @Override
    public List<Size> findByIds(final List<Long> sizeIds) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Size>>() {
                    public List<Size> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Size s WHERE s.sizeID IN (:sizeIds)");
                        sqlQuery.append(" order by s.name ASC");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("sizeIds", sizeIds);

                        return (List<Size>) query.list() ;
                    }
                });
    }


}
