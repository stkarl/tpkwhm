package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.MaterialMeasurement;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class MaterialMeasurementHibernateDAO extends
		AbstractHibernateDAO<MaterialMeasurement, Long> implements
		MaterialMeasurementDAO {


    @Override
    public List<MaterialMeasurement> findLatestValue(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<MaterialMeasurement>>() {
                    public List<MaterialMeasurement> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM MaterialMeasurement im ");
                        sqlQuery.append(" WHERE im.warehouse.warehouseID = :warehouseID");
                        sqlQuery.append(" AND im.materialMeasurementID IN (");
                        sqlQuery.append("    SELECT max(m2.materialMeasurementID) FROM MaterialMeasurement m2 WHERE m2.warehouse.warehouseID = :warehouseID GROUP BY m2.material.materialID)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("warehouseID", warehouseID);
                        return (List<MaterialMeasurement>) query.list();
                    }
                });
    }

    @Override
    public List<MaterialMeasurement> findUsedInProduction(final Long warehouseID, final Timestamp startDate, final Timestamp endDate,final Integer productionType) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<MaterialMeasurement>>() {
                    public List<MaterialMeasurement> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer findMeasurement = new StringBuffer("SELECT m.material as material, m.warehouse as warehouse," +
                                " sum(m.value) as value");
                        findMeasurement.append(" FROM MaterialMeasurement m");
                        findMeasurement.append(" WHERE m.date >= :startDate AND m.date <= :endDate");
                        if(warehouseID != null){
                            findMeasurement.append(" AND m.warehouse.warehouseID = :warehouseID");
                        }
                        if(productionType != null){
                            findMeasurement.append(" AND EXISTS (SELECT 1 FROM MaterialAndCategory mc WHERE mc.materialCategory.code = :cateCode AND mc.material.materialID = m.material.materialID)");
                        }
                        findMeasurement.append(" GROUP BY  m.material, m.warehouse");
                        Query measurementQuery = session.createQuery(findMeasurement.toString());
                        measurementQuery.setParameter("startDate", startDate);
                        measurementQuery.setParameter("endDate", endDate);
                        if(warehouseID != null){
                            measurementQuery.setParameter("warehouseID", warehouseID);
                        }
                        if(productionType != null){
                            String cateCode = productionType.equals(Constants.PRODUCE_LANH) ? Constants.MATERIAL_GROUP_MEASURE_LANH : productionType.equals(Constants.PRODUCE_MAU) ? Constants.MATERIAL_GROUP_MEASURE_MAU : "";
                            measurementQuery.setParameter("cateCode", cateCode);
                        }
                        measurementQuery.setResultTransformer(Transformers.aliasToBean(MaterialMeasurement.class));
                        return (List<MaterialMeasurement>) measurementQuery.list();

                    }
                });
    }
}
