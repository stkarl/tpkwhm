package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Module;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;


/**
 * <p>Hibernate DAO layer for Modules</p>
 * <p>Generated at Tue Jul 10 16:04:17 ICT 2012</p>
 *
 * @author Salto-db Generator v1.1 / EJB3 + Spring/Hibernate DAO
 */
public class ModuleHibernateDAO extends
		AbstractHibernateDAO<Module, Long> implements
		ModuleDAO {

    public ModuleHibernateDAO() {
		super(Module.class);
	}

    @Override
    public List<Module> findItemsWithPrefix(final String prefix) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Module>>() {
                    public List<Module> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM Module s WHERE s.name LIKE '%" + prefix + "%' ORDER BY name");
                        return (List<Module>) query.list();
                    }
                });
    }
}
