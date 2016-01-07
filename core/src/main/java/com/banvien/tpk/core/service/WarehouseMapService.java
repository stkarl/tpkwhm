package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.WarehouseMap;
import com.banvien.tpk.core.dto.WarehouseMapBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface WarehouseMapService extends GenericService<WarehouseMap,Long> {

    void updateItem(WarehouseMapBean districtBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(WarehouseMapBean districtBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(WarehouseMapBean bean);

    List<WarehouseMap> findByWarehouseID(Long warehouseID);
}