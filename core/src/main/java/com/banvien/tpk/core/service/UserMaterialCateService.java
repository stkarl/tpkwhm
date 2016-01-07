package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.UserMaterialCate;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;

public interface UserMaterialCateService extends GenericService<UserMaterialCate,Long> {
    Integer deleteItems(String[] checkList);

    void deleteItem(Long userMaterialCateID) throws ObjectNotFoundException;

    List<UserMaterialCate> findByUserID(Long userID);

    List<UserMaterialCate> updateAssignedMaterialCate(Long userID, List<Long> customerIDs);

}