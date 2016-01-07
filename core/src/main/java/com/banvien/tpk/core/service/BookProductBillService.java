package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.BookProductBill;
import com.banvien.tpk.core.dto.BookProductBillBean;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface BookProductBillService extends GenericService<BookProductBill,Long> {
    String saveOrUpdateBookingBill(List<Long> bookedProductIDs,Long loginID, Long billID) throws ObjectNotFoundException;

    Object[] search(BookProductBillBean bean);

    Integer deleteItems(String[] checkList);

    void updateBookProductBill(Long billID, Long customerID,Long loginID,String des) throws ObjectNotFoundException;

    void updateStatus(Long bookProductBillID, Integer confirmed, Long loginID);

    void updateReject(String note, Long bookProductBillID, Long loginUserId);

    void updateConfirm(Long bookProductBillID, Long loginUserId) throws ObjectNotFoundException;

    BookProductBill saveOrUpdateBillInfo(BookProductBillBean bean) throws Exception;

    String getLatestBookBillNumber();

    BookProductBill updatePrice(BookProductBillBean bean);
}