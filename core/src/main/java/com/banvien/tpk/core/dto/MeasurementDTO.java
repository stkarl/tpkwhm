package com.banvien.tpk.core.dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/18/14
 * Time: 9:23 PM
 * To change this template use File | Settings | File Templates.
 */
public class MeasurementDTO implements Serializable {
    private Timestamp date;
    private Double value;
    private String note;
    private Long materialID;

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Long getMaterialID() {
        return materialID;
    }

    public void setMaterialID(Long materialID) {
        this.materialID = materialID;
    }
}
