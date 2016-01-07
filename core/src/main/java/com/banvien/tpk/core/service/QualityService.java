package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Quality;
import com.banvien.tpk.core.dto.QualityBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface QualityService extends GenericService<Quality,Long> {

    void updateItem(QualityBean QualityBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(QualityBean QualityBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(QualityBean bean);

    List<Quality> findNonePPByOrder(String order);
}