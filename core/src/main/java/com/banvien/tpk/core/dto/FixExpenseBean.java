package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.FixExpense;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class FixExpenseBean extends AbstractBean<FixExpense> {
    public FixExpenseBean(){
        this.pojo = new FixExpense();
    }
}
