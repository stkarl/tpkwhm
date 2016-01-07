package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Machine;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.MachineBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface MachineService extends GenericService<Machine,Long> {

    void updateItem(MachineBean MachineBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(MachineBean MachineBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(MachineBean bean);

    List<Machine> findAllActiveMachineByWarehouse(Long warehouseID);

    List<Machine> findWarningMachine(Long warehouseID);

    void updateSubmitMachineForConfirm(Long loginUserId, Long machineID, Integer status);
}