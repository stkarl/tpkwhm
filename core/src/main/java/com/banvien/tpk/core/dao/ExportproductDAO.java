package com.banvien.tpk.core.dao;

import java.util.Date;
import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.Exportproduct;
import com.banvien.tpk.core.domain.Exporttype;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.dto.SearchUsedMaterialBean;
import com.banvien.tpk.core.dto.UsedMaterialDTO;

/**
 * <p>Generic DAO layer for Exportproducts</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ExportproductDAO extends GenericDAO<Exportproduct,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildExportproductDAO()
	 */
	  	 
	/**
	 * Find Exportproduct by exportProductBillID
	 */
	public List<Exportproduct> findByExportProductBillID(Long exportProductBillID);

	/**
	 * Find Exportproduct by productNameID
	 */
	public List<Exportproduct> findByProductNameID(Long productNameID);

	/**
	 * Find Exportproduct by productCode
	 */
	public List<Exportproduct> findByProductCode(String productCode);

	/**
	 * Find Exportproduct by originID
	 */
	public List<Exportproduct> findByOriginID(Long originID);

	/**
	 * Find Exportproduct by classifyCode
	 */
	public List<Exportproduct> findByClassifyCode(String classifyCode);

	/**
	 * Find Exportproduct by unit1ID
	 */
	public List<Exportproduct> findByUnit1ID(Long unit1ID);

	/**
	 * Find Exportproduct by quantity1
	 */
	public List<Exportproduct> findByQuantity1(Double quantity1);

	/**
	 * Find Exportproduct by unit2ID
	 */
	public List<Exportproduct> findByUnit2ID(Long unit2ID);

	/**
	 * Find Exportproduct by quantity2
	 */
	public List<Exportproduct> findByQuantity2(Double quantity2);

	/**
	 * Find Exportproduct by note
	 */
	public List<Exportproduct> findByNote(String note);

	/**
	 * Find Exportproduct by money
	 */
	public List<Exportproduct> findByMoney(Double money);

    List<Importproduct> findProductByProductionPlan(Long productionPlanID);

    List<UsedMaterialDTO> findExportProduct4Production(SearchUsedMaterialBean bean);

    List<Object[]> findProductionTimesByPlans(List<Long> productionPlanIDs);

    List<Importproduct> findExportByPlan(Long productionPlanID);

    List<Exportproduct> findByProductIds(List<Long> ids);

    List<Exportproduct> findExportProductsByPlans(List<Long> productionPlanIDs);

    Double findTotalExportBlackProduct4ProductionByDate(Date fromDate, Date toDate);
}