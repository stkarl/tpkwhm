package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Warehouse;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 4/29/14
 * Time: 4:07 PM
 * To change this template use File | Settings | File Templates.
 */
public class ImportMaterialDataBean extends AbstractBean<ImportMaterialDataDTO> {
    private Warehouse warehouse;
    private Long materialID;
    private Long originID;

    public Long getMaterialID() {
        return materialID;
    }

    public void setMaterialID(Long materialID) {
        this.materialID = materialID;
    }

    public Long getOriginID() {
        return originID;
    }

    public void setOriginID(Long originID) {
        this.originID = originID;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }
}
