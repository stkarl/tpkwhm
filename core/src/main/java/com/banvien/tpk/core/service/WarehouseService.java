package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.WarehouseBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface WarehouseService extends GenericService<Warehouse,Long> {

    void updateItem(WarehouseBean WarehouseBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(WarehouseBean WarehouseBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(WarehouseBean bean);

    List<Warehouse> findAllActiveWarehouseExcludeID(Long excludeID);

    List<Warehouse> findByStatus(Integer tpkUserActive);
}