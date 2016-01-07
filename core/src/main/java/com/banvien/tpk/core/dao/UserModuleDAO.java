package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.UserModule;

import java.util.List;

public interface UserModuleDAO extends GenericDAO<UserModule,Long> {

    List<UserModule> findByUserID(Long userID);
}