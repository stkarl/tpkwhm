package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Overlaytype;
import com.banvien.tpk.core.dto.OverlaytypeBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface OverlaytypeService extends GenericService<Overlaytype,Long> {

    void updateItem(OverlaytypeBean OverlaytypeBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(OverlaytypeBean OverlaytypeBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(OverlaytypeBean bean);
}