package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.ProductionPlan;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class ProductionPlanBean extends AbstractBean<ProductionPlan> {
    public ProductionPlanBean(){
        this.pojo = new ProductionPlan();
    }
    private Boolean produce = Boolean.TRUE;
    private Date fromDate;
    private Date toDate;

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

    public Boolean getProduce() {
        return produce;
    }

    public void setProduce(Boolean produce) {
        this.produce = produce;
    }
}
