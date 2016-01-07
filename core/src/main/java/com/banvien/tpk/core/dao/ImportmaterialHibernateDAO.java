package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Importmaterial;
import com.banvien.tpk.core.dto.ExportMaterialReportBean;
import com.banvien.tpk.core.dto.ExportMaterialReportDetailDTO;
import com.banvien.tpk.core.dto.SearchMaterialBean;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Importmaterials</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ImportmaterialHibernateDAO extends
		AbstractHibernateDAO<Importmaterial, Long> implements
		ImportmaterialDAO {

	/**
	 * Find Importmaterial by importMaterialBillID
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterial> findByImportMaterialBillID(Long importMaterialBillID) {
		return findByCriteria(Restrictions.eq("importmaterialbill.importMaterialBillID", importMaterialBillID));
	}
	
	/**
	 * Find Importmaterial by materialID
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterial> findByMaterialID(Long materialID) {
		return findByCriteria(Restrictions.eq("material.materialID", materialID));
	}
	
	/**
	 * Find Importmaterial by originID
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterial> findByOriginID(Long originID) {
		return findByCriteria(Restrictions.eq("origin.originID", originID));
	}
	
	/**
	 * Find Importmaterial by expiredDate
	 */
	public List<Importmaterial> findByExpiredDate(Timestamp expiredDate) {
		return findByCriteria(Restrictions.eq("expiredDate", expiredDate));
	}
	
	/**
	 * Find Importmaterial by unit1ID
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterial> findByUnit1ID(Long unit1ID) {
		return findByCriteria(Restrictions.eq("unit.unit1ID", unit1ID));
	}
	
	/**
	 * Find Importmaterial by quantity1
	 */
	public List<Importmaterial> findByQuantity1(Double quantity1) {
		return findByCriteria(Restrictions.eq("quantity1", quantity1));
	}
	
	/**
	 * Find Importmaterial by unit2ID
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterial> findByUnit2ID(Long unit2ID) {
		return findByCriteria(Restrictions.eq("unit.unit2ID", unit2ID));
	}
	
	/**
	 * Find Importmaterial by quantity2
	 */
	public List<Importmaterial> findByQuantity2(Double quantity2) {
		return findByCriteria(Restrictions.eq("quantity2", quantity2));
	}
	
	/**
	 * Find Importmaterial by money
	 */
	public List<Importmaterial> findByMoney(Double money) {
		return findByCriteria(Restrictions.eq("money", money));
	}
	
	/**
	 * Find Importmaterial by note
	 */
	public List<Importmaterial> findByNote(String note) {
		return findByCriteria(Restrictions.eq("note", note));
	}
	
	/**
	 * Find Importmaterial by marketID
	 */
	@SuppressWarnings("unchecked")
	public List<Importmaterial> findByMarketID(Long marketID) {
		return findByCriteria(Restrictions.eq("market.marketID", marketID));
	}

    @Override
    public List<Importmaterial> findAvailableMaterialByWarehouse(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importmaterial>>() {
                    public List<Importmaterial> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importmaterial im ");
                        sqlQuery.append(" WHERE im.status = :status");
                        if (warehouseID != null){
                            sqlQuery.append(" AND im.warehouse.warehouseID = :warehouseID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                        if(warehouseID !=null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        return (List<Importmaterial>) query.list();
                    }
                });
    }

    @Override
    public Object[] searchMaterialsInStock(final SearchMaterialBean bean) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {
                    public Object[] doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer whereClause = new StringBuffer();
                        Long loginWarehouseID = bean.getLoginWarehouseID();
                        String code = bean.getCode() != null && StringUtils.isNotBlank(bean.getCode()) ? bean.getCode() : null;
                        Date importedDateFrom = bean.getFromImportedDate() != null ? bean.getFromImportedDate() : null;
                        Date importedDateTo = bean.getToImportedDate() != null ? bean.getToImportedDate() : null;
                        Long warehouseID = bean.getWarehouseID() != null && bean.getWarehouseID() > 0  ? bean.getWarehouseID() : null;
                        Long materialID = bean.getMaterialID() != null && bean.getMaterialID() > 0  ? bean.getMaterialID() : null;
                        Long marketID = bean.getMarketID() != null && bean.getMarketID() > 0  ? bean.getMarketID() : null;
                        Long originID = bean.getOriginID() != null && bean.getOriginID() > 0  ? bean.getOriginID() : null;
                        Long warehouseMapID = bean.getWarehouseMapID() != null && bean.getWarehouseMapID() > 0  ? bean.getWarehouseMapID() : null;
                        Date expiredDate = bean.getExpiredDate() != null ? bean.getExpiredDate() : null;
                        Long materialCategoryID = bean.getMaterialCategoryID() != null && bean.getMaterialCategoryID() > 0 ? bean.getMaterialCategoryID() : null;
                        Boolean isForExport = bean.getForExport();
                        Long userID = bean.getLoginID();
                        Double fromQuantity = bean.getFromQuantity();
                        Double toQuantity = bean.getToQuantity();

                        if(loginWarehouseID != null){
                            whereClause.append(" AND ip.warehouse.warehouseID = :loginWarehouseID");
                        }else{
                            if(warehouseID != null){
                                whereClause.append(" AND ip.warehouse.warehouseID = :warehouseID");
                            }
                        }
                        if(fromQuantity != null){
                            whereClause.append(" AND ip.remainQuantity >= :fromQuantity");
                        }

                        if(toQuantity != null){
                            whereClause.append(" AND ip.remainQuantity <= :toQuantity");
                        }

                        if(materialID != null){
                            whereClause.append(" AND ip.material.materialID = :materialID");
                        }
                        if(marketID != null){
                            whereClause.append(" AND ip.market.marketID = :marketID");
                        }
                        if(originID != null){
                            whereClause.append(" AND ip.origin.originID = :originID");
                        }
                        if(warehouseMapID != null){
                            whereClause.append(" AND ip.warehouseMap.warehouseMapID = :warehouseMapID");
                        }
                        if(importedDateFrom != null){
                            whereClause.append(" AND (ip.importDate >= :importedDateFrom)");
                        }
                        if(importedDateTo != null){
                            whereClause.append(" AND (ip.importDate <= :importedDateTo)");
                        }
                        if (code != null){
                            whereClause.append(" AND ip.code like :code");
                        }
                        if(expiredDate != null){
                            whereClause.append(" AND ip.expiredDate <= :expiredDate");
                        }
                        if(materialCategoryID != null){
                            whereClause.append(" AND ip.material.materialID IN (SELECT mac.material.materialID FROM MaterialAndCategory mac WHERE mac.materialCategory.materialCategoryID = :materialCategoryID)");
                        }
                        if(isForExport){
                            whereClause.append(" AND ip.material.materialID IN (SELECT mac.material.materialID FROM MaterialAndCategory mac " +
                                    "           WHERE mac.materialCategory.materialCategoryID IN ( " +
                                    "               SELECT umc.materialCategory.materialCategoryID FROM UserMaterialCate umc" +
                                    "               WHERE umc.user.userID = :userID))");
                        }

                        StringBuffer tailerQuery = new StringBuffer();
                        tailerQuery.append(" ORDER BY ip.");

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

                        StringBuffer sql = new StringBuffer("FROM Importmaterial ip WHERE ip.status = :status");
                        sql.append(whereClause);
                        sql.append(tailerQuery);


                        Query query = session.createQuery(sql.toString());
                        query.setFirstResult(bean.getFirstItem());
                        query.setMaxResults(bean.getMaxPageItems());
                        query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                        if(loginWarehouseID != null){
                            query.setParameter("loginWarehouseID", loginWarehouseID);
                        }else{
                            if(warehouseID != null){
                                query.setParameter("warehouseID", warehouseID);
                            }
                        }

                        if(fromQuantity != null){
                            query.setParameter("fromQuantity", fromQuantity);
                        }

                        if(toQuantity != null){
                            query.setParameter("toQuantity", toQuantity);
                        }
                        if(materialID !=null){
                            query.setParameter("materialID", materialID);
                        }
                        if(marketID !=null){
                            query.setParameter("marketID", marketID);
                        }
                        if(originID !=null){
                            query.setParameter("originID", originID);
                        }
                        if(warehouseMapID != null){
                            query.setParameter("warehouseMapID", warehouseMapID);
                        }
                        if(importedDateFrom !=null){
                            query.setParameter("importedDateFrom", importedDateFrom);
                        }
                        if(importedDateTo !=null){
                            query.setParameter("importedDateTo", importedDateTo);
                        }
                        if(code !=null){
                            query.setParameter("code", "%"+code+"%");
                        }
                        if(expiredDate != null){
                            query.setParameter("expiredDate", expiredDate);
                        }
                        if(materialCategoryID != null){
                            query.setParameter("materialCategoryID", materialCategoryID);
                        }
                        if(isForExport){
                            query.setParameter("userID", userID);
                        }

                        StringBuffer stringBufferCounter = new StringBuffer("SELECT count(*) FROM Importmaterial ip WHERE ip.status = :status");
                        stringBufferCounter.append(whereClause);
                        stringBufferCounter.append(tailerQuery);

                        Query queryCounter = session.createQuery(stringBufferCounter.toString());
                        queryCounter.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);

                        if(loginWarehouseID != null){
                            queryCounter.setParameter("loginWarehouseID", loginWarehouseID);
                        }else{
                            if(warehouseID != null){
                                queryCounter.setParameter("warehouseID", warehouseID);
                            }
                        }
                        if(fromQuantity != null){
                            queryCounter.setParameter("fromQuantity", fromQuantity);
                        }

                        if(toQuantity != null){
                            queryCounter.setParameter("toQuantity", toQuantity);
                        }
                        if(materialID !=null){
                            queryCounter.setParameter("materialID", materialID);
                        }
                        if(marketID !=null){
                            queryCounter.setParameter("marketID", marketID);
                        }
                        if(originID !=null){
                            queryCounter.setParameter("originID", originID);
                        }
                        if(warehouseMapID != null){
                            queryCounter.setParameter("warehouseMapID", warehouseMapID);
                        }
                        if(importedDateFrom !=null){
                            queryCounter.setParameter("importedDateFrom", importedDateFrom);
                        }
                        if(importedDateTo !=null){
                            queryCounter.setParameter("importedDateTo", importedDateTo);
                        }
                        if(code !=null){
                            queryCounter.setParameter("code", "%"+code+"%");
                        }
                        if(expiredDate != null){
                            queryCounter.setParameter("expiredDate", expiredDate);
                        }
                        if(materialCategoryID != null){
                            queryCounter.setParameter("materialCategoryID", materialCategoryID);
                        }
                        if(isForExport){
                            queryCounter.setParameter("userID", userID);
                        }
                        List list = query.list();
                        Long totalResults = Long.valueOf(queryCounter.uniqueResult().toString());
                        return new Object[]{totalResults, list};
                    }
                });
    }

    @Override
    public List<Importmaterial> findWarningMaterial(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importmaterial>>() {
                    public List<Importmaterial> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Timestamp warningDate = new Timestamp(System.currentTimeMillis() + Constants.A_MONTH * 3);
                        StringBuffer sqlQuery = new StringBuffer("FROM Importmaterial im WHERE 1 = 1");
                        sqlQuery.append(" AND im.status = :status");
                        sqlQuery.append(" AND (im.expiredDate <= :warningDate OR im.remainQuantity <= im.material.warningQuantity)");
                        if(warehouseID != null){
                            sqlQuery.append(" AND im.warehouse.warehouseID = :warehouseID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        query.setParameter("warningDate", warningDate);
                        query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                        return (List<Importmaterial>) query.list();
                    }
                });
    }

    @Override
    public List<ExportMaterialReportDetailDTO> findAllInitialMaterial(final ExportMaterialReportBean bean) {
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
                        String cateCode = StringUtils.isNotBlank(bean.getCateCode()) ? bean.getCateCode() : null;

                        if(warehouseID != null){
                            whereClause.append(" AND ip.warehouse.warehouseID = :warehouseID");
                        }

                        if(materialID != null){
                            whereClause.append(" AND ip.material.materialID = :materialID");
                        }

                        if(originID != null){
                            whereClause.append(" AND ip.origin.originID = :originID");
                        }

                        if(materialCategoryID != null){
                            whereClause.append(" AND ip.material.materialID IN (SELECT mac.material.materialID FROM MaterialAndCategory mac WHERE mac.materialCategory.materialCategoryID = :materialCategoryID)");
                        }

                        if(fromDate != null){
                            whereClause.append(" AND ip.importDate < :fromDate");
                        }

                        whereClause.append(" GROUP BY ip.material, ip.origin");

                        StringBuffer tailerQuery = new StringBuffer();
                        if(cateCode != null && cateCode.equals(Constants.M_CATE_MAU)){
                            tailerQuery.append(" ORDER BY ip.origin.name, ip.material.name");
                            tailerQuery.append(" ASC");
                        }else{
                            tailerQuery.append(" ORDER BY ip.material.name");
                            tailerQuery.append(" ASC");
                        }

                        StringBuffer sql = new StringBuffer("SELECT ip.material as material,ip.code as code,ip.origin as origin, SUM(ip.quantity) as quantity, min(ip.importDate) as importDate");
                        sql.append(" FROM Importmaterial ip WHERE 1 = 1");
//                        sql.append(" AND ip.status = :status");
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

                        if(fromDate != null){
                            query.setParameter("fromDate", fromDate);
                        }
                        query.setResultTransformer(Transformers.aliasToBean(ExportMaterialReportDetailDTO.class));
                        List<ExportMaterialReportDetailDTO> reportDetailDTO = (List<ExportMaterialReportDetailDTO>) query.list();
                        return reportDetailDTO;
                    }
                });
    }

    @Override
    public List<ExportMaterialReportDetailDTO> findAllImportDuringDate(final ExportMaterialReportBean bean) {
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
                            whereClause.append(" AND ip.warehouse.warehouseID = :warehouseID");
                        }

                        if(materialID != null){
                            whereClause.append(" AND ip.material.materialID = :materialID");
                        }

                        if(originID != null){
                            whereClause.append(" AND ip.origin.originID = :originID");
                        }

                        if(materialCategoryID != null){
                            whereClause.append(" AND ip.material.materialID IN (SELECT mac.material.materialID FROM MaterialAndCategory mac WHERE mac.materialCategory.materialCategoryID = :materialCategoryID)");
                        }

                        if(fromDate != null){
                            whereClause.append(" AND ip.importDate >= :fromDate");
                        }


                        if(toDate != null){
                            whereClause.append(" AND ip.importDate <= :toDate");
                        }

                        whereClause.append(" GROUP BY ip.material, ip.origin");

                        StringBuffer tailerQuery = new StringBuffer();
                        tailerQuery.append(" ORDER BY ip.");

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

                        StringBuffer sql = new StringBuffer("SELECT ip.material as material,ip.origin as origin, SUM(ip.quantity) as quantity, min(ip.importDate) as importDate");
                        sql.append(" FROM Importmaterial ip WHERE 1 = 1");
//                        sql.append(" AND ip.status = :status");
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
