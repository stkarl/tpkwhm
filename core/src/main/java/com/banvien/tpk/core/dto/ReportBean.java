package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importproduct;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class ReportBean extends AbstractBean<Importproduct> {
    public ReportBean(){
        this.pojo = new Importproduct();
    }
    private Integer year;
    private Date lastYear;
    private Date fromDate;
    private Date toDate;

    private Long productNameID;

    private Long sizeID;
    private Long thicknessID;
    private Long stiffnessID;
    private Long colourID;
    private Long overlayTypeID;

    private Long customerID;
    private Long userID;

    // owe report
    private Long regionID;
    private Long provinceID;
    private Integer status;
    private Double oweValue;

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Date getLastYear() {
        return lastYear;
    }

    public void setLastYear(Date lastYear) {
        this.lastYear = lastYear;
    }

    public Long getRegionID() {
        return regionID;
    }

    public void setRegionID(Long regionID) {
        this.regionID = regionID;
    }

    public Long getProvinceID() {
        return provinceID;
    }

    public void setProvinceID(Long provinceID) {
        this.provinceID = provinceID;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Double getOweValue() {
        return oweValue;
    }

    public void setOweValue(Double oweValue) {
        this.oweValue = oweValue;
    }

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

    public Long getProductNameID() {
        return productNameID;
    }

    public void setProductNameID(Long productNameID) {
        this.productNameID = productNameID;
    }

    public Long getSizeID() {
        return sizeID;
    }

    public void setSizeID(Long sizeID) {
        this.sizeID = sizeID;
    }

    public Long getThicknessID() {
        return thicknessID;
    }

    public void setThicknessID(Long thicknessID) {
        this.thicknessID = thicknessID;
    }

    public Long getStiffnessID() {
        return stiffnessID;
    }

    public void setStiffnessID(Long stiffnessID) {
        this.stiffnessID = stiffnessID;
    }

    public Long getColourID() {
        return colourID;
    }

    public void setColourID(Long colourID) {
        this.colourID = colourID;
    }

    public Long getOverlayTypeID() {
        return overlayTypeID;
    }

    public void setOverlayTypeID(Long overlayTypeID) {
        this.overlayTypeID = overlayTypeID;
    }

    public Long getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Long customerID) {
        this.customerID = customerID;
    }

    public Long getUserID() {
        return userID;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }
}
