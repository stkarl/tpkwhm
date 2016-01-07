package com.banvien.tpk.core.domain;

import java.io.Serializable;


/**
 * <p>Pojo mapping TABLE bookproduct</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class UserCustomer implements Serializable {

	private Long userCustomerID;
	 private User user;
    private Customer customer;

    public Long getUserCustomerID() {
        return userCustomerID;
    }

    public void setUserCustomerID(Long userCustomerID) {
        this.userCustomerID = userCustomerID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}