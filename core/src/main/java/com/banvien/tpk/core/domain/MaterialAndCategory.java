package com.banvien.tpk.core.domain;

import java.io.Serializable;
public class MaterialAndCategory implements Serializable {

	private Long materialAndCategoryID;
	private Material material;
    private Materialcategory materialCategory;

    public Long getMaterialAndCategoryID() {
        return materialAndCategoryID;
    }

    public void setMaterialAndCategoryID(Long materialAndCategoryID) {
        this.materialAndCategoryID = materialAndCategoryID;
    }

    public Material getMaterial() {
        return material;
    }

    public void setMaterial(Material material) {
        this.material = material;
    }

    public Materialcategory getMaterialCategory() {
        return materialCategory;
    }

    public void setMaterialCategory(Materialcategory materialCategory) {
        this.materialCategory = materialCategory;
    }
}