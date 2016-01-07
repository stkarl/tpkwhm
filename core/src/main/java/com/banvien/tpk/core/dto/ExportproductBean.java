package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Exportproduct;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class ExportproductBean extends AbstractBean<Exportproduct> {
    public ExportproductBean(){
        this.pojo = new Exportproduct();
    }

    private Long productionPlanID;

    public Long getProductionPlanID() {
        return productionPlanID;
    }

    public void setProductionPlanID(Long productionPlanID) {
        this.productionPlanID = productionPlanID;
    }

}
