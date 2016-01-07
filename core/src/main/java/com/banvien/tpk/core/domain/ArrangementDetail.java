package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 10/7/14
 * Time: 10:12 PM
 * To change this template use File | Settings | File Templates.
 */
public class ArrangementDetail implements Serializable {

    private Long arrangementDetailID;
    private FixExpense fixExpense;
    private Arrangement arrangement;
    private Double value;

    public Long getArrangementDetailID() {
        return arrangementDetailID;
    }

    public void setArrangementDetailID(Long arrangementDetailID) {
        this.arrangementDetailID = arrangementDetailID;
    }

    public FixExpense getFixExpense() {
        return fixExpense;
    }

    public void setFixExpense(FixExpense fixExpense) {
        this.fixExpense = fixExpense;
    }

    public Arrangement getArrangement() {
        return arrangement;
    }

    public void setArrangement(Arrangement arrangement) {
        this.arrangement = arrangement;
    }

    public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
    }
}
