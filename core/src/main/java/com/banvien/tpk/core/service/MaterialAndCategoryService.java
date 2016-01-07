package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.MaterialAndCategory;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;

public interface MaterialAndCategoryService extends GenericService<MaterialAndCategory,Long> {
    Integer deleteItems(String[] checkList);

    void deleteItem(Long materialAndCategoryID) throws ObjectNotFoundException;

    List<MaterialAndCategory> findByMaterialID(Long userID);

}