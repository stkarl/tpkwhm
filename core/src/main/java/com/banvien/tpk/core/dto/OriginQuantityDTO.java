package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importproduct;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/23/14
 * Time: 10:28 PM
 * To change this template use File | Settings | File Templates.
 */
public class OriginQuantityDTO implements Serializable {
    String origin;
    String quantity;

    public OriginQuantityDTO(String origin, String quantity) {
        this.origin = origin;
        this.quantity = quantity;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }
}
