package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Customer;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by KhanhChu on 1/14/2018.
 */
public class DailyOweDTO implements Serializable {
    private Customer customer;
    private Timestamp date;
    private double buy = 0d;
    private double pay = 0d;

    public DailyOweDTO() {
    }

    public DailyOweDTO(Timestamp issueDate, Customer customer) {
        this.date = issueDate;
        this.customer = customer;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public double getBuy() {
        return buy;
    }

    public void setBuy(double buy) {
        this.buy = buy;
    }

    public double getPay() {
        return pay;
    }

    public void setPay(double pay) {
        this.pay = pay;
    }
}
