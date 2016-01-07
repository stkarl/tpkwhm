package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Exportproduct;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.dto.ExportproductBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.Date;
import java.util.List;


public interface ExportproductService extends GenericService<Exportproduct,Long> {

    void updateItem(ExportproductBean exportproductBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ExportproductBean exportproductBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);
    
    List<Exportproduct> findAllSortAsc();

    Object[] search(ExportproductBean bean);

    List<Importproduct> findProductByProductionPlan(Long productionPlanID);

    List<Importproduct> findExportByPlan(Long productionPlanID);

    Double findTotalExportBlackProduct4ProductionByDate(Date fromDate, Date toDate);

    Boolean updateBringProductBack(Long productid, Long exportid);

//    List<Exportproduct> findAvailableBlackProductByWarehouse(Long warehouseID);
//
//    List<Exportproduct> findTempSelectedBlackProductByWarehouseAndCodes(Long warehouseID, List<String> tempSelectedCodes);
//
//    Object[] searchProductsInStock(SearchProductBean bean);
}