package com.banvien.tpk.core.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 1/20/16
 * Time: 8:28 PM
 * To change this template use File | Settings | File Templates.
 */
public class CustomerActivityDTO implements Serializable {
    private String customerName;
    private String customerPhone;
    private Double initOwe;
    private Date initDate;
    private Map<String,List<CustomerActivityDetailDTO>> mapDateActivities;

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public Double getInitOwe() {
        return initOwe;
    }

    public void setInitOwe(Double initOwe) {
        this.initOwe = initOwe;
    }

    public Date getInitDate() {
        return initDate;
    }

    public void setInitDate(Date initDate) {
        this.initDate = initDate;
    }

    public Map<String, List<CustomerActivityDetailDTO>> getMapDateActivities() {
        return mapDateActivities;
    }

    public void setMapDateActivities(Map<String, List<CustomerActivityDetailDTO>> mapDateActivities) {
        this.mapDateActivities = mapDateActivities;
    }
}
