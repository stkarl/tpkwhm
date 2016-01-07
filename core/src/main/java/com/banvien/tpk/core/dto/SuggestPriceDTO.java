package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.WarehouseMap;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 5/17/14
 * Time: 7:19 AM
 * To change this template use File | Settings | File Templates.
 */
public class SuggestPriceDTO implements Serializable {
    private Long itemID;
    private Double price;
    private Long qualityID;
    private Double saleQuantity;
    private Double salePrice;

    public Double getSaleQuantity() {
        return saleQuantity;
    }

    public void setSaleQuantity(Double saleQuantity) {
        this.saleQuantity = saleQuantity;
    }

    public Double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(Double salePrice) {
        this.salePrice = salePrice;
    }

    private WarehouseMap warehouseMap;

    public WarehouseMap getWarehouseMap() {
        return warehouseMap;
    }

    public void setWarehouseMap(WarehouseMap warehouseMap) {
        this.warehouseMap = warehouseMap;
    }


    public Long getQualityID() {
        return qualityID;
    }

    public void setQualityID(Long qualityID) {
        this.qualityID = qualityID;
    }

    public Long getItemID() {
        return itemID;
    }

    public void setItemID(Long itemID) {
        this.itemID = itemID;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
