package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Size;
import com.banvien.tpk.core.dto.SizeBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface SizeService extends GenericService<Size,Long> {

    void updateItem(SizeBean SizeBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(SizeBean SizeBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(SizeBean bean);

    List<Size> findAllByOrder(String order);

}