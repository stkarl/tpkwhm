package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Customer;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/21/14
 * Time: 7:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class SummaryLiabilityDTO implements Serializable {
    //revise
    private String customerName;
    private String province;
    private Timestamp arisingDate;
    private Timestamp dueDate;
    private Double initialOwe;
    private Double bought;
    private Double paid;

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

    public Timestamp getArisingDate() {
        return arisingDate;
    }

    public void setArisingDate(Timestamp arisingDate) {
        this.arisingDate = arisingDate;
    }

    public Timestamp getDueDate() {
        return dueDate;
    }

    public void setDueDate(Timestamp dueDate) {
        this.dueDate = dueDate;
    }

    public Double getInitialOwe() {
        return initialOwe;
    }

    public void setInitialOwe(Double initialOwe) {
        this.initialOwe = initialOwe;
    }

    public Double getBought() {
        return bought;
    }

    public void setBought(Double bought) {
        this.bought = bought;
    }

    public Double getPaid() {
        return paid;
    }

    public void setPaid(Double paid) {
        this.paid = paid;
    }
}
