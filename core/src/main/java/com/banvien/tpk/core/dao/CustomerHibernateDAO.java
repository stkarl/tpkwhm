package com.banvien.tpk.core.dao;

import java.sql.SQLException;
import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.dao.CustomerDAO;
import com.banvien.tpk.core.domain.Customer;

import com.banvien.tpk.core.dto.ReportBean;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * <p>Hibernate DAO layer for Customers</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class CustomerHibernateDAO extends
		AbstractHibernateDAO<Customer, Long> implements
		CustomerDAO {

	/**
	 * Find Customer by name
	 */
	public List<Customer> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find Customer by address
	 */
	public List<Customer> findByAddress(String address) {
		return findByCriteria(Restrictions.eq("address", address));
	}
	
	/**
	 * Find Customer by regionID
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> findByRegionID(Long regionID) {
		return findByCriteria(Restrictions.eq("region.regionID", regionID));
	}
	
	/**
	 * Find Customer by provinceID
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> findByProvinceID(Long provinceID) {
		return findByCriteria(Restrictions.eq("province.provinceID", provinceID));
	}
	
	/**
	 * Find Customer by birthday
	 */
	public List<Customer> findByBirthday(Timestamp birthday) {
		return findByCriteria(Restrictions.eq("birthday", birthday));
	}
	
	/**
	 * Find Customer by owe
	 */
	public List<Customer> findByOwe(Double owe) {
		return findByCriteria(Restrictions.eq("owe", owe));
	}
	
	/**
	 * Find Customer by limit
	 */
	public List<Customer> findByLimit(Double limit) {
		return findByCriteria(Restrictions.eq("limit", limit));
	}
	
	/**
	 * Find Customer by lastPayDate
	 */
	public List<Customer> findByLastPayDate(Timestamp lastPayDate) {
		return findByCriteria(Restrictions.eq("lastPayDate", lastPayDate));
	}
	
	/**
	 * Find Customer by dayAllow
	 */
	public List<Customer> findByDayAllow(Integer dayAllow) {
		return findByCriteria(Restrictions.eq("dayAllow", dayAllow));
	}
	
	/**
	 * Find Customer by status
	 */
	public List<Customer> findByStatus(Integer status) {
		return findByCriteria(Restrictions.eq("status", status));
	}

    @Override
    public List<Customer> findByUser(final Long loginUserId) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Customer>>() {
                    public List<Customer> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT distinct uc.customer FROM UserCustomer uc WHERE 1 = 1");
                        if(loginUserId != null && loginUserId > 0){
                            sqlQuery.append(" AND uc.user.userID = :loginUserId");
                        }
                        sqlQuery.append(" ORDER BY uc.customer.province.name, uc.customer.name asc");
                        Query query = session.createQuery(sqlQuery.toString());
                        if(loginUserId != null && loginUserId > 0){
                            query.setParameter("loginUserId",loginUserId);
                        }

                        return (List<Customer>) query.list() ;
                    }
                });
    }

    @Override
    public List<Customer> findCustomerHasLiability(final ReportBean bean) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Customer>>() {
                    public List<Customer> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Long regionID = bean.getRegionID() != null ? bean.getRegionID() : null;
                        Long provinceID = bean.getProvinceID() != null ? bean.getProvinceID() : null;
                        Long userID = bean.getUserID() != null ? bean.getUserID(): null;
                        Integer status = bean.getStatus() != null ? bean.getStatus() : null;
                        Double oweValue = bean.getOweValue() != null ? bean.getOweValue() : null;

                        StringBuffer sqlQuery = new StringBuffer("FROM Customer c WHERE c.owe > 0");
                        if(userID != null){
                            sqlQuery.append(" AND c.customerID IN (SELECT uc.customer.customerID FROM UserCustomer uc WHERE uc.user.userID = :userID)");
                        }
                        if(regionID != null){
                            sqlQuery.append(" AND c.region.regionID = :regionID");
                        }
                        if(provinceID != null){
                            sqlQuery.append(" AND c.province.provinceID = :provinceID");
                        }
                        if(status != null){
                            sqlQuery.append(" AND c.status = :status");
                        }
                        if(oweValue != null){
                            sqlQuery.append(" AND c.owe >= :oweValue");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if(userID != null){
                            query.setParameter("userID",userID);
                        }
                        if(regionID != null){
                            query.setParameter("regionID",regionID);
                        }
                        if(provinceID != null){
                            query.setParameter("provinceID",provinceID);
                        }
                        if(status != null){
                            query.setParameter("status",status);
                        }
                        if(oweValue != null){
                            query.setParameter("oweValue",oweValue);
                        }
                        return (List<Customer>) query.list() ;
                    }
                });
    }

    @Override
    public List<Customer> find4Report(final ReportBean bean) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Customer>>() {
                    public List<Customer> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Long loginUserId = bean.getUserID() != null && bean.getUserID() > 0 ? bean.getUserID() : null;
                        Long regionId = bean.getRegionID() != null && bean.getRegionID() > 0 ? bean.getRegionID() : null;
                        Long provinceId = bean.getProvinceID() != null && bean.getProvinceID() > 0 ? bean.getProvinceID() : null;
                        Long customerId = bean.getCustomerID() != null && bean.getCustomerID() > 0 ? bean.getCustomerID() : null;
                        StringBuffer sqlQuery = new StringBuffer("SELECT distinct uc.customer FROM UserCustomer uc WHERE 1 = 1");
                        if(loginUserId != null && loginUserId > 0){
                            sqlQuery.append(" AND uc.user.userID = :loginUserId");
                        }
                        if(regionId != null){
                            sqlQuery.append(" AND uc.customer.region.regionID = :regionId");
                        }
                        if(provinceId != null){
                            sqlQuery.append(" AND uc.customer.province.provinceID = :provinceId");
                        }
                        if(customerId != null){
                            sqlQuery.append(" AND uc.customer.customerID = :customerId");
                        }
                        sqlQuery.append(" ORDER BY uc.user.userName, uc.customer.status, uc.customer.province.name desc");
                        Query query = session.createQuery(sqlQuery.toString());
                        if(loginUserId != null && loginUserId > 0){
                            query.setParameter("loginUserId",loginUserId);
                        }
                        if(regionId != null){
                            query.setParameter("regionId",regionId);
                        }
                        if(provinceId != null){
                            query.setParameter("provinceId",provinceId);
                        }
                        if(customerId != null){
                            query.setParameter("customerId",customerId);
                        }

                        return (List<Customer>) query.list() ;
                    }
                });
    }

    @Override
    public List<Customer> findByIDs(final List<Long> customerIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Customer>>() {
                    public List<Customer> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Customer uc WHERE 1 = 1");
                        if(customerIDs != null && customerIDs.size() > 0){
                            sqlQuery.append(" AND uc.customerID IN (:customerIDs)");
                        }
                        sqlQuery.append(" ORDER BY uc.province.name, uc.name asc");
                        Query query = session.createQuery(sqlQuery.toString());
                        if(customerIDs != null && customerIDs.size() > 0){
                            query.setParameterList("customerIDs",customerIDs);
                        }
                        return (List<Customer>) query.list() ;
                    }
                });
    }


}
