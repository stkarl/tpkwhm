package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.BookProduct;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

public interface BookProductService extends GenericService<BookProduct,Long> {
    Integer deleteItems(String[] checkList);

    void deleteItem(Long bookProductID) throws ObjectNotFoundException;
}