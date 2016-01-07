package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.SaleReason;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.security.cert.CertPathValidatorException;
import java.sql.SQLException;
import java.util.List;

/**
 * <p>Hibernate DAO layer for SaleReasons</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class SaleReasonHibernateDAO extends
		AbstractHibernateDAO<SaleReason, Long> implements
		SaleReasonDAO {

	

    @Override
    public List<SaleReason> findAllByOrder() {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<SaleReason>>() {
                    public List<SaleReason> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM SaleReason ");
                        sqlQuery.append(" order by displayOrder ASC");

                        Query query = session.createQuery(sqlQuery.toString());

                        return (List<SaleReason>) query.list() ;
                    }
                });
    }


}
