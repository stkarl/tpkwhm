package com.banvien.tpk.core.domain;

import com.banvien.tpk.core.Constants;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 11/03/14
 * Time: 22:50
 * To change this template use File | Settings | File Templates.
 */
public class WarehouseMap implements Serializable {
    private Long warehouseMapID;
    private String name;
    private String code;
    private String description;
    private Warehouse warehouse;
    private String imageName;

    public Long getWarehouseMapID() {
        return warehouseMapID;
    }

    public void setWarehouseMapID(Long warehouseMapID) {
        this.warehouseMapID = warehouseMapID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }
}
