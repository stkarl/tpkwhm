package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Warehouse;

import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 4/29/14
 * Time: 4:07 PM
 * To change this template use File | Settings | File Templates.
 */
public class ImportProductDataBean extends AbstractBean<ImportProductDataDTO> {
    private Warehouse warehouse;
    private Timestamp initDate;

    public Timestamp getInitDate() {
        return initDate;
    }

    public void setInitDate(Timestamp initDate) {
        this.initDate = initDate;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }
}
