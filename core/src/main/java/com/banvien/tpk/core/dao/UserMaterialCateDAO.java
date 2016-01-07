package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.UserMaterialCate;

import java.util.List;

public interface UserMaterialCateDAO extends GenericDAO<UserMaterialCate,Long> {

    List<UserMaterialCate> findByUserID(Long userID);
}