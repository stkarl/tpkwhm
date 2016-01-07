package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.PriceBank;
import com.banvien.tpk.core.dto.PriceBankBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

public interface PriceBankService extends GenericService<PriceBank,Long> {

    void updateItem(PriceBankBean bean) throws ObjectNotFoundException, DuplicateException;

    void addNew(PriceBankBean bean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(PriceBankBean bean);
}