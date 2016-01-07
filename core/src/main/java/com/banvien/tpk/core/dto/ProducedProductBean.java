package com.banvien.tpk.core.dto;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 19/03/14
 * Time: 22:17
 * To change this template use File | Settings | File Templates.
 */
public class ProducedProductBean extends AbstractBean<ProducedProductDTO> {
    private Date fromDate;
    private Date toDate;
    private String code;
    private Long warehouseID;
    private Long productNameID; //NL
    private Long producedProductID; //SP
    private Long marketID;
    private Long sizeID;
    private Long thicknessID;
    private Long stiffnessID;
    private Long colourID;
    private Long overlayTypeID;
    private Long originID;
    private String productNameCode;
    private Long productionPlanID;

    private Boolean reportSummaryProduction = Boolean.FALSE;
    private Boolean reportOverlay = Boolean.FALSE;
    private Boolean reportCost = Boolean.FALSE;

    public Boolean getReportCost() {
        return reportCost;
    }

    public void setReportCost(Boolean reportCost) {
        this.reportCost = reportCost;
    }

    public Long getProducedProductID() {
        return producedProductID;
    }

    public void setProducedProductID(Long producedProductID) {
        this.producedProductID = producedProductID;
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

    public Long getProductionPlanID() {
        return productionPlanID;
    }

    public void setProductionPlanID(Long productionPlanID) {
        this.productionPlanID = productionPlanID;
    }

    public String getProductNameCode() {
        return productNameCode;
    }

    public void setProductNameCode(String productNameCode) {
        this.productNameCode = productNameCode;
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
