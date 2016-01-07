package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.BookProductBill;

import java.sql.Timestamp;
import java.util.List;

/**
 * <p>Generic DAO layer for BookProductBills</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface BookProductBillDAO extends GenericDAO<BookProductBill,Long> {
	public List<BookProductBill> findByCustomerID(Long customerID);
	public List<BookProductBill> findByCreatedBy(Long createdBy);
	public List<BookProductBill> findByStatus(Integer status);

    BookProductBill findWaitingBillByUserCustomerAndDate(Long loginUserId, Long customerID,Timestamp deliveryDate );

    String getLatestBookBillNumber();

}