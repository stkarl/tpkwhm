package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Size;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 19/03/14
 * Time: 22:16
 * To change this template use File | Settings | File Templates.
 */
public class ProductInOutDTO implements Serializable {
    private Map<Long,ProductInOutDetailDTO> mapInitSizeProducts;
    private Map<Long,ProductInOutDetailDTO> mapInSizeProducts;
    private Map<Long,ProductInOutDetailDTO> mapOutSizeProducts;
    private List<Size> sizes;

    private String specificName;
    private String specificCode;


    public String getSpecificName() {
        return specificName;
    }

    public void setSpecificName(String specificName) {
        this.specificName = specificName;
    }

    public String getSpecificCode() {
        return specificCode;
    }

    public void setSpecificCode(String specificCode) {
        this.specificCode = specificCode;
    }

    public Map<Long, ProductInOutDetailDTO> getMapInitSizeProducts() {
        return mapInitSizeProducts;
    }

    public void setMapInitSizeProducts(Map<Long, ProductInOutDetailDTO> mapInitSizeProducts) {
        this.mapInitSizeProducts = mapInitSizeProducts;
    }

    public Map<Long, ProductInOutDetailDTO> getMapInSizeProducts() {
        return mapInSizeProducts;
    }

    public void setMapInSizeProducts(Map<Long, ProductInOutDetailDTO> mapInSizeProducts) {
        this.mapInSizeProducts = mapInSizeProducts;
    }

    public Map<Long, ProductInOutDetailDTO> getMapOutSizeProducts() {
        return mapOutSizeProducts;
    }

    public void setMapOutSizeProducts(Map<Long, ProductInOutDetailDTO> mapOutSizeProducts) {
        this.mapOutSizeProducts = mapOutSizeProducts;
    }

    public List<Size> getSizes() {
        return sizes;
    }

    public void setSizes(List<Size> sizes) {
        this.sizes = sizes;
    }
}
