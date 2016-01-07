package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Customer;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class CustomerBean extends AbstractBean<Customer> {
    public CustomerBean(){
        this.pojo = new Customer();
    }

    private Long userID;
    private List<Long> customerIDs;
    private List<UpdateLiabilityDTO> updateLiabilities = LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(UpdateLiabilityDTO.class));

    public List<UpdateLiabilityDTO> getUpdateLiabilities() {
        return updateLiabilities;
    }

    public void setUpdateLiabilities(List<UpdateLiabilityDTO> updateLiabilities) {
        this.updateLiabilities = updateLiabilities;
    }

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
