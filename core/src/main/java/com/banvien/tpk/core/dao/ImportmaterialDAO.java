package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Importmaterial;
import com.banvien.tpk.core.dto.ExportMaterialReportBean;
import com.banvien.tpk.core.dto.ExportMaterialReportDetailDTO;
import com.banvien.tpk.core.dto.SearchMaterialBean;

import java.sql.Timestamp;
import java.util.List;

/**
 * <p>Generic DAO layer for Importmaterials</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ImportmaterialDAO extends GenericDAO<Importmaterial,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildImportmaterialDAO()
	 */
	  	 
	/**
	 * Find Importmaterial by importMaterialBillID
	 */
	public List<Importmaterial> findByImportMaterialBillID(Long importMaterialBillID);

	/**
	 * Find Importmaterial by materialID
	 */
	public List<Importmaterial> findByMaterialID(Long materialID);

	/**
	 * Find Importmaterial by originID
	 */
	public List<Importmaterial> findByOriginID(Long originID);

	/**
	 * Find Importmaterial by expiredDate
	 */
	public List<Importmaterial> findByExpiredDate(Timestamp expiredDate);

	/**
	 * Find Importmaterial by unit1ID
	 */
	public List<Importmaterial> findByUnit1ID(Long unit1ID);

	/**
	 * Find Importmaterial by quantity1
	 */
	public List<Importmaterial> findByQuantity1(Double quantity1);

	/**
	 * Find Importmaterial by unit2ID
	 */
	public List<Importmaterial> findByUnit2ID(Long unit2ID);

	/**
	 * Find Importmaterial by quantity2
	 */
	public List<Importmaterial> findByQuantity2(Double quantity2);

	/**
	 * Find Importmaterial by money
	 */
	public List<Importmaterial> findByMoney(Double money);

	/**
	 * Find Importmaterial by note
	 */
	public List<Importmaterial> findByNote(String note);

	/**
	 * Find Importmaterial by marketID
	 */
	public List<Importmaterial> findByMarketID(Long marketID);

    List<Importmaterial> findAvailableMaterialByWarehouse(Long warehouseID);


    Object[] searchMaterialsInStock(SearchMaterialBean bean);

    List<Importmaterial> findWarningMaterial(Long warehouseID);

	List<ExportMaterialReportDetailDTO> findAllInitialMaterial(ExportMaterialReportBean bean);

	List<ExportMaterialReportDetailDTO> findAllImportDuringDate(ExportMaterialReportBean bean);
}