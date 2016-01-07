package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Machinecomponent;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Machinecomponents</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class MachinecomponentHibernateDAO extends
		AbstractHibernateDAO<Machinecomponent, Long> implements
		MachinecomponentDAO {

	/**
	 * Find Machinecomponent by name
	 */
	public List<Machinecomponent> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Machinecomponent by code
	 */
	public List<Machinecomponent> findByCode(String code) {
		return findByCriteria(Restrictions.eq("code", code));
	}
	
	/**
	 * Find Machinecomponent by description
	 */
	public List<Machinecomponent> findByDescription(String description) {
		return findByCriteria(Restrictions.eq("description", description));
	}
	
	/**
	 * Find Machinecomponent by lastMaintenanceDate
	 */
	public List<Machinecomponent> findByLastMaintenanceDate(Timestamp lastMaintenanceDate) {
		return findByCriteria(Restrictions.eq("lastMaintenanceDate", lastMaintenanceDate));
	}
	
	/**
	 * Find Machinecomponent by nextMaintenance
	 */
	public List<Machinecomponent> findByNextMaintenance(Integer nextMaintenance) {
		return findByCriteria(Restrictions.eq("nextMaintenance", nextMaintenance));
	}
	
	/**
	 * Find Machinecomponent by status
	 */
	public List<Machinecomponent> findByStatus(Integer status) {
		return findByCriteria(Restrictions.eq("status", status));
	}
	
	/**
	 * Find Machinecomponent by machineID
	 */
	@SuppressWarnings("unchecked")
	public List<Machinecomponent> findByMachineID(Long machineID) {
		return findByCriteria(Restrictions.eq("machine.machineID", machineID));
	}

    @Override
    public List<Machinecomponent> findByMachineAndWarehouse(final Long machineID,final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Machinecomponent>>() {
                    public List<Machinecomponent> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Machinecomponent mc WHERE 1 = 1 ");
                        if(machineID != null){
                            sqlQuery.append(" AND mc.machine.machineID = :machineID");
                        }
                        if(machineID != null && warehouseID != null){
                            sqlQuery.append(" AND mc.machine.warehouse.warehouseID = :warehouseID");
                        }
                        sqlQuery.append(" AND mc.status <> :stopStatus");

                        sqlQuery.append(" ORDER BY name, groupCode");
                        Query query = session.createQuery(sqlQuery.toString());
                        if(machineID != null){
                            query.setParameter("machineID",machineID);
                        }
                        if(machineID != null && warehouseID != null){
                            query.setParameter("warehouseID",warehouseID);
                        }
                        query.setParameter("stopStatus",Constants.MACHINE_STOP);

                        return (List<Machinecomponent>) query.list();
                    }
                });
    }

    @Override
    public List<Machinecomponent> findWarningComponent(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Machinecomponent>>() {
                    public List<Machinecomponent> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("SELECT u.machineComponentID as machineComponentID, u.name as name, u.code as code, u.description as description," +
                                " u.nextMaintenance as nextMaintenance, u.lastMaintenanceDate as lastMaintenanceDate, u.status as status, u.reserve as reserve " +
                                "FROM Machinecomponent u, Machine m WHERE u.machineID = m.machineID AND u.status <> :statusStop");
                        sql.append(" AND (u.status = :statusWarning OR DATEDIFF(CURDATE(), u.lastMaintenanceDate) >= u.nextMaintenance )");
                        if(warehouseID != null){
                            sql.append(" AND m.warehouseID = :warehouseID");
                        }
                        SQLQuery query = session
                                .createSQLQuery(sql.toString());
                        query.setParameter("statusStop", Constants.MACHINE_STOP);
                        query.setParameter("statusWarning", Constants.MACHINE_WARNING);
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        query.addScalar("machineComponentID", StandardBasicTypes.LONG);
                        query.addScalar("name", StandardBasicTypes.STRING);
                        query.addScalar("description", StandardBasicTypes.STRING);
                        query.addScalar("code", StandardBasicTypes.STRING);
                        query.addScalar("nextMaintenance", StandardBasicTypes.INTEGER);
                        query.addScalar("lastMaintenanceDate", StandardBasicTypes.TIMESTAMP);
                        query.addScalar("status", StandardBasicTypes.INTEGER);
                        query.addScalar("reserve", StandardBasicTypes.INTEGER);

                        query.setResultTransformer(Transformers.aliasToBean(Machinecomponent.class));
                        return (List<Machinecomponent>) query.list();
                    }
                });
    }

    @Override
    public List<Machinecomponent> findAllActiveComponentByWarehouse(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Machinecomponent>>() {
                    public List<Machinecomponent> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("FROM Machinecomponent u WHERE u.status <> :status");
                        //@TODO revise case parent is component
//                        if(warehouseID != null){
//                            sql.append(" AND u.warehouse.warehouseID = :warehouseID");
//                        }
                        Query query = session
                                .createQuery(sql.toString());
                        query.setParameter("status", Constants.MACHINE_STOP);
//                        if(warehouseID != null){
//                            query.setParameter("warehouseID", warehouseID);
//                        }
                        return (List<Machinecomponent>) query.list();
                    }
                });

    }


}
