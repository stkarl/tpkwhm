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
public class SelectedItemDTO implements Serializable {
    private Long itemID;
    private WarehouseMap warehouseMap;

    public WarehouseMap getWarehouseMap() {
        return warehouseMap;
    }

    public void setWarehouseMap(WarehouseMap warehouseMap) {
        this.warehouseMap = warehouseMap;
    }

    public Long getItemID() {
        return itemID;
    }

    public void setItemID(Long itemID) {
        this.itemID = itemID;
    }
}
