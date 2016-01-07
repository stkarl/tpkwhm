package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Exportmaterial;
import com.banvien.tpk.core.dto.ExportMaterialReportBean;
import com.banvien.tpk.core.dto.ExportMaterialReportDetailDTO;
import com.banvien.tpk.core.dto.SearchUsedMaterialBean;
import com.banvien.tpk.core.dto.UsedMaterialDTO;
import org.apache.commons.lang.StringUtils;
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
 * <p>Hibernate DAO layer for Exportmaterials</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ExportmaterialHibernateDAO extends
        AbstractHibernateDAO<Exportmaterial, Long> implements
        ExportmaterialDAO {

    /**
     * Find Exportmaterial by exportMaterialBillID
     */
    @SuppressWarnings("unchecked")
    public List<Exportmaterial> findByExportMaterialBillID(Long exportMaterialBillID) {
        return findByCriteria(Restrictions.eq("exportmaterialbill.exportMaterialBillID", exportMaterialBillID));
    }

    /**
     * Find Exportmaterial by materialID
     */
    @SuppressWarnings("unchecked")
    public List<Exportmaterial> findByMaterialID(Long materialID) {
        return findByCriteria(Restrictions.eq("material.materialID", materialID));
    }

    /**
     * Find Exportmaterial by unit1ID
     */
    @SuppressWarnings("unchecked")
    public List<Exportmaterial> findByUnit1ID(Long unit1ID) {
        return findByCriteria(Restrictions.eq("unit.unit1ID", unit1ID));
    }

    /**
     * Find Exportmaterial by quantity1
     */
    public List<Exportmaterial> findByQuantity1(Double quantity1) {
        return findByCriteria(Restrictions.eq("quantity1", quantity1));
    }

    /**
     * Find Exportmaterial by unit2ID
     */
    @SuppressWarnings("unchecked")
    public List<Exportmaterial> findByUnit2ID(Long unit2ID) {
        return findByCriteria(Restrictions.eq("unit.unit2ID", unit2ID));
    }

    /**
     * Find Exportmaterial by quantity2
     */
    public List<Exportmaterial> findByQuantity2(Double quantity2) {
        return findByCriteria(Restrictions.eq("quantity2", quantity2));
    }

    /**
     * Find Exportmaterial by note
     */
    public List<Exportmaterial> findByNote(String note) {
        return findByCriteria(Restrictions.eq("note", note));
    }

    @Override
    public List<UsedMaterialDTO> findExportMaterial(final SearchUsedMaterialBean bean) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<UsedMaterialDTO>>() {
                    public List<UsedMaterialDTO> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Date fromDate = bean.getFromExportedDate() != null ? bean.getFromExportedDate(): null;
                        Date toDate = bean.getToExportedDate() != null ? bean.getToExportedDate(): null;
                        Long exportTypeID = bean.getExportTypeID() != null && bean.getExportTypeID() > 0 ? bean.getExportTypeID() : null;
                        Long productionPlanID = bean.getProductionPlanID() != null && bean.getProductionPlanID() > 0 ? bean.getProductionPlanID() : null;
                        Long originID = bean.getOriginID() != null && bean.getOriginID() > 0 ? bean.getOriginID() : null;
                        Long materialID = bean.getMaterialID() != null && bean.getMaterialID() > 0 ? bean.getMaterialID() : null;
                        Long marketID = bean.getMarketID() != null && bean.getMarketID() > 0 ? bean.getMarketID() : null;
                        Long warehouseID = bean.getWarehouseID() != null && bean.getWarehouseID() > 0 ? bean.getWarehouseID() : null;
                        Integer productionType = bean.getProductionType() != null && bean.getProductionType() > 0 ? bean.getProductionType() : null;


                        StringBuffer sqlQuery = new StringBuffer("SELECT e.importmaterial.material as material,e.importmaterial.material.unit as unit," +
                                " sum(e.quantity) as totalUsed," +
                                " e.exportmaterialbill.productionPlan as plan" +
                                " FROM Exportmaterial e");
                        sqlQuery.append(" WHERE e.exportmaterialbill.status = :status");
                        if (warehouseID != null){
                            sqlQuery.append(" AND e.exportmaterialbill.exportWarehouse.warehouseID = :warehouseID");
                        }
                        if (exportTypeID != null){
                            sqlQuery.append(" AND e.exportmaterialbill.exporttype.exportTypeID = :exportTypeID");
                        }
                        if (productionPlanID != null){
                            sqlQuery.append(" AND e.exportmaterialbill.productionPlan.productionPlanID = :productionPlanID");
                        }
                        if (productionType != null){
                            sqlQuery.append(" AND e.exportmaterialbill.productionPlan.production = :productionType");
                        }
                        if (originID != null){
                            sqlQuery.append(" AND e.importmaterial.origin.originID = :originID");
                        }
                        if (materialID != null){
                            sqlQuery.append(" AND e.importmaterial.material.materialID = :materialID");
                        }
                        if (marketID != null){
                            sqlQuery.append(" AND e.importmaterial.market.marketID = :marketID");
                        }
                        if (fromDate != null){
                            sqlQuery.append(" AND e.exportmaterialbill.exportDate >= :fromDate");
                        }
                        if (toDate != null){
                            sqlQuery.append(" AND e.exportmaterialbill.exportDate <= :toDate");
                        }
                        sqlQuery.append(" GROUP BY e.importmaterial.material, e.exportmaterialbill.productionPlan");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("status", Constants.CONFIRMED);
                        if(warehouseID !=null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        if (exportTypeID != null){
                            query.setParameter("exportTypeID", exportTypeID);
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
                        if (materialID != null){
                            query.setParameter("materialID", materialID);
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
                    }
                });
    }

    @Override
    public List<Exportmaterial> findByProductionPlanIDs(final List<Long> productionPlanIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Exportmaterial>>() {
                    public List<Exportmaterial> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Exportmaterial ip ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ip.exportmaterialbill.productionPlan.productionPlanID IN ( :productionPlanIDs)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("productionPlanIDs", productionPlanIDs);
                        return (List<Exportmaterial>) query.list();
                    }
                });
    }

    @Override
    public List<Exportmaterial> findExportByPlan(final Long productionPlanID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Exportmaterial>>() {
                    public List<Exportmaterial> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Exportmaterial ip ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ip.exportmaterialbill.productionPlan.productionPlanID = :productionPlanID");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("productionPlanID", productionPlanID);
                        return (List<Exportmaterial>) query.list();
                    }
                });
    }

    @Override
    public List<ExportMaterialReportDetailDTO> findAllExportUtilDate(final ExportMaterialReportBean bean) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ExportMaterialReportDetailDTO>>() {
                    public List<ExportMaterialReportDetailDTO> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer whereClause = new StringBuffer();
                        Long warehouseID = bean.getWarehouseID() != null && bean.getWarehouseID() > 0  ? bean.getWarehouseID() : null;
                        Long materialID = bean.getMaterialID() != null && bean.getMaterialID() > 0  ? bean.getMaterialID() : null;
                        Long originID = bean.getOriginID() != null && bean.getOriginID() > 0  ? bean.getOriginID() : null;
                        Long materialCategoryID = bean.getMaterialCategoryID() != null && bean.getMaterialCategoryID() > 0 ? bean.getMaterialCategoryID() : null;
                        Date fromDate = bean.getFromDate() != null ? bean.getFromDate() : null;

                        if(warehouseID != null){
                            whereClause.append(" AND em.importmaterial.warehouse.warehouseID = :warehouseID");
                        }

                        if(materialID != null){
                            whereClause.append(" AND em.importmaterial.material.materialID = :materialID");
                        }

                        if(originID != null){
                            whereClause.append(" AND em.importmaterial.origin.originID = :originID");
                        }

                        if(materialCategoryID != null){
                            whereClause.append(" AND em.importmaterial.material.materialID IN (SELECT mac.material.materialID FROM MaterialAndCategory mac WHERE mac.materialCategory.materialCategoryID = :materialCategoryID)");
                        }

                        if(fromDate != null){
                            whereClause.append(" AND em.exportmaterialbill.exportDate < :fromDate");
                        }

                        whereClause.append(" GROUP BY em.importmaterial.material, em.importmaterial.origin");

                        StringBuffer tailerQuery = new StringBuffer();
                        tailerQuery.append(" ORDER BY em.importmaterial.");

                        if(StringUtils.isBlank(bean.getSortExpression())){
                            tailerQuery.append("material.name");
                        }else{
                            tailerQuery.append(bean.getSortExpression());
                        }
                        if(StringUtils.isBlank(bean.getSortDirection()) || bean.getSortDirection().equals("1")){
                            tailerQuery.append(" ASC");
                        }else if(bean.getSortDirection().equals("2")){
                            tailerQuery.append(" DESC");
                        }

                        StringBuffer sql = new StringBuffer("SELECT em.importmaterial.material as material, em.importmaterial.origin as origin, SUM(em.quantity) as quantity");
                        sql.append(" FROM Exportmaterial em WHERE 1 = 1");
//                        sql.append(" AND em.importmaterial.status = :status");
                        sql.append(whereClause);
                        sql.append(tailerQuery);


                        Query query = session.createQuery(sql.toString());
//                        query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }else{
                            if(warehouseID != null){
                                query.setParameter("warehouseID", warehouseID);
                            }
                        }

                        if(materialID != null){
                            query.setParameter("materialID", materialID);
                        }

                        if(originID != null){
                            query.setParameter("originID", originID);
                        }

                        if(materialCategoryID != null){
                            query.setParameter("materialCategoryID", materialCategoryID);
                        }

                        if(fromDate !=null){
                            query.setParameter("fromDate", fromDate);
                        }
                        query.setResultTransformer(Transformers.aliasToBean(ExportMaterialReportDetailDTO.class));
                        List<ExportMaterialReportDetailDTO> reportDetailDTO = (List<ExportMaterialReportDetailDTO>) query.list();
                        return reportDetailDTO;
                    }
                });
    }

    @Override
    public List<ExportMaterialReportDetailDTO> findAllExportDuringDate(final ExportMaterialReportBean bean) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ExportMaterialReportDetailDTO>>() {
                    public List<ExportMaterialReportDetailDTO> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer whereClause = new StringBuffer();
                        Long warehouseID = bean.getWarehouseID() != null && bean.getWarehouseID() > 0  ? bean.getWarehouseID() : null;
                        Long materialID = bean.getMaterialID() != null && bean.getMaterialID() > 0  ? bean.getMaterialID() : null;
                        Long originID = bean.getOriginID() != null && bean.getOriginID() > 0  ? bean.getOriginID() : null;
                        Long materialCategoryID = bean.getMaterialCategoryID() != null && bean.getMaterialCategoryID() > 0 ? bean.getMaterialCategoryID() : null;
                        Date fromDate = bean.getFromDate() != null ? bean.getFromDate() : null;
                        Date toDate = bean.getToDate() != null ? bean.getToDate() : null;

                        if(warehouseID != null){
                            whereClause.append(" AND em.importmaterial.warehouse.warehouseID = :warehouseID");
                        }

                        if(materialID != null){
                            whereClause.append(" AND em.importmaterial.material.materialID = :materialID");
                        }

                        if(originID != null){
                            whereClause.append(" AND em.importmaterial.origin.originID = :originID");
                        }

                        if(materialCategoryID != null){
                            whereClause.append(" AND em.importmaterial.material.materialID IN (SELECT mac.material.materialID FROM MaterialAndCategory mac WHERE mac.materialCategory.materialCategoryID = :materialCategoryID)");
                        }

                        if(fromDate != null){
                            whereClause.append(" AND em.exportmaterialbill.exportDate >= :fromDate");
                        }


                        if(toDate != null){
                            whereClause.append(" AND em.exportmaterialbill.exportDate <= :toDate");
                        }

                        whereClause.append(" GROUP BY em.importmaterial.material, em.importmaterial.origin");

                        StringBuffer tailerQuery = new StringBuffer();
                        tailerQuery.append(" ORDER BY em.importmaterial.");

                        if(StringUtils.isBlank(bean.getSortExpression())){
                            tailerQuery.append("material.name");
                        }else{
                            tailerQuery.append(bean.getSortExpression());
                        }
                        if(StringUtils.isBlank(bean.getSortDirection()) || bean.getSortDirection().equals("1")){
                            tailerQuery.append(" ASC");
                        }else if(bean.getSortDirection().equals("2")){
                            tailerQuery.append(" DESC");
                        }

                        StringBuffer sql = new StringBuffer("SELECT em.importmaterial.material as material, em.importmaterial.origin as origin, SUM(em.quantity) as quantity");
                        sql.append(" FROM Exportmaterial em WHERE 1 = 1");
//                        sql.append(" AND em.importmaterial.status = :status");
                        sql.append(whereClause);
                        sql.append(tailerQuery);


                        Query query = session.createQuery(sql.toString());
//                        query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }else{
                            if(warehouseID != null){
                                query.setParameter("warehouseID", warehouseID);
                            }
                        }

                        if(materialID != null){
                            query.setParameter("materialID", materialID);
                        }

                        if(originID != null){
                            query.setParameter("originID", originID);
                        }

                        if(materialCategoryID != null){
                            query.setParameter("materialCategoryID", materialCategoryID);
                        }

                        if(fromDate !=null){
                            query.setParameter("fromDate", fromDate);
                        }

                        if(toDate != null){
                            query.setParameter("toDate", toDate);
                        }
                        query.setResultTransformer(Transformers.aliasToBean(ExportMaterialReportDetailDTO.class));
                        List<ExportMaterialReportDetailDTO> reportDetailDTO = (List<ExportMaterialReportDetailDTO>) query.list();
                        return reportDetailDTO;
                    }
                });
    }


}
