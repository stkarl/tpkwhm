package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.UserMaterialCate;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class UserMaterialCateBean extends AbstractBean<UserMaterialCate> {
    public UserMaterialCateBean(){
        this.pojo = new UserMaterialCate();
    }

    private Long userID;
    private List<Long> materialCategoryIDs;

    public Long getUserID() {
        return userID;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }

    public List<Long> getMaterialCategoryIDs() {
        return materialCategoryIDs;
    }

    public void setMaterialCategoryIDs(List<Long> materialCategoryIDs) {
        this.materialCategoryIDs = materialCategoryIDs;
    }
}
