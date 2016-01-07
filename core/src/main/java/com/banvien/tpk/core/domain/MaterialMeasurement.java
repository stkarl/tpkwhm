package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 4/19/14
 * Time: 9:14 PM
 * To change this template use File | Settings | File Templates.
 */
public class MaterialMeasurement implements Serializable {
    private Long materialMeasurementID;
    private Material material;
    private Warehouse warehouse;
    private Double value;
    private Timestamp createdDate;
    private User createdBy;
    private Timestamp date;
    private String note;

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Long getMaterialMeasurementID() {
        return materialMeasurementID;
    }

    public void setMaterialMeasurementID(Long materialMeasurementID) {
        this.materialMeasurementID = materialMeasurementID;
    }

    public Material getMaterial() {
        return material;
    }

    public void setMaterial(Material material) {
        this.material = material;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }
}
