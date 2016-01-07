package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Product;
import com.banvien.tpk.core.dto.ProductBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface ProductService extends GenericService<Product,Long> {

    void updateItem(ProductBean ProductBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ProductBean ProductBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ProductBean bean);
}