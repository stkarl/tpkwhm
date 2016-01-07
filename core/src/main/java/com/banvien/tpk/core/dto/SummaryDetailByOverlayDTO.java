package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Overlaytype;
import com.banvien.tpk.core.domain.Size;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/21/14
 * Time: 7:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class SummaryDetailByOverlayDTO implements Serializable {
    private Double materialKg;
    private Double productKg;
    private Double productMet;
    private Map<Long,Double> mapQualityMet;
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

    public Double getMaterialKg() {
        return materialKg;
    }

    public void setMaterialKg(Double materialKg) {
        this.materialKg = materialKg;
    }

    public Double getProductKg() {
        return productKg;
    }

    public void setProductKg(Double productKg) {
        this.productKg = productKg;
    }

    public Double getProductMet() {
        return productMet;
    }

    public void setProductMet(Double productMet) {
        this.productMet = productMet;
    }

    public Map<Long, Double> getMapQualityMet() {
        return mapQualityMet;
    }

    public void setMapQualityMet(Map<Long, Double> mapQualityMet) {
        this.mapQualityMet = mapQualityMet;
    }
}
