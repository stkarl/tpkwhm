package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.UserCustomer;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;

public interface UserCustomerService extends GenericService<UserCustomer,Long> {
    Integer deleteItems(String[] checkList);

    void deleteItem(Long userCustomerID) throws ObjectNotFoundException;

    List<UserCustomer> findByUserID(Long userID);

    List<UserCustomer> updateAssignedCustomer(Long userID, List<Long> customerIDs);

    List<UserCustomer> addAssignedCustomer(Long userID, List<Long> customerIDs);
}