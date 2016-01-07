package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importproduct;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class SearchProductBean extends AbstractBean<Importproduct> {
    public SearchProductBean(){
        this.pojo = new Importproduct();
    }
    private Date fromImportedDate;
    private Date toImportedDate;
    private String code;
    private Long warehouseID;
    private Long productNameID;
    private Long marketID;
    private Long sizeID;
    private Long thicknessID;
    private Long stiffnessID;
    private Long colourID;
    private Long overlayTypeID;
    private Long originID;
    private Long warehouseMapID;
    private Boolean suggestPrice = Boolean.FALSE;
    private Boolean nonePriced = Boolean.FALSE;
    private Boolean booking = Boolean.FALSE;
    private Boolean reportOverlay = Boolean.FALSE;
    private Boolean editInfo = Boolean.FALSE;
    private List<SuggestPriceDTO> suggestedItems = LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(SuggestPriceDTO.class));
    private List<Long> bookedProductIDs;
    private Long customerID;
    private Date deliveryDate;

    private Double totalMet;
    private Double totalKg;
    private Boolean reportSummaryProduction = Boolean.FALSE;
    private Double fromKgM;
    private Double toKgM;

    private Integer status;

    private Boolean viewInStock = Boolean.FALSE;

    public Boolean getViewInStock() {
        return viewInStock;
    }

    public void setViewInStock(Boolean viewInStock) {
        this.viewInStock = viewInStock;
    }

    private Long bookProductBillID;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Boolean getEditInfo() {
        return editInfo;
    }

    public void setEditInfo(Boolean editInfo) {
        this.editInfo = editInfo;
    }

    public Long getBookProductBillID() {
        return bookProductBillID;
    }

    public void setBookProductBillID(Long bookProductBillID) {
        this.bookProductBillID = bookProductBillID;
    }

    public Double getFromKgM() {
        return fromKgM;
    }

    public void setFromKgM(Double fromKgM) {
        this.fromKgM = fromKgM;
    }

    public Double getToKgM() {
        return toKgM;
    }

    public void setToKgM(Double toKgM) {
        this.toKgM = toKgM;
    }

    public Boolean getReportSummaryProduction() {
        return reportSummaryProduction;
    }

    public void setReportSummaryProduction(Boolean reportSummaryProduction) {
        this.reportSummaryProduction = reportSummaryProduction;
    }

    public Boolean getReportOverlay() {
        return reportOverlay;
    }

    public void setReportOverlay(Boolean reportOverlay) {
        this.reportOverlay = reportOverlay;
    }

    public Double getTotalMet() {
        return totalMet;
    }

    public void setTotalMet(Double totalMet) {
        this.totalMet = totalMet;
    }

    public Double getTotalKg() {
        return totalKg;
    }

    public void setTotalKg(Double totalKg) {
        this.totalKg = totalKg;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public Long getWarehouseMapID() {
        return warehouseMapID;
    }

    public void setWarehouseMapID(Long warehouseMapID) {
        this.warehouseMapID = warehouseMapID;
    }

    public Long getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Long customerID) {
        this.customerID = customerID;
    }

    public List<Long> getBookedProductIDs() {
        return bookedProductIDs;
    }

    public void setBookedProductIDs(List<Long> bookedProductIDs) {
        this.bookedProductIDs = bookedProductIDs;
    }

    public Boolean getBooking() {
        return booking;
    }

    public void setBooking(Boolean booking) {
        this.booking = booking;
    }

    public List<SuggestPriceDTO> getSuggestedItems() {
        return suggestedItems;
    }

    public void setSuggestedItems(List<SuggestPriceDTO> suggestedItems) {
        this.suggestedItems = suggestedItems;
    }

    public Boolean getNonePriced() {
        return nonePriced;
    }

    public void setNonePriced(Boolean nonePriced) {
        this.nonePriced = nonePriced;
    }

    public Boolean getSuggestPrice() {
        return suggestPrice;
    }

    public void setSuggestPrice(Boolean suggestPrice) {
        this.suggestPrice = suggestPrice;
    }

    public Date getFromImportedDate() {
        return fromImportedDate;
    }

    public void setFromImportedDate(Date fromImportedDate) {
        this.fromImportedDate = fromImportedDate;
    }

    public Date getToImportedDate() {
        return toImportedDate;
    }

    public void setToImportedDate(Date toImportedDate) {
        this.toImportedDate = toImportedDate;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Long getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(Long warehouseID) {
        this.warehouseID = warehouseID;
    }

    public Long getProductNameID() {
        return productNameID;
    }

    public void setProductNameID(Long productNameID) {
        this.productNameID = productNameID;
    }

    public Long getMarketID() {
        return marketID;
    }

    public void setMarketID(Long marketID) {
        this.marketID = marketID;
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

    public Long getOriginID() {
        return originID;
    }

    public void setOriginID(Long originID) {
        this.originID = originID;
    }
}
