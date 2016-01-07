package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.FixExpense;
import com.banvien.tpk.core.dto.FixExpenseBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface FixExpenseService extends GenericService<FixExpense,Long> {

    void updateItem(FixExpenseBean FixExpenseBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(FixExpenseBean FixExpenseBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(FixExpenseBean bean);

    List<FixExpense> findAllByOrder(String name);
}