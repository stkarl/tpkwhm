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
public class Arrangement implements Serializable {
    private Long arrangementID;
    private Timestamp fromDate;
    private Timestamp toDate;
    private Double totalBlack;
    private Double average;
    private List<ArrangementDetail> arrangementDetails;

    public List<ArrangementDetail> getArrangementDetails() {
        return arrangementDetails;
    }

    public void setArrangementDetails(List<ArrangementDetail> arrangementDetails) {
        this.arrangementDetails = arrangementDetails;
    }

    public Long getArrangementID() {
        return arrangementID;
    }

    public void setArrangementID(Long arrangementID) {
        this.arrangementID = arrangementID;
    }

    public Timestamp getFromDate() {
        return fromDate;
    }

    public void setFromDate(Timestamp fromDate) {
        this.fromDate = fromDate;
    }

    public Timestamp getToDate() {
        return toDate;
    }

    public void setToDate(Timestamp toDate) {
        this.toDate = toDate;
    }

    public Double getTotalBlack() {
        return totalBlack;
    }

    public void setTotalBlack(Double totalBlack) {
        this.totalBlack = totalBlack;
    }

    public Double getAverage() {
        return average;
    }

    public void setAverage(Double average) {
        this.average = average;
    }
}
