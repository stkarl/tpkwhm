package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Shift;
import com.banvien.tpk.core.dto.ShiftBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface ShiftService extends GenericService<Shift,Long> {

    void updateItem(ShiftBean ShiftBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ShiftBean ShiftBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ShiftBean bean);
}