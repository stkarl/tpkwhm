package com.banvien.tpk.core.dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 7/28/14
 * Time: 10:39 PM
 * To change this template use File | Settings | File Templates.
 */
public class SellSummaryDTO implements Serializable {
    private String customerName;
    private String province;
    private Timestamp toDate;
    private Double initialOwe;
    private Double kem;
    private Double lanh;
    private Double mau;
    private Double totalMoney;
    private Double paid;

    public Double getKem() {
        return kem;
    }

    public void setKem(Double kem) {
        this.kem = kem;
    }

    public Double getLanh() {
        return lanh;
    }

    public void setLanh(Double lanh) {
        this.lanh = lanh;
    }

    public Double getMau() {
        return mau;
    }

    public void setMau(Double mau) {
        this.mau = mau;
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

    public Timestamp getToDate() {
        return toDate;
    }

    public void setToDate(Timestamp toDate) {
        this.toDate = toDate;
    }

    public Double getInitialOwe() {
        return initialOwe;
    }

    public void setInitialOwe(Double initialOwe) {
        this.initialOwe = initialOwe;
    }

    public Double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(Double totalMoney) {
        this.totalMoney = totalMoney;
    }

    public Double getPaid() {
        return paid;
    }

    public void setPaid(Double paid) {
        this.paid = paid;
    }
}
