package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.*;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/18/14
 * Time: 9:23 PM
 * To change this template use File | Settings | File Templates.
 */
public class PriceUpdateDTO implements Serializable {
    private Timestamp effectedDate;
    private Double price;
    private Double fixedFee;
    private Productname productName;
    private Size size;
    private Thickness thickness;
    private Colour colour;
    private Quality quality;

    public Timestamp getEffectedDate() {
        return effectedDate;
    }

    public void setEffectedDate(Timestamp effectedDate) {
        this.effectedDate = effectedDate;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getFixedFee() {
        return fixedFee;
    }

    public void setFixedFee(Double fixedFee) {
        this.fixedFee = fixedFee;
    }

    public Productname getProductName() {
        return productName;
    }

    public void setProductName(Productname productName) {
        this.productName = productName;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public Thickness getThickness() {
        return thickness;
    }

    public void setThickness(Thickness thickness) {
        this.thickness = thickness;
    }

    public Colour getColour() {
        return colour;
    }

    public void setColour(Colour colour) {
        this.colour = colour;
    }

    public Quality getQuality() {
        return quality;
    }

    public void setQuality(Quality quality) {
        this.quality = quality;
    }
}
