package com.banvien.tpk.core.dto;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class ExportMaterialReportBean extends AbstractBean<ExportMaterialReportDTO> {
    public ExportMaterialReportBean(){
        this.pojo = new ExportMaterialReportDTO();
    }
    private Date fromDate;
    private Date toDate;
    private Long originID;
    private Long materialCategoryID;
    private Long materialID;
    private Long warehouseID;
    private String cateCode;

    public String getCateCode() {
        return cateCode;
    }

    public void setCateCode(String cateCode) {
        this.cateCode = cateCode;
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

    public Long getOriginID() {
        return originID;
    }

    public void setOriginID(Long originID) {
        this.originID = originID;
    }

    public Long getMaterialCategoryID() {
        return materialCategoryID;
    }

    public void setMaterialCategoryID(Long materialCategoryID) {
        this.materialCategoryID = materialCategoryID;
    }

    public Long getMaterialID() {
        return materialID;
    }

    public void setMaterialID(Long materialID) {
        this.materialID = materialID;
    }

    public Long getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(Long warehouseID) {
        this.warehouseID = warehouseID;
    }
}
