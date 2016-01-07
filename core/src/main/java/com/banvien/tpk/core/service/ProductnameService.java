package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Productname;
import com.banvien.tpk.core.dto.ProductnameBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface ProductnameService extends GenericService<Productname,Long> {

    void updateItem(ProductnameBean ProductnameBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ProductnameBean ProductnameBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ProductnameBean bean);
}