package com.banvien.tpk.core.domain;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 10/7/14
 * Time: 10:12 PM
 * To change this template use File | Settings | File Templates.
 */
public class InitProductDetail implements Serializable {

    private Long initProductDetailID;
    private Importproduct importProduct;
    private InitProduct initProduct;

    public Long getInitProductDetailID() {
        return initProductDetailID;
    }

    public void setInitProductDetailID(Long initProductDetailID) {
        this.initProductDetailID = initProductDetailID;
    }

    public Importproduct getImportProduct() {
        return importProduct;
    }

    public void setImportProduct(Importproduct importProduct) {
        this.importProduct = importProduct;
    }

    public InitProduct getInitProduct() {
        return initProduct;
    }

    public void setInitProduct(InitProduct initProduct) {
        this.initProduct = initProduct;
    }
}
