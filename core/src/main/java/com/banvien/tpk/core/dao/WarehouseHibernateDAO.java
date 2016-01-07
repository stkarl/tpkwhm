package com.banvien.tpk.core.dao;

import java.sql.SQLException;
import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.WarehouseDAO;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.domain.Warehouse;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * <p>Hibernate DAO layer for Warehouses</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class WarehouseHibernateDAO extends
		AbstractHibernateDAO<Warehouse, Long> implements
		WarehouseDAO {

	/**
	 * Find Warehouse by name
	 */
	public List<Warehouse> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Warehouse by address
	 */
	public List<Warehouse> findByAddress(String address) {
		return findByCriteria(Restrictions.eq("address", address));
	}
	
	/**
	 * Find Warehouse by status
	 */
	public List<Warehouse> findByStatus(Integer status) {
		return findByCriteria(Restrictions.eq("status", status));
	}
	
	/**
	 * Find Warehouse by code
	 */
	public List<Warehouse> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}

    @Override
    public List<Warehouse> findAllActiveWarehouseExcludeID(final Long excludeID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Warehouse>>() {
                    public List<Warehouse> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("FROM Warehouse u WHERE u.status = :status ");
                        if(excludeID != null){
                            sql.append(" AND u.warehouseID <> :excludeID");
                        }
                        Query query = session
                                .createQuery(sql.toString());
                        query.setParameter("status", 1);
                        if(excludeID != null){
                            query.setParameter("excludeID", excludeID);
                        }
                        return (List<Warehouse>) query.list();
                    }
                });
    }


}
