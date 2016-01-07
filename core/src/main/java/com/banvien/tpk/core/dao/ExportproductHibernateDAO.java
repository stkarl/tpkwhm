package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Exportproduct;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.dto.SearchUsedMaterialBean;
import com.banvien.tpk.core.dto.UsedMaterialDTO;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Exportproducts</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ExportproductHibernateDAO extends
		AbstractHibernateDAO<Exportproduct, Long> implements
		ExportproductDAO {

	/**
	 * Find Exportproduct by exportProductBillID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproduct> findByExportProductBillID(Long exportProductBillID) {
		return findByCriteria(Restrictions.eq("exportproductbill.exportProductBillID", exportProductBillID));
	}
	
	/**
	 * Find Exportproduct by productNameID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproduct> findByProductNameID(Long productNameID) {
		return findByCriteria(Restrictions.eq("productname.productNameID", productNameID));
	}
	
	/**
	 * Find Exportproduct by productCode
	 */
	public List<Exportproduct> findByProductCode(String productCode) {
		return findByCriteria(Restrictions.eq("productCode", productCode));
	}
	
	/**
	 * Find Exportproduct by originID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproduct> findByOriginID(Long originID) {
		return findByCriteria(Restrictions.eq("origin.originID", originID));
	}
	
	/**
	 * Find Exportproduct by classifyCode
	 */
	public List<Exportproduct> findByClassifyCode(String classifyCode) {
		return findByCriteria(Restrictions.eq("classifyCode", classifyCode));
	}
	
	/**
	 * Find Exportproduct by unit1ID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproduct> findByUnit1ID(Long unit1ID) {
		return findByCriteria(Restrictions.eq("unit.unit1ID", unit1ID));
	}
	
	/**
	 * Find Exportproduct by quantity1
	 */
	public List<Exportproduct> findByQuantity1(Double quantity1) {
		return findByCriteria(Restrictions.eq("quantity1", quantity1));
	}
	
	/**
	 * Find Exportproduct by unit2ID
	 */
	@SuppressWarnings("unchecked")
	public List<Exportproduct> findByUnit2ID(Long unit2ID) {
		return findByCriteria(Restrictions.eq("unit.unit2ID", unit2ID));
	}
	
	/**
	 * Find Exportproduct by quantity2
	 */
	public List<Exportproduct> findByQuantity2(Double quantity2) {
		return findByCriteria(Restrictions.eq("quantity2", quantity2));
	}
	
	/**
	 * Find Exportproduct by note
	 */
	public List<Exportproduct> findByNote(String note) {
		return findByCriteria(Restrictions.eq("note", note));
	}
	
	/**
	 * Find Exportproduct by money
	 */
	public List<Exportproduct> findByMoney(Double money) {
		return findByCriteria(Restrictions.eq("money", money));
	}

    @Override
    public List<Importproduct> findProductByProductionPlan(final Long productionPlanID) {
        return getHibernateTemplate().execute(new HibernateCallback<List<Importproduct>>() {
            @Override
            public List<Importproduct> doInHibernate(Session session) throws HibernateException, SQLException {
                StringBuffer sql = new StringBuffer();
                sql.append("SELECT ep.importproduct FROM Exportproduct ep WHERE 1 = 1");
                if(productionPlanID != null){
                    sql.append(" AND ep.exportproductbill.productionPlan.productionPlanID = :productionPlanID");
                }
                sql.append(" AND ep.importproduct.status = :status");
                Query query = session.createQuery(sql.toString());
                if(productionPlanID != null){
                    query.setParameter("productionPlanID",productionPlanID);
                }
                query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_WAIT_TO_USE);
                return (List<Importproduct>) query.list();
            }
        });
    }

    @Override
    public List<UsedMaterialDTO> findExportProduct4Production(final SearchUsedMaterialBean bean) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<UsedMaterialDTO>>() {
                    public List<UsedMaterialDTO> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Date fromDate = bean.getFromExportedDate() != null ? bean.getFromExportedDate(): null;
                        Date toDate = bean.getToExportedDate() != null ? bean.getToExportedDate(): null;
                        Long productionPlanID = bean.getProductionPlanID() != null && bean.getProductionPlanID() > 0 ? bean.getProductionPlanID() : null;
                        Long originID = bean.getOriginID() != null && bean.getOriginID() > 0 ? bean.getOriginID() : null;
                        Long marketID = bean.getMarketID() != null && bean.getMarketID() > 0 ? bean.getMarketID() : null;
                        Long warehouseID = bean.getWarehouseID() != null && bean.getWarehouseID() > 0 ? bean.getWarehouseID() : null;
                        Long exportTypeID = bean.getExportTypeID() != null && bean.getExportTypeID() > 0 ? bean.getExportTypeID() : null;
                        Long materialID = bean.getMaterialID() != null && bean.getMaterialID() > 0 ? bean.getMaterialID() : null;

                        Integer productionType = bean.getProductionType() != null && bean.getProductionType() > 0 ? bean.getProductionType() : null;

                        if(materialID == null){
                            StringBuffer sqlQuery = new StringBuffer("SELECT e.importproduct.productname as productName, sum(e.importproduct.quantity1) as totalMUsed, " +
                                    " sum(e.importproduct.quantity2Pure) as totalKgUsed," +
                                    " min(e.exportproductbill.exportDate) as startDate, max(e.exportproductbill.exportDate) as endDate," +
                                    " e.importproduct.size as size," +
                                    " e.exportproductbill.productionPlan as plan" +
                                    " FROM Exportproduct e");
                            sqlQuery.append(" WHERE e.exportproductbill.status = :status");
                            if (exportTypeID != null){
                                sqlQuery.append(" AND e.exportproductbill.exporttype.exportTypeID = :exportTypeID");
                            }
                            if (warehouseID != null){
                                sqlQuery.append(" AND e.exportproductbill.exportWarehouse.warehouseID = :warehouseID");
                            }
                            if (productionPlanID != null){
                                sqlQuery.append(" AND e.exportproductbill.productionPlan.productionPlanID = :productionPlanID");
                            }
                            if (productionType != null){
                                sqlQuery.append(" AND e.exportproductbill.productionPlan.production = :productionType");
                            }
                            if (originID != null){
                                sqlQuery.append(" AND e.importproduct.origin.originID = :originID");
                            }
                            if (marketID != null){
                                sqlQuery.append(" AND e.importproduct.market.marketID = :marketID");
                            }
                            if (fromDate != null){
                                sqlQuery.append(" AND e.exportproductbill.exportDate >= :fromDate");
                            }
                            if (toDate != null){
                                sqlQuery.append(" AND e.exportproductbill.exportDate <= :toDate");
                            }
                            sqlQuery.append(" GROUP BY e.importproduct.productname, e.exportproductbill.productionPlan");
                            Query query = session.createQuery(sqlQuery.toString());
                            query.setParameter("status", Constants.CONFIRMED);
                            if(exportTypeID !=null){
                                query.setParameter("exportTypeID", exportTypeID);
                            }
                            if(warehouseID !=null){
                                query.setParameter("warehouseID", warehouseID);
                            }
                            if (productionPlanID != null){
                                query.setParameter("productionPlanID", productionPlanID);
                            }
                            if (productionType != null){
                                query.setParameter("productionType", productionType);
                            }
                            if (originID != null){
                                query.setParameter("originID", originID);
                            }
                            if (marketID != null){
                                query.setParameter("marketID", marketID);
                            }
                            if (fromDate != null){
                                query.setParameter("fromDate", fromDate);
                            }
                            if (toDate != null){
                                query.setParameter("toDate", toDate);
                            }
                            query.setResultTransformer(Transformers.aliasToBean(UsedMaterialDTO.class));
                            return (List<UsedMaterialDTO>) query.list();
                        }else{
                            return null;
                        }
                    }
                });
    }

    @Override
    public List<Object[]> findProductionTimesByPlans(final List<Long> productionPlanIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Object[]>>() {
                    public List<Object[]> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT ep.exportproductbill.exportWarehouse.warehouseID as warehouseID, ep.exportproductbill.productionPlan.productionPlanID as planID," +
                                " min(ep.exportproductbill.exportDate) as startDate, max(ep.exportproductbill.exportDate) as endDate FROM Exportproduct ep ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ep.exportproductbill.productionPlan.productionPlanID IN ( :productionPlanIDs)")
                        .append(" GROUP BY ep.exportproductbill.exportWarehouse.warehouseID,ep.exportproductbill.productionPlan.productionPlanID");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("productionPlanIDs", productionPlanIDs);
                        return (List<Object[]>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findExportByPlan(final Long productionPlanID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT ep.importproduct FROM Exportproduct ep ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ep.exportproductbill.productionPlan.productionPlanID = :productionPlanID")
                        .append(" AND ep.exportproductbill.status = :confirmed");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("productionPlanID", productionPlanID);
                        query.setParameter("confirmed", Constants.CONFIRMED);
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Exportproduct> findByProductIds(final List<Long> ids) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Exportproduct>>() {
                    public List<Exportproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Exportproduct ep ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ep.importproduct.importProductID IN (:ids)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("ids", ids);
                        return (List<Exportproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Exportproduct> findExportProductsByPlans(final List<Long> productionPlanIDs) {
        return getHibernateTemplate().execute(new HibernateCallback<List<Exportproduct>>() {
            @Override
            public List<Exportproduct> doInHibernate(Session session) throws HibernateException, SQLException {
                StringBuffer sql = new StringBuffer();
                sql.append("FROM Exportproduct ep WHERE 1 = 1");
                if(productionPlanIDs != null){
                    sql.append(" AND ep.exportproductbill.productionPlan.productionPlanID IN (:productionPlanIDs)");
                }
                sql.append(" AND ep.importproduct.status = :status");
                Query query = session.createQuery(sql.toString());
                if(productionPlanIDs != null){
                    query.setParameterList("productionPlanIDs",productionPlanIDs);
                }
                query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_USED);
                return (List<Exportproduct>) query.list();
            }
        });
    }

    @Override
    public Double findTotalExportBlackProduct4ProductionByDate(final Date fromDate, final Date toDate) {
        return getHibernateTemplate().execute(new HibernateCallback<Double>() {
            @Override
            public Double doInHibernate(Session session) throws HibernateException, SQLException {
                StringBuffer sql = new StringBuffer();
                sql.append("SELECT SUM(ep.importproduct.quantity2Pure - case when ep.importproduct.importBack is null then 0 else ep.importproduct.importBack end) FROM Exportproduct ep WHERE 1 = 1");
                sql.append(" AND ep.importproduct.status = :usedStatus");
                sql.append(" AND ep.exportproductbill.productionPlan IS NOT NULL");
                if(fromDate != null){
                    sql.append(" AND ep.exportproductbill.exportDate >= :fromDate");
                }
                if(toDate != null){
                    sql.append(" AND ep.exportproductbill.exportDate <= :toDate");
                }
                Query query = session.createQuery(sql.toString());
                if(fromDate != null){
                    query.setParameter("fromDate",fromDate);
                }
                if(toDate != null){
                    query.setParameter("toDate",toDate);
                }
                query.setParameter("usedStatus", Constants.ROOT_MATERIAL_STATUS_USED);
                return (Double) query.uniqueResult();
            }
        });
    }


}
