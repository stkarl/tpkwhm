package com.banvien.tpk.core.dao;

import java.sql.SQLException;
import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.MachineDAO;
import com.banvien.tpk.core.domain.Machine;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * <p>Hibernate DAO layer for Machines</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class MachineHibernateDAO extends
		AbstractHibernateDAO<Machine, Long> implements
		MachineDAO {

	/**
	 * Find Machine by name
	 */
	public List<Machine> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Machine by code
	 */
	public List<Machine> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Machine by description
	 */
	public List<Machine> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	
	/**
	 * Find Machine by lastMaintenanceDate
	 */
	public List<Machine> findByLastMaintenanceDate(Timestamp lastMaintenanceDate) {
		return findByCriteria(Restrictions.eq("lastMaintenanceDate", lastMaintenanceDate));
	}
	
	/**
	 * Find Machine by nextMaintenance
	 */
	public List<Machine> findByNextMaintenance(Integer nextMaintenance) {
		return findByCriteria(Restrictions.eq("nextMaintenance", nextMaintenance));
	}
	
	/**
	 * Find Machine by status
	 */
	public List<Machine> findByStatus(Integer status) {
		return findByCriteria(Restrictions.eq("status", status));
	}
	
	/**
	 * Find Machine by warehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<Machine> findByWarehouseID(Long warehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.warehouseID", warehouseID));
	}

    @Override
    public  List<Machine> findAllActiveMachineByWarehouse(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Machine>>() {
                    public List<Machine> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("FROM Machine u WHERE u.status <> :status");
                        if(warehouseID != null){
                            sql.append(" AND u.warehouse.warehouseID = :warehouseID");
                        }
                        Query query = session
                                .createQuery(sql.toString());
                        query.setParameter("status", Constants.MACHINE_STOP);
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        return (List<Machine>) query.list();
                    }
                });
    }

    @Override
    public List<Machine> findWarningMachine(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Machine>>() {
                    public List<Machine> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Timestamp currentDate =  new Timestamp(System.currentTimeMillis());
                        StringBuffer sql = new StringBuffer("SELECT * FROM Machine u WHERE u.status <> :statusStop");
                        sql.append(" AND (u.status = :statusWarning OR DATEDIFF(CURDATE(), u.lastMaintenanceDate) >= u.nextMaintenance )");
                        if(warehouseID != null){
                            sql.append(" AND u.warehouseID = :warehouseID");
                        }
                        SQLQuery query = session
                                .createSQLQuery(sql.toString());
                        query.setParameter("statusStop", Constants.MACHINE_STOP);
                        query.setParameter("statusWarning", Constants.MACHINE_WARNING);
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        query.addScalar("machineID", StandardBasicTypes.LONG);
                        query.addScalar("name", StandardBasicTypes.STRING);
                        query.addScalar("description", StandardBasicTypes.STRING);
                        query.addScalar("code", StandardBasicTypes.STRING);
                        query.addScalar("nextMaintenance", StandardBasicTypes.INTEGER);
                        query.addScalar("lastMaintenanceDate", StandardBasicTypes.TIMESTAMP);
                        query.addScalar("status", StandardBasicTypes.INTEGER);
                        query.addScalar("reserve", StandardBasicTypes.INTEGER);
                        query.addScalar("boughtDate", StandardBasicTypes.TIMESTAMP);


                        query.setResultTransformer(Transformers.aliasToBean(Machine.class));
                        return (List<Machine>) query.list();
                    }
                });    }


}
