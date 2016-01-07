package com.banvien.tpk.core.domain;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 9/10/14
 * Time: 8:48 AM
 * To change this template use File | Settings | File Templates.
 */
public class SaleReason implements Serializable {
    private Long saleReasonID;
    private String reason;
    private Integer displayOrder;

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public Long getSaleReasonID() {
        return saleReasonID;
    }

    public void setSaleReasonID(Long saleReasonID) {
        this.saleReasonID = saleReasonID;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
