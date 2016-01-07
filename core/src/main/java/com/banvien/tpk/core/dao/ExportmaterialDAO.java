package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Exportmaterial;
import com.banvien.tpk.core.dto.ExportMaterialReportBean;
import com.banvien.tpk.core.dto.ExportMaterialReportDetailDTO;
import com.banvien.tpk.core.dto.SearchUsedMaterialBean;
import com.banvien.tpk.core.dto.UsedMaterialDTO;

import java.util.List;

/**
 * <p>Generic DAO layer for Exportmaterials</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface ExportmaterialDAO extends GenericDAO<Exportmaterial,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildExportmaterialDAO()
	 */
	  	 
	/**
	 * Find Exportmaterial by exportMaterialBillID
	 */
	public List<Exportmaterial> findByExportMaterialBillID(Long exportMaterialBillID);

	/**
	 * Find Exportmaterial by materialID
	 */
	public List<Exportmaterial> findByMaterialID(Long materialID);

	/**
	 * Find Exportmaterial by unit1ID
	 */
	public List<Exportmaterial> findByUnit1ID(Long unit1ID);

	/**
	 * Find Exportmaterial by quantity1
	 */
	public List<Exportmaterial> findByQuantity1(Double quantity1);

	/**
	 * Find Exportmaterial by unit2ID
	 */
	public List<Exportmaterial> findByUnit2ID(Long unit2ID);

	/**
	 * Find Exportmaterial by quantity2
	 */
	public List<Exportmaterial> findByQuantity2(Double quantity2);

	/**
	 * Find Exportmaterial by note
	 */
	public List<Exportmaterial> findByNote(String note);

    List<UsedMaterialDTO> findExportMaterial(SearchUsedMaterialBean bean);

    List<Exportmaterial> findByProductionPlanIDs(List<Long> productionPlanIDs);

    List<Exportmaterial> findExportByPlan(Long productionPlanID);

	List<ExportMaterialReportDetailDTO> findAllExportUtilDate(ExportMaterialReportBean bean);

	List<ExportMaterialReportDetailDTO> findAllExportDuringDate(ExportMaterialReportBean bean);
}