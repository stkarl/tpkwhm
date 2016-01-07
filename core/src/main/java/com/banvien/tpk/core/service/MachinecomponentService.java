package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Machinecomponent;
import com.banvien.tpk.core.dto.MachinecomponentBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface MachinecomponentService extends GenericService<Machinecomponent,Long> {

    void updateItem(MachinecomponentBean MachinecomponentBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(MachinecomponentBean MachinecomponentBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(MachinecomponentBean bean);

    List<Machinecomponent> findByMachineAndWarehouse(Long machineID, Long warehouseID);

    List<Machinecomponent> findWarningComponent(Long warehouseID);

    Machinecomponent updateItemAjax(Long componentID, String componentName, String componentCode, String componentDescription) throws Exception;

    void addDuplicateComponent(Long componentID, Integer numberOfComponent);

    void addMaintainDetail(Long loginUserId, Long componentID, String componentDate, Integer componentNoDay, String maintainDes, Integer status);

    void addMaintainMachineDetail(Long loginUserId, Long machineID, String machineDate, Integer machineNoDay, String maintainDes, Integer status);

    List<Machinecomponent> findAllActiveComponentByWarehouse(Long warehouseID);
}