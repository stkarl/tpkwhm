package com.banvien.tpk.core.dto;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 7/15/14
 * Time: 11:26 PM
 * To change this template use File | Settings | File Templates.
 */
public class ReImportProductDTO implements Serializable {
    private String code;
    private Long originalProductId;
    private Double kg;
    private Double m;
    private String note;

    public Long getOriginalProductId() {
        return originalProductId;
    }

    public void setOriginalProductId(Long originalProductId) {
        this.originalProductId = originalProductId;
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

    public Double getM() {
        return m;
    }

    public void setM(Double m) {
        this.m = m;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
