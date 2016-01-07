package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.MaterialAndCategory;

import java.util.List;

public interface MaterialAndCategoryDAO extends GenericDAO<MaterialAndCategory,Long> {

    List<MaterialAndCategory> findByMaterialID(Long materialID);
}