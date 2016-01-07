package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Exportmaterial;
import com.banvien.tpk.core.domain.Importmaterial;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface ExportmaterialService extends GenericService<Exportmaterial,Long> {

    void updateItem(ExportmaterialBean exportmaterialBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ExportmaterialBean exportmaterialBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ExportmaterialBean bean);

    SummaryUsedMaterialDTO reportUsedMaterial(SearchUsedMaterialBean bean);

    Object[] reportProductionCost(SearchProductionCostBean bean);

    List<Exportmaterial> findExportByPlan(Long productionPlanID);
}