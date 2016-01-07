package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.MaterialAndCategory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;


public class MaterialAndCategoryHibernateDAO extends
		AbstractHibernateDAO<MaterialAndCategory, Long> implements
		MaterialAndCategoryDAO {


    @Override
    public List<MaterialAndCategory> findByMaterialID(final Long materialID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<MaterialAndCategory>>() {
                    public List<MaterialAndCategory> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM MaterialAndCategory b WHERE b.material.materialID = :materialID ");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("materialID", materialID);
                        return (List<MaterialAndCategory>) query.list();
                    }
                });
    }
}
