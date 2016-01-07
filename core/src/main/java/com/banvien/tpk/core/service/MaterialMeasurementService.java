package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.MaterialMeasurement;
import com.banvien.tpk.core.dto.MaterialMeasurementBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;
import java.util.Map;


public interface MaterialMeasurementService extends GenericService<MaterialMeasurement,Long> {

    void updateItem(MaterialMeasurementBean MaterialMeasurementBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(MaterialMeasurementBean MaterialMeasurementBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    List<MaterialMeasurement> findPreviousMaterialValue(Long warehouseID);

    Object[] search(MaterialMeasurementBean bean);
}