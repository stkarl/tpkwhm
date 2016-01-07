package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Materialcategory;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class MaterialcategoryBean extends AbstractBean<Materialcategory> {
    public MaterialcategoryBean(){
        this.pojo = new Materialcategory();
    }
    private Long userID;
    private List<Long> materialCateIDs;

    public Long getUserID() {
        return userID;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }

    public List<Long> getMaterialCateIDs() {
        return materialCateIDs;
    }

    public void setMaterialCateIDs(List<Long> materialCateIDs) {
        this.materialCateIDs = materialCateIDs;
    }
}
