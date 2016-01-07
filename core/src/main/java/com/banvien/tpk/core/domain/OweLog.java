package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 11/03/14
 * Time: 22:50
 * To change this template use File | Settings | File Templates.
 */
public class OweLog implements Serializable {
    private Long oweLogID;
    private Customer customer;
    private Double prePay;
    private Double pay;
    private Timestamp payDate;
    private User createdBy;
    private Timestamp createdDate;
    private Integer dayAllow;
    private String type;
    private Timestamp oweDate;
    private String note;
    private BookProductBill bookProductBill;

    public BookProductBill getBookProductBill() {
        return bookProductBill;
    }

    public void setBookProductBill(BookProductBill bookProductBill) {
        this.bookProductBill = bookProductBill;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getOweDate() {
        return oweDate;
    }

    public void setOweDate(Timestamp oweDate) {
        this.oweDate = oweDate;
    }

    public Integer getDayAllow() {
        return dayAllow;
    }

    public void setDayAllow(Integer dayAllow) {
        this.dayAllow = dayAllow;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Long getOweLogID() {
        return oweLogID;
    }

    public void setOweLogID(Long oweLogID) {
        this.oweLogID = oweLogID;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Double getPrePay() {
        return prePay;
    }

    public void setPrePay(Double prePay) {
        this.prePay = prePay;
    }

    public Double getPay() {
        return pay;
    }

    public void setPay(Double pay) {
        this.pay = pay;
    }

    public Timestamp getPayDate() {
        return payDate;
    }

    public void setPayDate(Timestamp payDate) {
        this.payDate = payDate;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
}
