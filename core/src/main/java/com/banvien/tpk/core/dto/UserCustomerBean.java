package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.UserCustomer;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class UserCustomerBean extends AbstractBean<UserCustomer> {
    public UserCustomerBean(){
        this.pojo = new UserCustomer();
    }

    private Long userID;
    private List<Long> customerIDs;

    public Long getUserID() {
        return userID;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }

    public List<Long> getCustomerIDs() {
        return customerIDs;
    }

    public void setCustomerIDs(List<Long> customerIDs) {
        this.customerIDs = customerIDs;
    }
}
