package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.InitProduct;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

/**
 * <p>Hibernate DAO layer for InitProducts</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class InitProductHibernateDAO extends
		AbstractHibernateDAO<InitProduct, Long> implements
		InitProductDAO {



    @Override
    public InitProduct findByDateAndWarehouse(final Date fromDate, final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<InitProduct>() {
                    public InitProduct doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM InitProduct ip WHERE 1 = 1 ");

                        if(warehouseID != null){
                            sqlQuery.append(" AND ip.warehouse.warehouseID = :warehouseID");
                        }
                        sqlQuery.append(" AND ip.initDate = (SELECT MAX(ip2.initDate) FROM InitProduct ip2 WHERE ip2.warehouse.warehouseID = :warehouseID AND ip2.initDate < :fromDate)");
                        Query query = session.createQuery(sqlQuery.toString());

                        query.setParameter("fromDate", fromDate);
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        return (InitProduct) query.uniqueResult();
                    }
                });
    }

    @Override
    public List<Importproduct> findByBillAndName(final Long initProductID, final Long productNameID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT ipd.importProduct FROM InitProductDetail ipd WHERE 1 = 1 ");

                        if(initProductID != null){
                            sqlQuery.append(" AND ipd.initProduct.initProductID = :initProductID");
                        }
                        if(productNameID != null){
                            sqlQuery.append(" AND ipd.importProduct.productname.productNameID = :productNameID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if(initProductID != null){
                            query.setParameter("initProductID", initProductID);
                        }
                        if(productNameID != null){
                            query.setParameter("productNameID", productNameID);
                        }
                        return (List<Importproduct>) query.list();
                    }
                });
    }
}
