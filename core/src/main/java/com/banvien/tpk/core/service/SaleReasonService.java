package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.SaleReason;
import com.banvien.tpk.core.dto.SaleReasonBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface SaleReasonService extends GenericService<SaleReason,Long> {

    void updateItem(SaleReasonBean SaleReasonBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(SaleReasonBean SaleReasonBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(SaleReasonBean bean);

    List<SaleReason> findAllByOrder();
}