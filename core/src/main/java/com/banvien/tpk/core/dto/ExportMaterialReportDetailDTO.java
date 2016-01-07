package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.domain.Origin;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/23/14
 * Time: 10:28 PM
 * To change this template use File | Settings | File Templates.
 */
public class ExportMaterialReportDetailDTO implements Serializable {
    private Material material;
    private Origin origin;
    private Double quantity;
    private Timestamp expiredDate;
    private Timestamp importDate;
    private String code;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Origin getOrigin() {
        return origin;
    }

    public void setOrigin(Origin origin) {
        this.origin = origin;
    }

    public Timestamp getImportDate() {
        return importDate;
    }

    public void setImportDate(Timestamp importDate) {
        this.importDate = importDate;
    }

    public Material getMaterial() {
        return material;
    }

    public void setMaterial(Material material) {
        this.material = material;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public Timestamp getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Timestamp expiredDate) {
        this.expiredDate = expiredDate;
    }
}
