package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.BookProductBill;
import com.banvien.tpk.core.domain.Exportproductbill;
import com.banvien.tpk.core.domain.OweLog;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class BookProductBillBean extends AbstractBean<BookProductBill> {
    public BookProductBillBean(){
        this.pojo = new BookProductBill();
    }
    private Date fromDate;
    private Date toDate;
    private Long userID;
    private Long customerID;
    private Integer status;
    private List<Long> bookedProductIDs;
    private Date exportDate;
    private String title;
    private List<SuggestPriceDTO> suggestedItems = LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(SuggestPriceDTO.class));
    private Map<Long,Double> mapReasonMoney;
    private Map<Long,Timestamp> mapReasonDate;
    private List<OweLog> prePaids = LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(SuggestPriceDTO.class));
    private Double totalMoney;

    public Map<Long, Timestamp> getMapReasonDate() {
        return mapReasonDate;
    }

    public void setMapReasonDate(Map<Long, Timestamp> mapReasonDate) {
        this.mapReasonDate = mapReasonDate;
    }

    public List<OweLog> getPrePaids() {
        return prePaids;
    }

    public void setPrePaids(List<OweLog> prePaids) {
        this.prePaids = prePaids;
    }

    public Map<Long, Double> getMapReasonMoney() {
        return mapReasonMoney;
    }

    public void setMapReasonMoney(Map<Long, Double> mapReasonMoney) {
        this.mapReasonMoney = mapReasonMoney;
    }

    public Double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(Double totalMoney) {
        this.totalMoney = totalMoney;
    }

    public List<SuggestPriceDTO> getSuggestedItems() {
        return suggestedItems;
    }

    public void setSuggestedItems(List<SuggestPriceDTO> suggestedItems) {
        this.suggestedItems = suggestedItems;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getExportDate() {
        return exportDate;
    }

    public void setExportDate(Date exportDate) {
        this.exportDate = exportDate;
    }

    public List<Long> getBookedProductIDs() {
        return bookedProductIDs;
    }

    public void setBookedProductIDs(List<Long> bookedProductIDs) {
        this.bookedProductIDs = bookedProductIDs;
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

    public Long getUserID() {
        return userID;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }

    public Long getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Long customerID) {
        this.customerID = customerID;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
