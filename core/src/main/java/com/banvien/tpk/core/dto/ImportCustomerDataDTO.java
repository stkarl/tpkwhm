package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Warehouse;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 4/29/14
 * Time: 4:06 PM
 * To change this template use File | Settings | File Templates.
 */
public class ImportCustomerDataDTO implements Serializable {
    private String userName;
    private String customerName;
    private String companyName;
    private String companyTel;
    private String fax;
    private String address;
    private String province;
    private String contact;
    private String contactPhone;
    private String birthday;
    private String oweLimit;
    private String owePast;
    private String oweCurrent;
    private String payCurrent;
    private String oweDate;
    private boolean valid = true;

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyTel() {
        return companyTel;
    }

    public void setCompanyTel(String companyTel) {
        this.companyTel = companyTel;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getOweLimit() {
        return oweLimit;
    }

    public void setOweLimit(String oweLimit) {
        this.oweLimit = oweLimit;
    }

    public String getOwePast() {
        return owePast;
    }

    public void setOwePast(String owePast) {
        this.owePast = owePast;
    }

    public String getOweCurrent() {
        return oweCurrent;
    }

    public void setOweCurrent(String oweCurrent) {
        this.oweCurrent = oweCurrent;
    }

    public String getPayCurrent() {
        return payCurrent;
    }

    public void setPayCurrent(String payCurrent) {
        this.payCurrent = payCurrent;
    }

    public String getOweDate() {
        return oweDate;
    }

    public void setOweDate(String oweDate) {
        this.oweDate = oweDate;
    }
}
