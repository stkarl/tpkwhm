package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Warehouse;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 4/29/14
 * Time: 4:06 PM
 * To change this template use File | Settings | File Templates.
 */
public class ImportProductDataDTO implements Serializable {
    private Warehouse warehouse;
    private String name;
    private String code;
    private String size;
    private String thickness;
    private String stiffness;
    private String colour;
    private String overlay;
    private String origin;
    private String market;
    private String loi;
    private String a;
    private String b;
    private String c;
    private String pp;
    private String totalM;
    private String totalKg;
    private String date;
    private String note;
    private String money;
    private boolean valid = true;

    private String quantityPure;
    private String quantityOverall;
    private String quantityActual;


    private Timestamp initDate;

    public Timestamp getInitDate() {
        return initDate;
    }

    public void setInitDate(Timestamp initDate) {
        this.initDate = initDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getLoi() {
        return loi;
    }

    public void setLoi(String loi) {
        this.loi = loi;
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

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getThickness() {
        return thickness;
    }

    public void setThickness(String thickness) {
        this.thickness = thickness;
    }

    public String getStiffness() {
        return stiffness;
    }

    public void setStiffness(String stiffness) {
        this.stiffness = stiffness;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public String getOverlay() {
        return overlay;
    }

    public void setOverlay(String overlay) {
        this.overlay = overlay;
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

    public String getA() {
        return a;
    }

    public void setA(String a) {
        this.a = a;
    }

    public String getB() {
        return b;
    }

    public void setB(String b) {
        this.b = b;
    }

    public String getC() {
        return c;
    }

    public void setC(String c) {
        this.c = c;
    }

    public String getPp() {
        return pp;
    }

    public void setPp(String pp) {
        this.pp = pp;
    }

    public String getTotalM() {
        return totalM;
    }

    public void setTotalM(String totalM) {
        this.totalM = totalM;
    }

    public String getTotalKg() {
        return totalKg;
    }

    public void setTotalKg(String totalKg) {
        this.totalKg = totalKg;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public String getQuantityPure() {
        return quantityPure;
    }

    public void setQuantityPure(String quantityPure) {
        this.quantityPure = quantityPure;
    }

    public String getQuantityOverall() {
        return quantityOverall;
    }

    public void setQuantityOverall(String quantityOverall) {
        this.quantityOverall = quantityOverall;
    }

    public String getQuantityActual() {
        return quantityActual;
    }

    public void setQuantityActual(String quantityActual) {
        this.quantityActual = quantityActual;
    }
}
