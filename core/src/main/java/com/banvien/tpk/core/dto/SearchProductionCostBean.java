package com.banvien.tpk.core.dto;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class SearchProductionCostBean extends AbstractBean<SummaryCostDTO> {
    public SearchProductionCostBean(){
        this.pojo = new SummaryCostDTO();
    }
    private Date fromDate;
    private Date toDate;
    private Long productionPlanID;
    private Long productNameID;
    private Long producedProductID;
    private Long sizeID;

    public Long getSizeID() {
        return sizeID;
    }

    public void setSizeID(Long sizeID) {
        this.sizeID = sizeID;
    }

    public Long getProducedProductID() {
        return producedProductID;
    }

    public void setProducedProductID(Long producedProductID) {
        this.producedProductID = producedProductID;
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

    public Long getProductionPlanID() {
        return productionPlanID;
    }

    public void setProductionPlanID(Long productionPlanID) {
        this.productionPlanID = productionPlanID;
    }

    public Long getProductNameID() {
        return productNameID;
    }

    public void setProductNameID(Long productNameID) {
        this.productNameID = productNameID;
    }
}
