package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.OweLog;
import com.banvien.tpk.core.dto.OweLogBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;


public interface OweLogService extends GenericService<OweLog,Long> {

    void updateItem(OweLogBean OweLogBean) throws Exception;

    void addNew(OweLogBean OweLogBean) throws DuplicateException;

    Integer deleteItems(String[] checkList) throws ObjectNotFoundException;

    Object[] search(OweLogBean bean);

    Double findCustomerOweUtilDate(Long customerID, Date date);

    Map<Long,Double> findCustomersOweUtilDate(List<Long> customerIDs, Timestamp timestamp);

    List<OweLog> findPrePaidByBill(Long bookProductBillID);

}