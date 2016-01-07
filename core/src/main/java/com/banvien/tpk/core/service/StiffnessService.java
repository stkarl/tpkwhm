package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Stiffness;
import com.banvien.tpk.core.dto.StiffnessBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface StiffnessService extends GenericService<Stiffness,Long> {

    void updateItem(StiffnessBean StiffnessBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(StiffnessBean StiffnessBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(StiffnessBean bean);
}