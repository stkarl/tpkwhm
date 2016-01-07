package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 10/7/14
 * Time: 10:12 PM
 * To change this template use File | Settings | File Templates.
 */
public class InitProduct implements Serializable {
    private Long initProductID;
    private Timestamp initDate;
    private Timestamp createdDate;
    private List<InitProductDetail> initProductDetails;
    private Warehouse warehouse;
    private User createdBy;

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public List<InitProductDetail> getInitProductDetails() {
        return initProductDetails;
    }

    public void setInitProductDetails(List<InitProductDetail> initProductDetails) {
        this.initProductDetails = initProductDetails;
    }

    public Long getInitProductID() {
        return initProductID;
    }

    public void setInitProductID(Long initProductID) {
        this.initProductID = initProductID;
    }

    public Timestamp getInitDate() {
        return initDate;
    }

    public void setInitDate(Timestamp initDate) {
        this.initDate = initDate;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
}
