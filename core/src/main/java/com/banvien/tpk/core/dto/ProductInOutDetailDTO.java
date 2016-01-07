package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importproduct;

import java.io.Serializable;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 19/03/14
 * Time: 22:16
 * To change this template use File | Settings | File Templates.
 */
public class ProductInOutDetailDTO implements Serializable {
    private Integer noRoll;
    private Double met;
    private Double kg;
    private Long sizeID;
    private List<Importproduct> importProducts;

    public List<Importproduct> getImportProducts() {
        return importProducts;
    }

    public void setImportProducts(List<Importproduct> importProducts) {
        this.importProducts = importProducts;
    }

    public Integer getNoRoll() {
        return noRoll;
    }

    public void setNoRoll(Integer noRoll) {
        this.noRoll = noRoll;
    }

    public Double getMet() {
        return met;
    }

    public void setMet(Double met) {
        this.met = met;
    }

    public Double getKg() {
        return kg;
    }

    public void setKg(Double kg) {
        this.kg = kg;
    }

    public Long getSizeID() {
        return sizeID;
    }

    public void setSizeID(Long sizeID) {
        this.sizeID = sizeID;
    }
}
