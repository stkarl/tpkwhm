package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Thickness;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Thicknesss</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ThicknessHibernateDAO extends
		AbstractHibernateDAO<Thickness, Long> implements
		ThicknessDAO {

	/**
	 * Find Thickness by name
	 */
	public List<Thickness> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Thickness by code
	 */
	public List<Thickness> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Thickness by description
	 */
	public List<Thickness> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}

    @Override
    public List<Thickness> findAllByOrder(final String order) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Thickness>>() {
                    public List<Thickness> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Thickness ");
                        if(StringUtils.isNotBlank(order)){
                            sqlQuery.append(" order by ").append(order).append(" ASC");
                        }
                        Query query = session.createQuery(sqlQuery.toString());

                        return (List<Thickness>) query.list() ;
                    }
                });
    }


}
