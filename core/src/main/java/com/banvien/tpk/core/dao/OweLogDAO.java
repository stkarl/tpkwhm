package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.OweLog;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>Generic DAO layer for OweLogs</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface OweLogDAO extends GenericDAO<OweLog,Long> {
    List<Object> findCustomerInitialOwe(List<Long> customerIds, Date beforeDate);

    List<OweLog> findCustomerPaid(List<Long> customerIds, Date fromDate, Date toDate);

    List<OweLog> findCustomerMoneyBought(List<Long> customerIds, Date fromDate, Date toDate);

    List<Object> findCustomerDueDate(List<Long> customerIds, Date toDate);

    OweLog findOweByBookBill(Long bookProductBillID);

    List<OweLog> findPrePaidByBill(Long bookProductBillID);

    Double findCustomerOweUtilDate(Long customerID, Date date);

    Map<Long,Double> findCustomersOweUtilDate(List<Long> customerIDs, Timestamp date);
}