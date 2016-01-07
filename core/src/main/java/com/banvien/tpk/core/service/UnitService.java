package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Unit;
import com.banvien.tpk.core.dto.UnitBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface UnitService extends GenericService<Unit,Long> {
	void updateItem(UnitBean unitBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(UnitBean unitBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(UnitBean bean);
}