package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Exportmaterial;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class SearchUsedMaterialBean extends AbstractBean<Exportmaterial> {
    public SearchUsedMaterialBean(){
        this.pojo = new Exportmaterial();
    }
    private Date fromExportedDate;
    private Date toExportedDate;
    private Long warehouseID;
    private Long materialID;
    private Long marketID;
    private Long originID;
    private Long exportTypeID;
    private Long productionPlanID;

    private Integer productionType = 1;

    public Integer getProductionType() {
        return productionType;
    }

    public void setProductionType(Integer productionType) {
        this.productionType = productionType;
    }

    public Long getExportTypeID() {
        return exportTypeID;
    }

    public void setExportTypeID(Long exportTypeID) {
        this.exportTypeID = exportTypeID;
    }

    public Long getProductionPlanID() {
        return productionPlanID;
    }

    public void setProductionPlanID(Long productionPlanID) {
        this.productionPlanID = productionPlanID;
    }

    public Long getMaterialID() {
        return materialID;
    }

    public void setMaterialID(Long materialID) {
        this.materialID = materialID;
    }

    public Date getFromExportedDate() {
        return fromExportedDate;
    }

    public void setFromExportedDate(Date fromExportedDate) {
        this.fromExportedDate = fromExportedDate;
    }

    public Date getToExportedDate() {
        return toExportedDate;
    }

    public void setToExportedDate(Date toExportedDate) {
        this.toExportedDate = toExportedDate;
    }

    public Long getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(Long warehouseID) {
        this.warehouseID = warehouseID;
    }

    public Long getMarketID() {
        return marketID;
    }

    public void setMarketID(Long marketID) {
        this.marketID = marketID;
    }

    public Long getOriginID() {
        return originID;
    }

    public void setOriginID(Long originID) {
        this.originID = originID;
    }
}
