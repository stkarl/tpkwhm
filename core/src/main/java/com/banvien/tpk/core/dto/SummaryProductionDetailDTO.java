package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Size;
import com.banvien.tpk.core.domain.Thickness;

import java.io.Serializable;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/21/14
 * Time: 7:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class SummaryProductionDetailDTO implements Serializable {
    private String size;
    private String specific;
    private Integer noMaterialRoll;
    private Double materialKg;
    private Integer noProductRoll;
    private Double productKg;
    private Map<Long,Double> mapQualityMet;
    private Double totalMet;
    private Double totalMet2;
    private Map<Long,Double> mapOriginQuantity;
    private String originQuantityHTML;

    public String getOriginQuantityHTML() {
        return originQuantityHTML;
    }

    public void setOriginQuantityHTML(String originQuantityHTML) {
        this.originQuantityHTML = originQuantityHTML;
    }

    public Map<Long, Double> getMapOriginQuantity() {
        return mapOriginQuantity;
    }

    public void setMapOriginQuantity(Map<Long, Double> mapOriginQuantity) {
        this.mapOriginQuantity = mapOriginQuantity;
    }

    public String getSpecific() {
        return specific;
    }

    public void setSpecific(String specific) {
        this.specific = specific;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public Integer getNoMaterialRoll() {
        return noMaterialRoll;
    }

    public void setNoMaterialRoll(Integer noMaterialRoll) {
        this.noMaterialRoll = noMaterialRoll;
    }

    public Double getMaterialKg() {
        return materialKg;
    }

    public void setMaterialKg(Double materialKg) {
        this.materialKg = materialKg;
    }

    public Integer getNoProductRoll() {
        return noProductRoll;
    }

    public void setNoProductRoll(Integer noProductRoll) {
        this.noProductRoll = noProductRoll;
    }

    public Double getProductKg() {
        return productKg;
    }

    public void setProductKg(Double productKg) {
        this.productKg = productKg;
    }

    public Map<Long, Double> getMapQualityMet() {
        return mapQualityMet;
    }

    public void setMapQualityMet(Map<Long, Double> mapQualityMet) {
        this.mapQualityMet = mapQualityMet;
    }

    public Double getTotalMet() {
        return totalMet;
    }

    public void setTotalMet(Double totalMet) {
        this.totalMet = totalMet;
    }

    public Double getTotalMet2() {
        return totalMet2;
    }

    public void setTotalMet2(Double totalMet2) {
        this.totalMet2 = totalMet2;
    }
}
