package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.LocationHistory;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class LocationHistoryBean extends AbstractBean<LocationHistory> {
    public LocationHistoryBean(){
        this.pojo = new LocationHistory();
    }
    private Date fromDate;
    private Date toDate;
    private Long oldLocationID;
    private Long newLocationID;
    private Long materialID;
    private Long productID;

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    public Long getOldLocationID() {
        return oldLocationID;
    }

    public void setOldLocationID(Long oldLocationID) {
        this.oldLocationID = oldLocationID;
    }

    public Long getNewLocationID() {
        return newLocationID;
    }

    public void setNewLocationID(Long newLocationID) {
        this.newLocationID = newLocationID;
    }

    public Long getMaterialID() {
        return materialID;
    }

    public void setMaterialID(Long materialID) {
        this.materialID = materialID;
    }

    public Long getProductID() {
        return productID;
    }

    public void setProductID(Long productID) {
        this.productID = productID;
    }
}
