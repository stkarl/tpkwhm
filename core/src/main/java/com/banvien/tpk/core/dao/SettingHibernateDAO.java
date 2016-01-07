package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Setting;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;


/**
 * <p>Hibernate DAO layer for Settings</p>
 * <p>Generated at Tue Jul 10 16:04:17 ICT 2012</p>
 *
 * @author Salto-db Generator v1.1 / EJB3 + Spring/Hibernate DAO
 */
public class SettingHibernateDAO extends
		AbstractHibernateDAO<Setting, Long> implements
		SettingDAO {

    public SettingHibernateDAO() {
		super(Setting.class);
	}

    @Override
    public List<Setting> findItemsWithPrefix(final String prefix) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Setting>>() {
                    public List<Setting> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM Setting s WHERE s.fieldName LIKE '" + prefix + "%' ORDER BY fieldName");
                        return (List<Setting>) query.list();
                    }
                });
    }
}
