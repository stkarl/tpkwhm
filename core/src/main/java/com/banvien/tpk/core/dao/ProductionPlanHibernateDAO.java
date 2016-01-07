package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.ProductionPlan;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * <p>Hibernate DAO layer for ProductionPlans</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ProductionPlanHibernateDAO extends
		AbstractHibernateDAO<ProductionPlan, Long> implements
		ProductionPlanDAO {

	/**
	 * Find ProductionPlan by name
	 */
	public List<ProductionPlan> findByName(String name) {
		return findByCriteria(Restrictions.eq("name", name));
	}
	
	/**
	 * Find ProductionPlan by warehouseID
	 */
	@SuppressWarnings("unchecked")
	public List<ProductionPlan> findByWarehouseID(Long warehouseID) {
		return findByCriteria(Restrictions.eq("warehouse.warehouseID", warehouseID));
	}

	@Override
	public List<Object[]> getProductionDetail(final List<Long> planIds) {
		return getHibernateTemplate().execute(
				new HibernateCallback<List<Object[]>>() {
					public List<Object[]> doInHibernate(Session session)
							throws HibernateException, SQLException {
						StringBuffer sqlQuery = new StringBuffer("Select count(ip.importProductID) as countProduced");
						sqlQuery.append(" ,ip.importproductbill.productionPlan.productionPlanID as planID")
								.append(" ,MIN(ip.importproductbill.status) as status")
								.append(" FROM Importproduct ip")
								.append(" WHERE 1 = 1")
								.append(" AND ip.importproductbill.productionPlan.productionPlanID IN ( :planIds)")
								.append(" AND ip.importproductbill.produceGroup = :produceGroup")
								.append(" GROUP BY ip.importproductbill.productionPlan.productionPlanID");
						Query query = session.createQuery(sqlQuery.toString());
						query.setParameterList("planIds", planIds);
						query.setParameter("produceGroup", Constants.PRODUCT_GROUP_PRODUCED);
						return (List<Object[]>) query.list();
					}
				});
	}


}
