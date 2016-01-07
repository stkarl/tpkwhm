package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.UserModule;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;

public interface UserModuleService extends GenericService<UserModule,Long> {
    Integer deleteItems(String[] checkList);

    void deleteItem(Long userModuleID) throws ObjectNotFoundException;

    List<UserModule> findByUserID(Long userID);

    List<UserModule> updateAssignedModule(Long userID, List<Long> customerIDs);

}