package com.banvien.tpk.core.domain;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 10/7/14
 * Time: 10:12 PM
 * To change this template use File | Settings | File Templates.
 */
public class FixExpense implements Serializable {
    private Long fixExpenseID;
    private String name;
    private Integer displayOrder;

    public Long getFixExpenseID() {
        return fixExpenseID;
    }

    public void setFixExpenseID(Long fixExpenseID) {
        this.fixExpenseID = fixExpenseID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }
}
