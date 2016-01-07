package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Colour;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Colours</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ColourHibernateDAO extends
		AbstractHibernateDAO<Colour, Long> implements
		ColourDAO {

	/**
	 * Find Colour by name
	 */
	public List<Colour> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Colour by code
	 */
	public List<Colour> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Colour by sign
	 */
	public List<Colour> findBySign(String sign) {
		return findByCriteria(Restrictions.eq("sign", sign));
	}

    @Override
    public List<Colour> findAllByOrder(final String order) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Colour>>() {
                    public List<Colour> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Colour ");
                        if(StringUtils.isNotBlank(order)){
                            sqlQuery.append(" order by ").append(order).append(" ASC");
                        }
                        Query query = session.createQuery(sqlQuery.toString());

                        return (List<Colour>) query.list() ;
                    }
                });
    }


}
