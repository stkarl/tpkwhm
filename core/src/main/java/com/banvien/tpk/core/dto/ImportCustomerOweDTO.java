package com.banvien.tpk.core.dto;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 4/29/14
 * Time: 4:06 PM
 * To change this template use File | Settings | File Templates.
 */
public class ImportCustomerOweDTO implements Serializable {
    private String customerName;
    private String province;
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

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
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
