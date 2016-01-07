package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.InitProduct;

import java.util.Date;
import java.util.List;

/**
 * <p>Generic DAO layer for InitProducts</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface InitProductDAO extends GenericDAO<InitProduct,Long> {
    InitProduct findByDateAndWarehouse(Date fromDate, Long warehouseID);

    List<Importproduct> findByBillAndName(Long initProductID, Long productNameID);

}