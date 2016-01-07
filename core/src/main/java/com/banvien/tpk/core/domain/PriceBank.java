package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 5/18/14
 * Time: 1:37 PM
 * To change this template use File | Settings | File Templates.
 */
public class PriceBank implements Serializable {
    private Long priceBankID;
    private Productname productName;
    private Size size;
    private Thickness thickness;
    private Colour colour;
    private Quality quality;
    private Timestamp effectedDate;
    private Double price;
    private Double fixedFee;

    public Quality getQuality() {
        return quality;
    }

    public void setQuality(Quality quality) {
        this.quality = quality;
    }

    public Long getPriceBankID() {
        return priceBankID;
    }

    public void setPriceBankID(Long priceBankID) {
        this.priceBankID = priceBankID;
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
}
