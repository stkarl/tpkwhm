package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.Importproductbill;
import com.banvien.tpk.core.dto.ProducedProductBean;
import com.banvien.tpk.core.dto.ReportBean;
import com.banvien.tpk.core.dto.SearchProductBean;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * <p>Generic DAO layer for Importproducts</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ImportproductDAO extends GenericDAO<Importproduct,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildImportproductDAO()
	 */
	  	 
	/**
	 * Find Importproduct by importProductBillID
	 */
	public List<Importproduct> findByImportProductBillID(Long importProductBillID);

	/**
	 * Find Importproduct by productID
	 */
	public List<Importproduct> findByProductID(Long productID);

	/**
	 * Find Importproduct by productCode
	 */
	public List<Importproduct> findByProductCode(String productCode);

	/**
	 * Find Importproduct by originID
	 */
	public List<Importproduct> findByOriginID(Long originID);

	/**
	 * Find Importproduct by produceDate
	 */
	public List<Importproduct> findByProduceDate(Timestamp produceDate);

	/**
	 * Find Importproduct by mainUsedMaterialID
	 */
	public List<Importproduct> findByMainUsedMaterialID(Long mainUsedMaterialID);

	/**
	 * Find Importproduct by mainUsedMaterialCode
	 */
	public List<Importproduct> findByMainUsedMaterialCode(String mainUsedMaterialCode);

	/**
	 * Find Importproduct by mainUsedProductID
	 */
	public List<Importproduct> findByMainUsedProductID(Long mainUsedProductID);

	/**
	 * Find Importproduct by mainUsedProductCode
	 */
	public List<Importproduct> findByMainUsedProductCode(String mainUsedProductCode);

	/**
	 * Find Importproduct by note
	 */
	public List<Importproduct> findByNote(String note);

	/**
	 * Find Importproduct by unit1ID
	 */
	public List<Importproduct> findByUnit1ID(Long unit1ID);

	/**
	 * Find Importproduct by quantity1
	 */
	public List<Importproduct> findByQuantity1(Double quantity1);

	/**
	 * Find Importproduct by unit2ID
	 */
	public List<Importproduct> findByUnit2ID(Long unit2ID);

	/**
	 * Find Importproduct by quantity2
	 */
	public List<Importproduct> findByQuantity2(Double quantity2);

	/**
	 * Find Importproduct by money
	 */
	public List<Importproduct> findByMoney(Double money);

	/**
	 * Find Importproduct by marketID
	 */
	public List<Importproduct> findByMarketID(Long marketID);

    List<Importproduct> findAvailableBlackProductByWarehouse(Long warehouseID);

    List<Importproduct> findAvailableNoneBlackProductByWarehouse(Long warehouseID);


    List<Importproduct> findTempSelectedBlackProductByWarehouseAndCodes(Long warehouseID, List<String> tempSelectedCodes);

    void updateDragBackProducts(Long exportWarehouseID, List<Long> dragBackProducts,Integer status);

    Object[] searchProductsInStock(SearchProductBean bean);

    List<Importproduct> findImportProduct(ProducedProductBean bean);

    List<Importproduct> findByProductionPlanIDs(List<Long> productionPlanIDs);

    List<Object[]> findProductionTimesByPlans(List<Long> productionPlanIDs);

    List<Importproduct> findByIDs(List<Long> productIDs);

    void updateStatus(List<Long> bookedProductIDs, Integer status);

    void updateStatusByCodes(List<String> codes, Integer rootMaterialStatusUsed);

    List<Importproduct> findWarningProduct(Long warehouseID);

    List<Importproduct> findByWarehouse(Long warehouseID);

    List<Importproduct> summarySoldProducts(ReportBean bean);

    List<Importproduct> findImportByPlan(Long productionPlanID,String importType);

    List<Importproduct> findImportBackByOriginalProducts(List<Long> dbMainUsedMaterialIDs);

    List<Object> summarySellReport(ReportBean bean, List<Long> customerIds);

    List<Importproduct> findByCodes(List<String> productCodes);

    List<Importproduct> findNotInWarehouse(Long warehouseID);

    void changeBillofProducts(List<Long> productIDs, Importproductbill finalBill);

    List<Importproduct> findImportedProduct(Date fromDate, Date toDate, Long productNameID, Long warehouseID);

    List<Importproduct> findExportedProduct(Date fromDate, Date toDate, Long productNameID, Long warehouseID);

    List<Importproduct> findInternalImportedProduct(Date fromDate, Date toDate, Long productNameID, Long warehouseID);
}