package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.Importproductbill;
import com.banvien.tpk.core.dto.ProducedProductBean;
import com.banvien.tpk.core.dto.ReportBean;
import com.banvien.tpk.core.dto.SearchProductBean;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Importproducts</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class ImportproductHibernateDAO extends
		AbstractHibernateDAO<Importproduct, Long> implements
		ImportproductDAO {

	/**
	 * Find Importproduct by importProductBillID
	 */
	@SuppressWarnings("unchecked")
	public List<Importproduct> findByImportProductBillID(Long importProductBillID) {
		return findByCriteria(Restrictions.eq("importproductbill.importProductBillID", importProductBillID));
	}
	
	/**
	 * Find Importproduct by productID
	 */
	@SuppressWarnings("unchecked")
	public List<Importproduct> findByProductID(Long productID) {
		return findByCriteria(Restrictions.eq("product.productID", productID));
	}
	
	/**
	 * Find Importproduct by productCode
	 */
	public List<Importproduct> findByProductCode(String productCode) {
		return findByCriteria(Restrictions.eq("productCode", productCode));
	}
	
	/**
	 * Find Importproduct by originID
	 */
	@SuppressWarnings("unchecked")
	public List<Importproduct> findByOriginID(Long originID) {
		return findByCriteria(Restrictions.eq("origin.originID", originID));
	}
	
	/**
	 * Find Importproduct by produceDate
	 */
	public List<Importproduct> findByProduceDate(Timestamp produceDate) {
		return findByCriteria(Restrictions.eq("produceDate", produceDate));
	}
	
	/**
	 * Find Importproduct by mainUsedMaterialID
	 */
	@SuppressWarnings("unchecked")
	public List<Importproduct> findByMainUsedMaterialID(Long mainUsedMaterialID) {
		return findByCriteria(Restrictions.eq("material.mainUsedMaterialID", mainUsedMaterialID));
	}
	
	/**
	 * Find Importproduct by mainUsedMaterialCode
	 */
	public List<Importproduct> findByMainUsedMaterialCode(String mainUsedMaterialCode) {
		return findByCriteria(Restrictions.eq("mainUsedMaterialCode", mainUsedMaterialCode));
	}
	
	/**
	 * Find Importproduct by mainUsedProductID
	 */
	@SuppressWarnings("unchecked")
	public List<Importproduct> findByMainUsedProductID(Long mainUsedProductID) {
		return findByCriteria(Restrictions.eq("product.mainUsedProductID", mainUsedProductID));
	}
	
	/**
	 * Find Importproduct by mainUsedProductCode
	 */
	public List<Importproduct> findByMainUsedProductCode(String mainUsedProductCode) {
		return findByCriteria(Restrictions.eq("mainUsedProductCode", mainUsedProductCode));
	}
	
	/**
	 * Find Importproduct by note
	 */
	public List<Importproduct> findByNote(String note) {
		return findByCriteria(Restrictions.eq("note", note));
	}
	
	/**
	 * Find Importproduct by unit1ID
	 */
	@SuppressWarnings("unchecked")
	public List<Importproduct> findByUnit1ID(Long unit1ID) {
		return findByCriteria(Restrictions.eq("unit.unit1ID", unit1ID));
	}
	
	/**
	 * Find Importproduct by quantity1
	 */
	public List<Importproduct> findByQuantity1(Double quantity1) {
		return findByCriteria(Restrictions.eq("quantity1", quantity1));
	}
	
	/**
	 * Find Importproduct by unit2ID
	 */
	@SuppressWarnings("unchecked")
	public List<Importproduct> findByUnit2ID(Long unit2ID) {
		return findByCriteria(Restrictions.eq("unit.unit2ID", unit2ID));
	}
	
	/**
	 * Find Importproduct by quantity2
	 */
	public List<Importproduct> findByQuantity2(Double quantity2) {
		return findByCriteria(Restrictions.eq("quantity2", quantity2));
	}
	
	/**
	 * Find Importproduct by money
	 */
	public List<Importproduct> findByMoney(Double money) {
		return findByCriteria(Restrictions.eq("money", money));
	}
	
	/**
	 * Find Importproduct by marketID
	 */
	@SuppressWarnings("unchecked")
	public List<Importproduct> findByMarketID(Long marketID) {
		return findByCriteria(Restrictions.eq("market.marketID", marketID));
	}

    @Override
    public List<Importproduct> findAvailableBlackProductByWarehouse(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip ");
                        sqlQuery.append(" WHERE ip.status = :status")
                        .append(" AND ip.productname.code = :code");
                        if (warehouseID != null){
                            sqlQuery.append(" AND ip.warehouse.warehouseID = :warehouseID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                        query.setParameter("code", Constants.PRODUCT_BLACK);
                        if(warehouseID !=null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findAvailableNoneBlackProductByWarehouse(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip ");
                        sqlQuery.append(" WHERE ip.status = :status")
                                .append(" AND (ip.productname.code <> :code OR ip.productname.code IS NULL)");
                        if (warehouseID != null){
                            sqlQuery.append(" AND ip.warehouse.warehouseID = :warehouseID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                        query.setParameter("code", Constants.PRODUCT_BLACK);
                        if(warehouseID !=null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findTempSelectedBlackProductByWarehouseAndCodes(final Long warehouseID,final List<String> tempSelectedCodes) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip ");
                        sqlQuery.append(" WHERE ip.status = :status")
                                .append(" AND ip.productname.code = :code");
                        if (warehouseID != null){
                            sqlQuery.append(" AND ip.importproductbill.warehouse.warehouseID = :warehouseID");
                        }
                        if(tempSelectedCodes != null && tempSelectedCodes.size()>0){
                            sqlQuery.append(" AND ip.productCode IN :tempSelectedCodes");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_USED);
                        query.setParameter("code", Constants.PRODUCT_BLACK);
                        if(warehouseID !=null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        if(tempSelectedCodes != null && tempSelectedCodes.size()>0){
                            query.setParameterList("tempSelectedCodes", tempSelectedCodes);
                        }
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public void updateDragBackProducts(final Long exportWarehouseID, final List<Long> dragBackProducts, final Integer status) {
        getHibernateTemplate().execute(
                new HibernateCallback<Object>() {
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sQuery = new StringBuffer("UPDATE importproduct i SET status = :status, warehouseID = :exportWarehouseID");
                        sQuery.append(" WHERE i.importProductID IN (:dragBackProducts)");
                        SQLQuery query = session.createSQLQuery(sQuery.toString());
                        query.setParameterList("dragBackProducts", dragBackProducts);
                        query.setParameter("exportWarehouseID", exportWarehouseID);
                        query.setParameter("status",status);
                        return query.executeUpdate();
                    }
                });
    }

    @Override
    public Object[] searchProductsInStock(final SearchProductBean bean) {
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
                        Long productNameID = bean.getProductNameID() != null && bean.getProductNameID() > 0  ? bean.getProductNameID() : null;
                        Long marketID = bean.getMarketID() != null && bean.getMarketID() > 0  ? bean.getMarketID() : null;
                        Long sizeID = bean.getSizeID() != null && bean.getSizeID() > 0  ? bean.getSizeID() : null;
                        Long thicknessID = bean.getThicknessID() != null && bean.getThicknessID() > 0  ? bean.getThicknessID() : null;
                        Long stiffnessID = bean.getStiffnessID() != null && bean.getStiffnessID() > 0  ? bean.getStiffnessID() : null;
                        Long colourID = bean.getColourID() != null && bean.getColourID() > 0  ? bean.getColourID() : null;
                        Long overlayTypeID = bean.getOverlayTypeID() != null && bean.getOverlayTypeID() > 0  ? bean.getOverlayTypeID() : null;
                        Long originID = bean.getOriginID() != null && bean.getOriginID() > 0  ? bean.getOriginID() : null;
                        Long warehouseMapID = bean.getWarehouseMapID() != null && bean.getWarehouseMapID() > 0  ? bean.getWarehouseMapID() : null;
                        Double fromKgM = bean.getFromKgM() != null ? bean.getFromKgM() : null;
                        Double toKgM = bean.getToKgM() != null ? bean.getToKgM() : null;

                        Boolean suggestPrice = bean.getSuggestPrice();
                        Boolean nonePriced = bean.getNonePriced();
                        Boolean booking = bean.getBooking();
                        Boolean reportOverlay = bean.getReportOverlay();
                        Boolean reportSummaryProduction = bean.getReportSummaryProduction();
                        Boolean editInfo = bean.getEditInfo();

                        Boolean viewInStock = bean.getViewInStock();
                        Integer status = bean.getStatus() != null ? bean.getStatus() : null;
                        if(loginWarehouseID != null){
                            whereClause.append(" AND ip.warehouse.warehouseID = :loginWarehouseID");
                        }else{
                            if(warehouseID != null){
                                whereClause.append(" AND ip.warehouse.warehouseID = :warehouseID");
                            }
                        }

                        if(fromKgM != null){
                            whereClause.append(" AND (ip.quantity2Pure / ip.quantity1) >= :fromKgM");
                        }
                        if(toKgM != null){
                            whereClause.append(" AND (ip.quantity2Pure / ip.quantity1) <= :toKgM");
                        }

                        if(productNameID != null){
                            whereClause.append(" AND ip.productname.productNameID = :productNameID");
                        }
                        if(marketID != null){
                            whereClause.append(" AND ip.market.marketID = :marketID");
                        }
                        if(sizeID != null){
                            whereClause.append(" AND ip.size.sizeID = :sizeID");
                        }
                        if(thicknessID != null){
                            whereClause.append(" AND ip.thickness.thicknessID = :thicknessID");
                        }
                        if(stiffnessID != null){
                            whereClause.append(" AND ip.stiffness.stiffnessID = :stiffnessID");
                        }
                        if(colourID != null){
                            whereClause.append(" AND ip.colour.colourID = :colourID");
                        }
                        if(overlayTypeID != null){
                            whereClause.append(" AND ip.overlaytype.overlayTypeID = :overlayTypeID");
                        }
                        if(originID != null){
                            whereClause.append(" AND (ip.origin.originID = :originID");
                            whereClause.append(" OR m1.origin.originID = :originID");
                            whereClause.append(" OR m2.origin.originID = :originID)");
                        }
                        if(warehouseMapID != null){
                            whereClause.append(" AND ip.warehouseMap.warehouseMapID = :warehouseMapID");
                        }
                        if(importedDateFrom != null){
                            whereClause.append(" AND (ip.importDate >= :importedDateFrom OR ip.produceDate >= :importedDateFrom)");
                        }
                        if(importedDateTo != null){
                            whereClause.append(" AND (ip.importDate <= :importedDateTo OR ip.produceDate <= :importedDateTo)");
                        }
                        if (code != null){
                            whereClause.append(" AND ip.productCode like :code");
                        }
                        if(suggestPrice){
                            whereClause.append(" AND (ip.productname.code <> :blackProduct OR ip.productname.code IS NULL)");
                        }
                        if(nonePriced){
                            whereClause.append(" AND ip.suggestedPrice IS NULL");
                        }
                        if(booking){
                            whereClause.append(" AND (ip.productname.code <> :blackProduct OR ip.productname.code IS NULL)");
                            whereClause.append(" AND (ip.saleWarehouse IS NULL)");
                        }
                        if(reportOverlay){
                            whereClause.append(" AND ip.mainUsedMaterial IS NOT NULL");
                            whereClause.append(" AND ip.overlaytype IS NOT NULL");
                        }
                        if(reportSummaryProduction){
                            whereClause.append(" AND ip.mainUsedMaterial IS NOT NULL");
                        }

                        if(!reportOverlay && !reportSummaryProduction && !editInfo){
                            if(viewInStock && status == null){
                                whereClause.append(" AND (ip.status = :availableStatus OR ip.status = :bookedStatus)");
                            }else{
                                whereClause.append(" AND ip.status = :status");
                            }
                        }

                        StringBuffer tailerQuery = new StringBuffer();
                        tailerQuery.append(" ORDER BY ip.");

                        if(StringUtils.isBlank(bean.getSortExpression())){
                            tailerQuery.append("productCode ASC");
                        }else{
                            tailerQuery.append(bean.getSortExpression());
                        }
                        if(StringUtils.isBlank(bean.getSortDirection()) || bean.getSortDirection().equals("2")){
                            tailerQuery.append(" DESC");
                        }else if(bean.getSortDirection().equals("1")){
                            tailerQuery.append(" ASC");
                        }

                        StringBuffer sql = new StringBuffer("SELECT ip FROM Importproduct ip left join ip.mainUsedMaterial m1 left join ip.mainUsedMaterial.mainUsedMaterial m2 WHERE 1 = 1");
                        sql.append(whereClause);
                        sql.append(tailerQuery);

                        Query query = session.createQuery(sql.toString());
                        query.setFirstResult(bean.getFirstItem());
                        query.setMaxResults(bean.getMaxPageItems());
                        if(!reportOverlay && !reportSummaryProduction && !editInfo){
                            if(viewInStock && status == null){
                                query.setParameter("availableStatus", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                                query.setParameter("bookedStatus", Constants.ROOT_MATERIAL_STATUS_BOOKED);
                            }else if(viewInStock && status != null){
                                query.setParameter("status", status);
                            }else{
                                query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                            }
                        }
                        if(suggestPrice){
                            query.setParameter("blackProduct", Constants.PRODUCT_BLACK);
                        }
                        if(booking){
                            query.setParameter("blackProduct", Constants.PRODUCT_BLACK);
                        }
                        if(loginWarehouseID != null){
                            query.setParameter("loginWarehouseID", loginWarehouseID);
                        }else{
                            if(warehouseID != null){
                                query.setParameter("warehouseID", warehouseID);
                            }
                        }
                        if(fromKgM != null){
                            query.setParameter("fromKgM", fromKgM);
                        }
                        if(toKgM != null){
                            query.setParameter("toKgM", toKgM);
                        }
                        if(productNameID !=null){
                            query.setParameter("productNameID", productNameID);
                        }
                        if(marketID !=null){
                            query.setParameter("marketID", marketID);
                        }
                        if(sizeID !=null){
                            query.setParameter("sizeID", sizeID);
                        }
                        if(thicknessID !=null){
                            query.setParameter("thicknessID", thicknessID);
                        }
                        if(stiffnessID !=null){
                            query.setParameter("stiffnessID", stiffnessID);
                        }
                        if(colourID !=null){
                            query.setParameter("colourID", colourID);
                        }
                        if(overlayTypeID !=null){
                            query.setParameter("overlayTypeID", overlayTypeID);
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
                            query.setParameter("code","%" + code + "%");
                        }

                        StringBuffer stringBufferCounter = new StringBuffer("SELECT count(*) FROM Importproduct as ip left join ip.mainUsedMaterial as m1 left join ip.mainUsedMaterial.mainUsedMaterial as m2 WHERE 1 = 1");
                        stringBufferCounter.append(whereClause);
                        stringBufferCounter.append(tailerQuery);

                        Query queryCounter = session.createQuery(stringBufferCounter.toString());
                        if(!reportOverlay && !reportSummaryProduction && !editInfo){
                            if(viewInStock && status == null){
                                queryCounter.setParameter("availableStatus", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                                queryCounter.setParameter("bookedStatus", Constants.ROOT_MATERIAL_STATUS_BOOKED);
                            }else if(viewInStock && status != null){
                                queryCounter.setParameter("status", status);
                            }else{
                                queryCounter.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                            }
                        }
                        if(suggestPrice){
                            queryCounter.setParameter("blackProduct", Constants.PRODUCT_BLACK);
                        }
                        if(booking){
                            queryCounter.setParameter("blackProduct", Constants.PRODUCT_BLACK);
                        }
                        if(loginWarehouseID != null){
                            queryCounter.setParameter("loginWarehouseID", loginWarehouseID);
                        }else{
                            if(warehouseID != null){
                                queryCounter.setParameter("warehouseID", warehouseID);
                            }
                        }
                        if(fromKgM != null){
                            queryCounter.setParameter("fromKgM", fromKgM);
                        }
                        if(toKgM != null){
                            queryCounter.setParameter("toKgM", toKgM);
                        }
                        if(productNameID !=null){
                            queryCounter.setParameter("productNameID", productNameID);
                        }
                        if(marketID !=null){
                            queryCounter.setParameter("marketID", marketID);
                        }
                        if(sizeID !=null){
                            queryCounter.setParameter("sizeID", sizeID);
                        }
                        if(thicknessID !=null){
                            queryCounter.setParameter("thicknessID", thicknessID);
                        }
                        if(stiffnessID !=null){
                            queryCounter.setParameter("stiffnessID", stiffnessID);
                        }
                        if(colourID !=null){
                            queryCounter.setParameter("colourID", colourID);
                        }
                        if(overlayTypeID !=null){
                            queryCounter.setParameter("overlayTypeID", overlayTypeID);
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
                            queryCounter.setParameter("code","%" + code + "%");
                        }
                        Double met = 0d;
                        Double kg = 0d;
                        if(!reportOverlay && !reportSummaryProduction && !editInfo){
                            StringBuffer stringBufferSum = new StringBuffer("SELECT SUM(ip.quantity1) as met, SUM(ip.quantity2Pure) as kg FROM Importproduct as ip left join ip.mainUsedMaterial as m1 left join ip.mainUsedMaterial.mainUsedMaterial as m2 WHERE 1 = 1");
                            stringBufferSum.append(whereClause);
                            stringBufferSum.append(tailerQuery);

                            Query querySum = session.createQuery(stringBufferSum.toString());
                            if(viewInStock && status == null){
                                querySum.setParameter("availableStatus", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                                querySum.setParameter("bookedStatus", Constants.ROOT_MATERIAL_STATUS_BOOKED);
                            }else if(viewInStock && status != null){
                                querySum.setParameter("status", status);
                            }else{
                                querySum.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                            }
                            if(suggestPrice){
                                querySum.setParameter("blackProduct", Constants.PRODUCT_BLACK);
                            }
                            if(booking){
                                querySum.setParameter("blackProduct", Constants.PRODUCT_BLACK);
                            }
                            if(loginWarehouseID != null){
                                querySum.setParameter("loginWarehouseID", loginWarehouseID);
                            }else{
                                if(warehouseID != null){
                                    querySum.setParameter("warehouseID", warehouseID);
                                }
                            }
                            if(fromKgM != null){
                                querySum.setParameter("fromKgM", fromKgM);
                            }
                            if(toKgM != null){
                                querySum.setParameter("toKgM", toKgM);
                            }
                            if(productNameID !=null){
                                querySum.setParameter("productNameID", productNameID);
                            }
                            if(marketID !=null){
                                querySum.setParameter("marketID", marketID);
                            }
                            if(sizeID !=null){
                                querySum.setParameter("sizeID", sizeID);
                            }
                            if(thicknessID !=null){
                                querySum.setParameter("thicknessID", thicknessID);
                            }
                            if(stiffnessID !=null){
                                querySum.setParameter("stiffnessID", stiffnessID);
                            }
                            if(colourID !=null){
                                querySum.setParameter("colourID", colourID);
                            }
                            if(overlayTypeID !=null){
                                querySum.setParameter("overlayTypeID", overlayTypeID);
                            }
                            if(originID !=null){
                                querySum.setParameter("originID", originID);
                            }
                            if(warehouseMapID != null){
                                querySum.setParameter("warehouseMapID", warehouseMapID);
                            }
                            if(importedDateFrom !=null){
                                querySum.setParameter("importedDateFrom", importedDateFrom);
                            }
                            if(importedDateTo !=null){
                                querySum.setParameter("importedDateTo", importedDateTo);
                            }
                            if(code !=null){
                                querySum.setParameter("code", "%" +  code + "%");
                            }

                            Object[] sum = (Object[]) querySum.uniqueResult();

                            if(sum[0] != null){
                                met = Double.valueOf(sum[0].toString());
                            }
                            if(sum[1] != null){
                                kg = Double.valueOf(sum[1].toString());
                            }
                        }
                        List list = query.list();
                        Long totalResults = Long.valueOf(queryCounter.uniqueResult().toString());
                        return new Object[]{totalResults, list,met,kg};
                    }
                });
    }

    @Override
    public List<Importproduct> findImportProduct(final ProducedProductBean bean) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer whereClause = new StringBuffer();
                        Long loginWarehouseID = bean.getLoginWarehouseID();
                        String code = bean.getCode() != null && StringUtils.isNotBlank(bean.getCode()) ? bean.getCode() : null;
                        Date fromDate = bean.getFromDate() != null ? bean.getFromDate() : null;
                        Date toDate = bean.getToDate() != null ? bean.getToDate() : null;
                        Long warehouseID = bean.getWarehouseID() != null && bean.getWarehouseID() > 0  ? bean.getWarehouseID() : null;
                        Long productNameID = bean.getProductNameID() != null && bean.getProductNameID() > 0  ? bean.getProductNameID() : null;
                        Long producedProductID = bean.getProducedProductID() != null && bean.getProducedProductID() > 0  ? bean.getProducedProductID() : null;
                        Long marketID = bean.getMarketID() != null && bean.getMarketID() > 0  ? bean.getMarketID() : null;
                        Long sizeID = bean.getSizeID() != null && bean.getSizeID() > 0  ? bean.getSizeID() : null;
                        Long thicknessID = bean.getThicknessID() != null && bean.getThicknessID() > 0  ? bean.getThicknessID() : null;
                        Long stiffnessID = bean.getStiffnessID() != null && bean.getStiffnessID() > 0  ? bean.getStiffnessID() : null;
                        Long colourID = bean.getColourID() != null && bean.getColourID() > 0  ? bean.getColourID() : null;
                        Long overlayTypeID = bean.getOverlayTypeID() != null && bean.getOverlayTypeID() > 0  ? bean.getOverlayTypeID() : null;
                        Long originID = bean.getOriginID() != null && bean.getOriginID() > 0  ? bean.getOriginID() : null;
                        Long productionPlanID = bean.getProductionPlanID() != null && bean.getProductionPlanID() > 0 ? bean.getProductionPlanID() : null;
                        Boolean reportOverlay = bean.getReportOverlay();
                        Boolean reportSummaryProduction = bean.getReportSummaryProduction();
                        Boolean reportCost = bean.getReportCost();

                        if(loginWarehouseID != null){
                            whereClause.append(" AND ip.importproductbill.warehouse.warehouseID = :loginWarehouseID");
                        }else{
                            if(warehouseID != null){
                                whereClause.append(" AND ip.importproductbill.warehouse.warehouseID = :warehouseID");
                            }
                        }
                        if(productionPlanID != null){
                            whereClause.append(" AND ip.importproductbill.productionPlan.productionPlanID = :productionPlanID");
                        }
                        if(productNameID != null){
                            whereClause.append(" AND ip.mainUsedMaterial.productname.productNameID = :productNameID");
                        }
                        if(producedProductID != null){
                            whereClause.append(" AND ip.productname.productNameID = :producedProductID");
                        }
                        if(marketID != null){
                            whereClause.append(" AND ip.market.marketID = :marketID");
                        }
                        if(sizeID != null){
                            whereClause.append(" AND ip.size.sizeID = :sizeID");
                        }
                        if(sizeID != null && reportCost){
                            whereClause.append(" AND NOT EXISTS (SELECT 1 FROM Importproduct temp ")
                            .append("WHERE temp.importproductbill.productionPlan.productionPlanID = ip.importproductbill.productionPlan.productionPlanID ")
                            .append(" AND temp.size.sizeID <> :sizeID)");
                        }
                        if(thicknessID != null){
                            whereClause.append(" AND ip.thickness.thicknessID = :thicknessID");
                        }
                        if(stiffnessID != null){
                            whereClause.append(" AND ip.stiffness.stiffnessID = :stiffnessID");
                        }
                        if(colourID != null){
                            whereClause.append(" AND ip.colour.colourID = :colourID");
                        }
                        if(overlayTypeID != null){
                            whereClause.append(" AND ip.overlaytype.overlayTypeID = :overlayTypeID");
                        }
                        if(originID != null){
                            whereClause.append(" AND ip.mainUsedMaterial.origin.originID = :originID");
                        }
                        if(fromDate != null){
                            whereClause.append(" AND (ip.importDate >= :fromDate OR ip.produceDate >= :fromDate)");
                        }
                        if(toDate != null){
                            whereClause.append(" AND (ip.importDate <= :toDate OR ip.produceDate <= :toDate)");
                        }
                        if (code != null){
                            whereClause.append(" AND ip.productCode = :code");
                        }

                        if(reportOverlay){
                            whereClause.append(" AND ip.mainUsedMaterial IS NOT NULL");
                            whereClause.append(" AND ip.overlaytype IS NOT NULL");
                        }
                        if(reportSummaryProduction){
                            whereClause.append(" AND ip.mainUsedMaterial IS NOT NULL");
                        }

                        StringBuffer tailerQuery = new StringBuffer();
                        tailerQuery.append(" ORDER BY");

                        if(StringUtils.isBlank(bean.getSortExpression())){
                            tailerQuery.append(" ip.importproductbill.produceDate ,cast(substring(ip.productCode,5,8) AS int)");
                        }else{
                            tailerQuery.append(" ip.").append(bean.getSortExpression());
                        }
                        if(StringUtils.isBlank(bean.getSortDirection()) || bean.getSortDirection().equals("1")){
                            tailerQuery.append(" ASC");
                        }else if(bean.getSortDirection().equals("2")){
                            tailerQuery.append(" DESC");
                        }

                        StringBuffer sql = new StringBuffer("FROM Importproduct ip WHERE 1 = 1");
                        sql.append(" AND ip.importproductbill.produceGroup = :flag");
                        sql.append(whereClause);
                        sql.append(tailerQuery);

                        Query query = session.createQuery(sql.toString());
//                        query.setFirstResult(bean.getFirstItem());
//                        query.setMaxResults(bean.getMaxPageItems());

                        if(loginWarehouseID != null){
                            query.setParameter("loginWarehouseID", loginWarehouseID);
                        }else{
                            if(warehouseID != null){
                                query.setParameter("warehouseID", warehouseID);
                            }
                        }
                        if(productionPlanID != null){
                            query.setParameter("productionPlanID", productionPlanID);
                        }
                        if(productNameID !=null){
                            query.setParameter("productNameID", productNameID);
                        }
                        if(producedProductID !=null){
                            query.setParameter("producedProductID", producedProductID);
                        }
                        if(marketID !=null){
                            query.setParameter("marketID", marketID);
                        }
                        if(sizeID !=null){
                            query.setParameter("sizeID", sizeID);
                        }
                        if(thicknessID !=null){
                            query.setParameter("thicknessID", thicknessID);
                        }
                        if(stiffnessID !=null){
                            query.setParameter("stiffnessID", stiffnessID);
                        }
                        if(colourID !=null){
                            query.setParameter("colourID", colourID);
                        }
                        if(overlayTypeID !=null){
                            query.setParameter("overlayTypeID", overlayTypeID);
                        }
                        if(originID !=null){
                            query.setParameter("originID", originID);
                        }
                        if(fromDate !=null){
                            query.setParameter("fromDate", fromDate);
                        }
                        if(toDate !=null){
                            query.setParameter("toDate", toDate);
                        }
                        if(code !=null){
                            query.setParameter("code", code);
                        }
                        query.setParameter("flag",Constants.PRODUCT_GROUP_PRODUCED);
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findByProductionPlanIDs(final List<Long> productionPlanIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ip.importproductbill.productionPlan.productionPlanID IN ( :productionPlanIDs) AND ip.importproductbill.parentBill IS NULL");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("productionPlanIDs", productionPlanIDs);
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Object[]> findProductionTimesByPlans(final List<Long> productionPlanIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Object[]>>() {
                    public List<Object[]> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT ip.importproductbill.productionPlan.productionPlanID as planID," +
                                " min(ip.importproductbill.produceDate) as startDate, max(ip.importproductbill.produceDate) as endDate FROM Importproduct ip ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ip.importproductbill.productionPlan.productionPlanID IN ( :productionPlanIDs)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("productionPlanIDs", productionPlanIDs);
                        return (List<Object[]>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findByIDs(final List<Long> productIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip ");
                        sqlQuery.append(" WHERE ip.importProductID IN (:productIDs)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("productIDs", productIDs);
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public void updateStatus(final List<Long> bookedProductIDs, final Integer status) {
        getHibernateTemplate().execute(
                new HibernateCallback<Object>() {
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sQuery = new StringBuffer("UPDATE importproduct i SET status = :status");
                        sQuery.append(" WHERE i.importProductID IN (:bookedProductIDs)");
                        SQLQuery query = session.createSQLQuery(sQuery.toString());
                        query.setParameterList("bookedProductIDs", bookedProductIDs);
                        query.setParameter("status",status);
                        return query.executeUpdate();
                    }
                });
    }

    @Override
    public void updateStatusByCodes(final List<String> codes,final Integer rootMaterialStatusUsed) {
        getHibernateTemplate().execute(
                new HibernateCallback<Object>() {
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sQuery = new StringBuffer("UPDATE importproduct i SET status = :status");
                        sQuery.append(" WHERE i.productCode IN (:codes)");
                        SQLQuery query = session.createSQLQuery(sQuery.toString());
                        query.setParameterList("codes", codes);
                        query.setParameter("status",rootMaterialStatusUsed);
                        return query.executeUpdate();
                    }
                });
    }

    @Override
    public List<Importproduct> findWarningProduct(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Timestamp warningDate = new Timestamp(System.currentTimeMillis() - Constants.A_YEAR);
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip WHERE 1 = 1");
                        sqlQuery.append(" AND ip.status = :status");
                        sqlQuery.append(" AND (ip.produceDate <= :warningDate OR ip.importDate <= :warningDate)");
                        if(warehouseID != null){
                            sqlQuery.append(" AND ip.warehouse.warehouseID = :warehouseID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        query.setParameter("warningDate", warningDate);
                        query.setParameter("status", Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findByWarehouse(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip WHERE 1 = 1");
                        if(warehouseID != null){
                            sqlQuery.append(" AND ip.warehouse.warehouseID = :warehouseID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> summarySoldProducts(final ReportBean bean) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer whereClause = new StringBuffer();

                        Long userID = bean.getUserID() != null && bean.getUserID() > 0 ? bean.getUserID() : null;
                        Long customerID = bean.getCustomerID() != null && bean.getCustomerID() > 0 ? bean.getCustomerID() : null;
                        Long productNameID = bean.getProductNameID() != null && bean.getProductNameID() > 0 ? bean.getProductNameID() : null;
                        Long colourID = bean.getColourID() != null && bean.getColourID() > 0 ? bean.getColourID() : null;
                        Long sizeID = bean.getSizeID() != null && bean.getSizeID() > 0 ? bean.getSizeID() : null;
                        Date fromDate = bean.getFromDate() != null && bean.getFromDate() != null ? bean.getFromDate() : null;
                        Date toDate = bean.getToDate()  != null && bean.getToDate() != null ? bean.getToDate() : null;
                        Long thicknessID = bean.getThicknessID() != null && bean.getThicknessID() != null && bean.getThicknessID() > 0  ? bean.getThicknessID() : null;
                        Long stiffnessID = bean.getStiffnessID() != null && bean.getStiffnessID() != null && bean.getStiffnessID() > 0  ? bean.getStiffnessID() : null;
                        Long overlayTypeID = bean.getOverlayTypeID() != null && bean.getOverlayTypeID() != null && bean.getOverlayTypeID() > 0  ? bean.getOverlayTypeID() : null;

                        if(productNameID != null){
                            whereClause.append(" AND ep.importproduct.productname.productNameID = :productNameID");
                        }

                        if(sizeID != null){
                            whereClause.append(" AND ep.importproduct.size.sizeID = :sizeID");
                        }
                        if(thicknessID != null){
                            whereClause.append(" AND ep.importproduct.thickness.thicknessID = :thicknessID");
                        }
                        if(stiffnessID != null){
                            whereClause.append(" AND ep.importproduct.stiffness.stiffnessID = :stiffnessID");
                        }
                        if(colourID != null){
                            whereClause.append(" AND ep.importproduct.colour.colourID = :colourID");
                        }
                        if(overlayTypeID != null){
                            whereClause.append(" AND ep.importproduct.overlaytype.overlayTypeID = :overlayTypeID");
                        }
                        if(fromDate != null){
                            whereClause.append(" AND ep.exportproductbill.exportDate >= :fromDate");
                        }
                        if(toDate != null){
                            whereClause.append(" AND ep.exportproductbill.exportDate <= :toDate");
                        }
                        if(customerID != null){
                            whereClause.append(" AND ep.exportproductbill.customer.customerID = :customerID");
                        }
                        if(userID != null){
                            whereClause.append(" AND ep.exportproductbill.customer.customerID IN (")
                                    .append(" SELECT uc.customer.customerID FROM UserCustomer uc WHERE uc.user.userID = :userID)");
                        }

                        StringBuffer tailerQuery = new StringBuffer();
                        tailerQuery.append(" ORDER BY ep.exportproductbill.exportDate DESC");

                        StringBuffer sql = new StringBuffer("SELECT ep.importproduct FROM Exportproduct ep WHERE ep.exportproductbill.status = :status");
                        sql.append(" AND ep.exportproductbill.exporttype.code = :soldCode");
                        sql.append(whereClause);
                        sql.append(tailerQuery);

                        Query query = session.createQuery(sql.toString());
                        query.setParameter("status", Constants.CONFIRMED);
                        query.setParameter("soldCode", Constants.EXPORT_TYPE_BAN);

                        if(productNameID !=null){
                            query.setParameter("productNameID", productNameID);
                        }
                        if(sizeID !=null){
                            query.setParameter("sizeID", sizeID);
                        }
                        if(thicknessID !=null){
                            query.setParameter("thicknessID", thicknessID);
                        }
                        if(stiffnessID !=null){
                            query.setParameter("stiffnessID", stiffnessID);
                        }
                        if(colourID !=null){
                            query.setParameter("colourID", colourID);
                        }
                        if(overlayTypeID !=null){
                            query.setParameter("overlayTypeID", overlayTypeID);
                        }

                        if(fromDate !=null){
                            query.setParameter("fromDate", fromDate);
                        }
                        if(toDate !=null){
                            query.setParameter("toDate", toDate);
                        }
                        if(customerID !=null){
                            query.setParameter("customerID", customerID);
                        }
                        if(userID !=null){
                            query.setParameter("userID", userID);
                        }
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findImportByPlan(final Long productionPlanID,final String produceGroup) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ip.importproductbill.productionPlan.productionPlanID = :productionPlanID")
                                .append(" AND ip.importproductbill.status = :confirmed")
                                .append(" AND ip.importproductbill.produceGroup = :produceGroup")
                                .append(" ORDER BY cast(substring(ip.productCode,5,8) AS int) ASC");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("productionPlanID", productionPlanID);
                        query.setParameter("confirmed", Constants.CONFIRMED);
                        query.setParameter("produceGroup", produceGroup);
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findImportBackByOriginalProducts(final List<Long> importProductIDs) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ip.originalProduct.importProductID IN (:importProductIDs)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("importProductIDs", importProductIDs);
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Object> summarySellReport(final ReportBean bean,final List<Long> customerIds) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Object>>() {
                    public List<Object> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer whereClause = new StringBuffer();

                        Long userID = bean.getUserID() != null && bean.getUserID() > 0 ? bean.getUserID() : null;
                        Long customerID = bean.getCustomerID() != null && bean.getCustomerID() > 0 ? bean.getCustomerID() : null;
                        Long productNameID = bean.getProductNameID() != null && bean.getProductNameID() > 0 ? bean.getProductNameID() : null;
                        Long colourID = bean.getColourID() != null && bean.getColourID() > 0 ? bean.getColourID() : null;
                        Long sizeID = bean.getSizeID() != null && bean.getSizeID() > 0 ? bean.getSizeID() : null;
                        Date fromDate = bean.getFromDate() != null && bean.getFromDate() != null ? bean.getFromDate() : null;
                        Date toDate = bean.getToDate()  != null && bean.getToDate() != null ? bean.getToDate() : null;
                        Long thicknessID = bean.getThicknessID() != null && bean.getThicknessID() != null && bean.getThicknessID() > 0  ? bean.getThicknessID() : null;
                        Long stiffnessID = bean.getStiffnessID() != null && bean.getStiffnessID() != null && bean.getStiffnessID() > 0  ? bean.getStiffnessID() : null;
                        Long overlayTypeID = bean.getOverlayTypeID() != null && bean.getOverlayTypeID() != null && bean.getOverlayTypeID() > 0  ? bean.getOverlayTypeID() : null;

                        if(productNameID != null){
                            whereClause.append(" AND ep.importproduct.productname.productNameID = :productNameID");
                        }

                        if(sizeID != null){
                            whereClause.append(" AND ep.importproduct.size.sizeID = :sizeID");
                        }
                        if(thicknessID != null){
                            whereClause.append(" AND ep.importproduct.thickness.thicknessID = :thicknessID");
                        }
                        if(stiffnessID != null){
                            whereClause.append(" AND ep.importproduct.stiffness.stiffnessID = :stiffnessID");
                        }
                        if(colourID != null){
                            whereClause.append(" AND ep.importproduct.colour.colourID = :colourID");
                        }
                        if(overlayTypeID != null){
                            whereClause.append(" AND ep.importproduct.overlaytype.overlayTypeID = :overlayTypeID");
                        }
                        if(fromDate != null){
                            whereClause.append(" AND ep.exportproductbill.exportDate >= :fromDate");
                        }
                        if(toDate != null){
                            whereClause.append(" AND ep.exportproductbill.exportDate <= :toDate");
                        }
                        if(customerID != null){
                            whereClause.append(" AND ep.exportproductbill.customer.customerID = :customerID");
                        }
                        if(userID != null){
                            whereClause.append(" AND ep.exportproductbill.customer.customerID IN (")
                                    .append(" SELECT uc.customer.customerID FROM UserCustomer uc WHERE uc.user.userID = :userID)");
                        }

                        if(customerIds !=  null){
                            whereClause.append(" AND ep.exportproductbill.customer.customerID IN (:customerIds)");
                        }

                        StringBuffer tailerQuery = new StringBuffer();
                        tailerQuery.append(" ORDER BY ep.exportproductbill.exportDate DESC");

                        StringBuffer sql = new StringBuffer("SELECT ep.importproduct as importProduct, ep.exportproductbill.customer as customer FROM Exportproduct ep WHERE ep.exportproductbill.status = :status");
                        sql.append(" AND ep.exportproductbill.exporttype.code = :soldCode");
                        sql.append(whereClause);
                        sql.append(tailerQuery);

                        Query query = session.createQuery(sql.toString());
                        query.setParameter("status", Constants.CONFIRMED);
                        query.setParameter("soldCode", Constants.EXPORT_TYPE_BAN);


                        if(productNameID !=null){
                            query.setParameter("productNameID", productNameID);
                        }
                        if(sizeID !=null){
                            query.setParameter("sizeID", sizeID);
                        }
                        if(thicknessID !=null){
                            query.setParameter("thicknessID", thicknessID);
                        }
                        if(stiffnessID !=null){
                            query.setParameter("stiffnessID", stiffnessID);
                        }
                        if(colourID !=null){
                            query.setParameter("colourID", colourID);
                        }
                        if(overlayTypeID !=null){
                            query.setParameter("overlayTypeID", overlayTypeID);
                        }

                        if(fromDate !=null){
                            query.setParameter("fromDate", fromDate);
                        }
                        if(toDate !=null){
                            query.setParameter("toDate", toDate);
                        }
                        if(customerID !=null){
                            query.setParameter("customerID", customerID);
                        }
                        if(userID !=null){
                            query.setParameter("userID", userID);
                        }
                        if(customerIds !=  null){
                            query.setParameterList("customerIds", customerIds);
                        }
                        return (List<Object>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findByCodes(final List<String> productCodes) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip ");
                        sqlQuery.append(" WHERE 1 = 1")
                                .append(" AND ip.productCode IN (:productCodes)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameterList("productCodes", productCodes);
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findNotInWarehouse(final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip WHERE 1 = 1");
                        if(warehouseID != null){
                            sqlQuery.append(" AND ip.warehouse.warehouseID <> :warehouseID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public void changeBillofProducts(final List<Long> productIDs,final Importproductbill finalBill) {
        getHibernateTemplate().execute(
                new HibernateCallback<Object>() {
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sQuery = new StringBuffer("UPDATE importproduct i SET ImportProductBillID = :finalBillID");
                        sQuery.append(" WHERE i.importProductID IN (:productIDs)");
                        SQLQuery query = session.createSQLQuery(sQuery.toString());
                        query.setParameterList("productIDs", productIDs);
                        query.setParameter("finalBillID", finalBill.getImportProductBillID());
                        return query.executeUpdate();
                    }
                });
    }

    @Override
    public List<Importproduct> findImportedProduct(final Date fromDate, final Date toDate, final Long productNameID, final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Importproduct ip WHERE 1 = 1");
                        if(warehouseID != null){
                            sqlQuery.append(" AND ip.importproductbill.warehouse.warehouseID = :warehouseID");
                        }
                        if(fromDate != null){
                            sqlQuery.append(" AND ip.importproductbill.importDate >= :fromDate");
                        }
                        if(toDate != null){
                            sqlQuery.append(" AND ip.importproductbill.importDate <= :toDate");
                        }
                        if(productNameID != null){
                            sqlQuery.append(" AND ip.productname.productNameID = :productNameID");
                        }
                        sqlQuery.append(" AND ip.importproductbill.status = :status");

                        Query query = session.createQuery(sqlQuery.toString());
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        if(fromDate != null){
                            query.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                            query.setParameter("toDate", toDate);
                        }
                        if(productNameID != null){
                            query.setParameter("productNameID", productNameID);
                        }
                        query.setParameter("status", Constants.CONFIRMED);

                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findExportedProduct(final Date fromDate, final Date toDate, final Long productNameID, final Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("Select ep.importproduct FROM Exportproduct ep WHERE 1 = 1");
                        if(warehouseID != null){
                            sqlQuery.append(" AND ep.exportproductbill.exportWarehouse.warehouseID = :warehouseID");
                        }
                        if(fromDate != null){
                            sqlQuery.append(" AND ep.exportproductbill.exportDate >= :fromDate");
                        }
                        if(toDate != null){
                            sqlQuery.append(" AND ep.exportproductbill.exportDate <= :toDate");
                        }
                        if(productNameID != null){
                            sqlQuery.append(" AND ep.importproduct.productname.productNameID = :productNameID");
                        }
                        sqlQuery.append(" AND ep.exportproductbill.status IN (:status)");

                        Query query = session.createQuery(sqlQuery.toString());
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        if(fromDate != null){
                            query.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                            query.setParameter("toDate", toDate);
                        }
                        if(productNameID != null){
                            query.setParameter("productNameID", productNameID);
                        }
                        List<Integer> status = new ArrayList<Integer>();
                        status.add(Constants.CONFIRMED);
                        status.add(Constants.CONFIRMED_TRANSFER);
                        query.setParameterList("status", status);


                        return (List<Importproduct>) query.list();
                    }
                });
    }

    @Override
    public List<Importproduct> findInternalImportedProduct(final Date fromDate,final  Date toDate,final  Long productNameID,final  Long warehouseID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("Select ep.importproduct FROM Exportproduct ep WHERE 1 = 1");
                        if(warehouseID != null){
                            sqlQuery.append(" AND ep.exportproductbill.receiveWarehouse.warehouseID = :warehouseID");
                        }
                        if(fromDate != null){
                            sqlQuery.append(" AND ep.exportproductbill.exportDate >= :fromDate");
                        }
                        if(toDate != null){
                            sqlQuery.append(" AND ep.exportproductbill.exportDate <= :toDate");
                        }
                        if(productNameID != null){
                            sqlQuery.append(" AND ep.importproduct.productname.productNameID = :productNameID");
                        }
                        sqlQuery.append(" AND ep.exportproductbill.status = :status");

                        Query query = session.createQuery(sqlQuery.toString());
                        if(warehouseID != null){
                            query.setParameter("warehouseID", warehouseID);
                        }
                        if(fromDate != null){
                            query.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                            query.setParameter("toDate", toDate);
                        }
                        if(productNameID != null){
                            query.setParameter("productNameID", productNameID);
                        }
                        query.setParameter("status", Constants.CONFIRMED_TRANSFER);


                        return (List<Importproduct>) query.list();
                    }
                });
    }
}
