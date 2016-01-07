package com.banvien.tpk.core.dao;

import java.sql.SQLException;
import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.MaintenancehistoryDAO;
import com.banvien.tpk.core.domain.Maintenancehistory;

import com.banvien.tpk.core.domain.Maintenancehistory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * <p>Hibernate DAO layer for Maintenancehistorys</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class MaintenancehistoryHibernateDAO extends
		AbstractHibernateDAO<Maintenancehistory, Long> implements
		MaintenancehistoryDAO {

	/**
	 * Find Maintenancehistory by botcher
	 */
	public List<Maintenancehistory> findByBotcher(String botcher) {
		return findByCriteria(Restrictions.eq("botcher", botcher));
	}
	
	/**
	 * Find Maintenancehistory by machineID
	 */
	@SuppressWarnings("unchecked")
	public List<Maintenancehistory> findByMachineID(Long machineID) {
		return findByCriteria(Restrictions.eq("machine.machineID", machineID));
	}
	
	/**
	 * Find Maintenancehistory by machineComponentID
	 */
	@SuppressWarnings("unchecked")
	public List<Maintenancehistory> findByMachineComponentID(Long machineComponentID) {
		return findByCriteria(Restrictions.eq("machinecomponent.machineComponentID", machineComponentID));
	}
	
	/**
	 * Find Maintenancehistory by note
	 */
	public List<Maintenancehistory> findByNote(String note) {
		return findByCriteria(Restrictions.eq("note", note));
	}
	
	/**
	 * Find Maintenancehistory by maintenanceDate
	 */
	public List<Maintenancehistory> findByMaintenanceDate(Timestamp maintenanceDate) {
		return findByCriteria(Restrictions.eq("maintenanceDate", maintenanceDate));
	}

    @Override
    public Maintenancehistory findLatestMachine(final Long machineID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Maintenancehistory>() {
                    public Maintenancehistory doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("FROM Maintenancehistory u WHERE u.machine.machineID = :machineID");
                        sql.append(" AND u.maintenanceDate = (SELECT MAX(h.maintenanceDate) FROM Maintenancehistory h WHERE h.machine.machineID = :machineID)");
                        Query query = session.createQuery(sql.toString());
                        query.setParameter("machineID", machineID);
                        return (Maintenancehistory) query.uniqueResult();
                    }
                });
    }

    @Override
    public Maintenancehistory findLastestMachineComponent(final Long machineComponentID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Maintenancehistory>() {
                    public Maintenancehistory doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("FROM Maintenancehistory u WHERE u.machinecomponent.machineComponentID = :machineComponentID");
                        sql.append(" AND u.maintenanceDate = (SELECT MAX(h.maintenanceDate) FROM Maintenancehistory h WHERE h.machinecomponent.machineComponentID = :machineComponentID)");
                        Query query = session.createQuery(sql.toString());
                        query.setParameter("machineComponentID", machineComponentID);
                        return (Maintenancehistory) query.uniqueResult();
                    }
                });
    }

    @Override
    public List<Maintenancehistory> findLatestForComponentsOfMachine(final Long machineID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Maintenancehistory>>() {
                    public List<Maintenancehistory> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer();
                        sql.append("FROM Maintenancehistory h")
                                .append(" WHERE h.machinecomponent.machine.machineID = :machineID AND h.machinecomponent.status <> :stopStatus ")
                                .append(" AND h.maintenanceDate = (SELECT MAX(m.maintenanceDate) FROM Maintenancehistory m")
                                .append(" WHERE m.machinecomponent.machineComponentID = h.machinecomponent.machineComponentID)");
                        Query query = session.createQuery(sql.toString());
                        query.setParameter("machineID", machineID);
                        query.setParameter("stopStatus", Constants.MACHINE_STOP);
                        return (List<Maintenancehistory>) query.list();
                    }
                });
    }

    @Override
    public List<Maintenancehistory> findLatestForComponentsOfParentComponent(final Long machineComponentID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Maintenancehistory>>() {
                    public List<Maintenancehistory> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer();
                        sql.append("FROM Maintenancehistory h")
                                .append(" WHERE h.machinecomponent.parent.machineComponentID = :machineComponentID AND h.machinecomponent.status <> :stopStatus ")
                                .append(" AND h.maintenanceDate = (SELECT MAX(m.maintenanceDate) FROM Maintenancehistory m")
                                .append(" WHERE m.machinecomponent.machineComponentID = h.machinecomponent.machineComponentID)");
                        Query query = session.createQuery(sql.toString());
                        query.setParameter("machineComponentID", machineComponentID);
                        query.setParameter("stopStatus", Constants.MACHINE_STOP);
                        return (List<Maintenancehistory>) query.list();
                    }
                });
    }

    @Override
    public List<Maintenancehistory> findByMachine(final Long machineID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Maintenancehistory>>() {
                    public List<Maintenancehistory> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("FROM Maintenancehistory u WHERE u.machine.machineID = :machineID ORDER BY u.maintenanceDate DESC");
                        Query query = session.createQuery(sql.toString());
                        query.setParameter("machineID", machineID);
                        return (List<Maintenancehistory>) query.list();
                    }
                });
    }

    @Override
    public List<Maintenancehistory> findByMachineComponent(final Long machineComponentID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Maintenancehistory>>() {
                    public List<Maintenancehistory> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("FROM Maintenancehistory u WHERE u.machinecomponent.machineComponentID = :machineComponentID ORDER BY u.maintenanceDate DESC");
                        Query query = session.createQuery(sql.toString());
                        query.setParameter("machineComponentID", machineComponentID);
                        return (List<Maintenancehistory>) query.list();
                    }
                });
    }


}
