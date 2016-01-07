package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Market;
import com.banvien.tpk.core.dto.MarketBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface MarketService extends GenericService<Market,Long> {

    void updateItem(MarketBean MarketBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(MarketBean MarketBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(MarketBean bean);
}