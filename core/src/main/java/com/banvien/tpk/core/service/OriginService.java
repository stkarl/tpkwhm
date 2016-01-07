package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Origin;
import com.banvien.tpk.core.dto.OriginBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface OriginService extends GenericService<Origin,Long> {

    void updateItem(OriginBean OriginBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(OriginBean OriginBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(OriginBean bean);
}