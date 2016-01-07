package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.ProductionPlan;
import com.banvien.tpk.core.dto.ProductionPlanBean;

import java.util.List;
import java.util.Map;


public interface ProductionPlanService extends GenericService<ProductionPlan,Long> {

    void updateItem(ProductionPlanBean districtBean) throws Exception;

    void addNew(ProductionPlanBean districtBean) throws Exception;

    Integer deleteItems(String[] checkList);

    Object[] search(ProductionPlanBean bean);

    List<ProductionPlan> findByWarehouseID(Long warehouseID);


    Object[] searchActivePlan(ProductionPlanBean bean);

    List<ProductionPlan> findActivePlanByWarehouseAndType(Long warehouseID, String exportTypeCode);

    Map<Long,String> getProductionDetail(List<Long> planIds);
}