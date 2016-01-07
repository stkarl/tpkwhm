package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.domain.Product;

import java.io.Serializable;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 09/04/2014
 * Time: 11:27
 * To change this template use File | Settings | File Templates.
 */
public class SummaryUsedMaterialDTO implements Serializable {
    private List<UsedMaterialDTO> usedMaterials;
    private List<UsedMaterialDTO> usedMeasurementMaterials;
    private List<UsedMaterialDTO> usedProducts;

    private List<UsedMaterialDTO> shareUsedMaterials;

    public List<UsedMaterialDTO> getShareUsedMaterials() {
        return shareUsedMaterials;
    }

    public void setShareUsedMaterials(List<UsedMaterialDTO> shareUsedMaterials) {
        this.shareUsedMaterials = shareUsedMaterials;
    }

    public List<UsedMaterialDTO> getUsedProducts() {
        return usedProducts;
    }

    public void setUsedProducts(List<UsedMaterialDTO> usedProducts) {
        this.usedProducts = usedProducts;
    }

    public List<UsedMaterialDTO> getUsedMeasurementMaterials() {
        return usedMeasurementMaterials;
    }

    public void setUsedMeasurementMaterials(List<UsedMaterialDTO> usedMeasurementMaterials) {
        this.usedMeasurementMaterials = usedMeasurementMaterials;
    }

    public List<UsedMaterialDTO> getUsedMaterials() {
        return usedMaterials;
    }

    public void setUsedMaterials(List<UsedMaterialDTO> usedMaterials) {
        this.usedMaterials = usedMaterials;
    }
}

