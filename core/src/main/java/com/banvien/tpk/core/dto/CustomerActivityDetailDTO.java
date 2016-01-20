package com.banvien.tpk.core.dto;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 1/20/16
 * Time: 8:28 PM
 * To change this template use File | Settings | File Templates.
 */
public class CustomerActivityDetailDTO implements Serializable {
    private String productName;
    private String size;
    private String specific;
    private String code;
    private Double kg;
    private Double met;
    private Double price;
    private Double moneyBuy;
    private Double moneyPay;

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getSpecific() {
        return specific;
    }

    public void setSpecific(String specific) {
        this.specific = specific;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Double getKg() {
        return kg;
    }

    public void setKg(Double kg) {
        this.kg = kg;
    }

    public Double getMet() {
        return met;
    }

    public void setMet(Double met) {
        this.met = met;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getMoneyBuy() {
        return moneyBuy;
    }

    public void setMoneyBuy(Double moneyBuy) {
        this.moneyBuy = moneyBuy;
    }

    public Double getMoneyPay() {
        return moneyPay;
    }

    public void setMoneyPay(Double moneyPay) {
        this.moneyPay = moneyPay;
    }
}
