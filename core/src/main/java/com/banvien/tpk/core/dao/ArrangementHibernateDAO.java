package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Arrangement;
import com.banvien.tpk.core.domain.Arrangement;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Arrangements</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ArrangementHibernateDAO extends
		AbstractHibernateDAO<Arrangement, Long> implements
		ArrangementDAO {

	/**
	 * Find Arrangement by name
	 */
	public List<Arrangement> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}

    @Override
    public List<Arrangement> findByPlanIDs(final List<Long> productionPlanIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Arrangement>>() {
                    public List<Arrangement> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Arrangement ar WHERE 1 = 1");
                        sqlQuery.append(" AND ar.fromDate <= (SELECT MIN(p.date) FROM ProductionPlan p WHERE p.productionPlanID IN (:productionPlanIDs))");
                        sqlQuery.append(" AND ar.toDate >= (SELECT MAX(p.date) FROM ProductionPlan p WHERE p.productionPlanID IN (:productionPlanIDs))");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("productionPlanIDs", productionPlanIDs);
                        return (List<Arrangement>) query.list();
                    }
                });
    }

}
