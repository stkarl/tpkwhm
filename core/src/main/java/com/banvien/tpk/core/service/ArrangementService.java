package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Arrangement;
import com.banvien.tpk.core.dto.ArrangementBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface ArrangementService extends GenericService<Arrangement,Long> {

    void updateItem(ArrangementBean ArrangementBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ArrangementBean ArrangementBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ArrangementBean bean);
}