package com.banvien.tpk.core.dao;

import java.sql.SQLException;
import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.MaterialcategoryDAO;
import com.banvien.tpk.core.domain.Materialcategory;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * <p>Hibernate DAO layer for Materialcategorys</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class MaterialcategoryHibernateDAO extends
		AbstractHibernateDAO<Materialcategory, Long> implements
		MaterialcategoryDAO {

	/**
	 * Find Materialcategory by name
	 */
	public List<Materialcategory> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Materialcategory by code
	 */
	public List<Materialcategory> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Materialcategory by description
	 */
	public List<Materialcategory> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}

    @Override
    public List<Materialcategory> findAssignedCate(final Long userID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Materialcategory>>() {
                    public List<Materialcategory> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT umc.materialCategory FROM UserMaterialCate umc WHERE umc.user.userID = :userID");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("userID", userID);
                        return (List<Materialcategory>) query.list();
                    }
                });
    }


}
