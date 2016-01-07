package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Warehouse;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 4/29/14
 * Time: 4:06 PM
 * To change this template use File | Settings | File Templates.
 */
public class ImportMaterialDataDTO implements Serializable {
    private Warehouse warehouse;
    private String name;
    private String code;
    private String origin;
    private String market;
    private String total;
    private String unit;
    private String date;
    private String expiredDate;
    private String money;
    private boolean valid = true;
    private Long originID;
    private Long materialID;

    public Long getOriginID() {
        return originID;
    }

    public void setOriginID(Long originID) {
        this.originID = originID;
    }

    public Long getMaterialID() {
        return materialID;
    }

    public void setMaterialID(Long materialID) {
        this.materialID = materialID;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
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

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getMarket() {
        return market;
    }

    public void setMarket(String market) {
        this.market = market;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(String expiredDate) {
        this.expiredDate = expiredDate;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }
}
