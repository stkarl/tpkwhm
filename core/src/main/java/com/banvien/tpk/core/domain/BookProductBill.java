package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 5/18/14
 * Time: 1:37 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookProductBill implements Serializable {

    private Long bookProductBillID;
    private Customer customer;
    private String description;
    private User createdBy;
    private Timestamp createdDate;
    private User confirmedBy;
    private Timestamp confirmedDate;
    private Integer status;
    private User updatedBy;
    private Timestamp updatedDate;
    private String note;
    private List<BookProduct> bookProducts;
    private Timestamp deliveryDate;
    private String destination;
    private Double reduce;
    private Double reduceCost;
    private Double money;
    private List<BookBillSaleReason> bookBillSaleReasons;
    private List<OweLog> prePaids;
    private Timestamp billDate;

    public Double getReduceCost() {
        return reduceCost;
    }

    public void setReduceCost(Double reduceCost) {
        this.reduceCost = reduceCost;
    }

    public Timestamp getBillDate() {
        return billDate;
    }

    public void setBillDate(Timestamp billDate) {
        this.billDate = billDate;
    }

    public List<OweLog> getPrePaids() {
        return prePaids;
    }

    public void setPrePaids(List<OweLog> prePaids) {
        this.prePaids = prePaids;
    }

    public List<BookBillSaleReason> getBookBillSaleReasons() {
        return bookBillSaleReasons;
    }

    public void setBookBillSaleReasons(List<BookBillSaleReason> bookBillSaleReasons) {
        this.bookBillSaleReasons = bookBillSaleReasons;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public Double getReduce() {
        return reduce;
    }

    public void setReduce(Double reduce) {
        this.reduce = reduce;
    }

    public User getConfirmedBy() {
        return confirmedBy;
    }

    public void setConfirmedBy(User confirmedBy) {
        this.confirmedBy = confirmedBy;
    }

    public Timestamp getConfirmedDate() {
        return confirmedDate;
    }

    public void setConfirmedDate(Timestamp confirmedDate) {
        this.confirmedDate = confirmedDate;
    }

    public Timestamp getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Timestamp deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public Long getBookProductBillID() {
        return bookProductBillID;
    }

    public void setBookProductBillID(Long bookProductBillID) {
        this.bookProductBillID = bookProductBillID;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public User getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(User updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Timestamp getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public List<BookProduct> getBookProducts() {
        return bookProducts;
    }

    public void setBookProducts(List<BookProduct> bookProducts) {
        this.bookProducts = bookProducts;
    }
}
