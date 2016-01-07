package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Unit;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class UnitBean extends AbstractBean<Unit> {
    public UnitBean(){
        this.pojo = new Unit();
    }
}
