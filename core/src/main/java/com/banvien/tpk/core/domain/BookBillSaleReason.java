package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class BookBillSaleReason implements Serializable {

	private Long bookBillSaleReasonID;
	private BookProductBill bookProductBill;
    private SaleReason saleReason;
    private Double money;
    private Timestamp date;

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Long getBookBillSaleReasonID() {
        return bookBillSaleReasonID;
    }

    public void setBookBillSaleReasonID(Long bookBillSaleReasonID) {
        this.bookBillSaleReasonID = bookBillSaleReasonID;
    }

    public BookProductBill getBookProductBill() {
        return bookProductBill;
    }

    public void setBookProductBill(BookProductBill bookProductBill) {
        this.bookProductBill = bookProductBill;
    }

    public SaleReason getSaleReason() {
        return saleReason;
    }

    public void setSaleReason(SaleReason saleReason) {
        this.saleReason = saleReason;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }
}