package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Material;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class MaterialBean extends AbstractBean<Material> {
    public MaterialBean(){
        this.pojo = new Material();
    }

    private List<Long> materialCategoryIDs;

    private Long materialCategoryID;

    public Long getMaterialCategoryID() {
        return materialCategoryID;
    }

    public void setMaterialCategoryID(Long materialCategoryID) {
        this.materialCategoryID = materialCategoryID;
    }

    public List<Long> getMaterialCategoryIDs() {
        return materialCategoryIDs;
    }

    public void setMaterialCategoryIDs(List<Long> materialCategoryIDs) {
        this.materialCategoryIDs = materialCategoryIDs;
    }
}
