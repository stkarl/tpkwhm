package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.BookProduct;
import com.banvien.tpk.core.domain.Importproduct;

import java.util.List;

public interface BookProductDAO extends GenericDAO<BookProduct,Long> {
	public List<BookProduct> findByBookProductBillID(Long exportProductBillID);

    List<Importproduct> findProductInBookBill(Long bookProductBillID);
}