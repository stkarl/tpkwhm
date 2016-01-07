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
public class ImportBackDTO implements Serializable {
    private Importproduct originalProduct;
    private Double importBackValue;

    public Importproduct getOriginalProduct() {
        return originalProduct;
    }

    public void setOriginalProduct(Importproduct originalProduct) {
        this.originalProduct = originalProduct;
    }

    public Double getImportBackValue() {
        return importBackValue;
    }

    public void setImportBackValue(Double importBackValue) {
        this.importBackValue = importBackValue;
    }
}
