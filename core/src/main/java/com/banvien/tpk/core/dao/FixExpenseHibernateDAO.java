package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.FixExpense;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * <p>Hibernate DAO layer for FixExpenses</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class FixExpenseHibernateDAO extends
		AbstractHibernateDAO<FixExpense, Long> implements
		FixExpenseDAO {

	/**
	 * Find FixExpense by name
	 */
	public List<FixExpense> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}

    @Override
    public List<FixExpense> findAllByOrder(final String order) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<FixExpense>>() {
                    public List<FixExpense> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM FixExpense ");
                        if(StringUtils.isNotBlank(order)){
                            sqlQuery.append(" order by ").append(order).append(" ASC");
                        }
                        Query query = session.createQuery(sqlQuery.toString());

                        return (List<FixExpense>) query.list() ;
                    }
                });
    }


}
