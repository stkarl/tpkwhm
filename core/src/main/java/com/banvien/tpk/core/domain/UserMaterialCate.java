package com.banvien.tpk.core.domain;

import java.io.Serializable;


/**
 * <p>Pojo mapping TABLE bookproduct</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class UserMaterialCate implements Serializable {

	private Long userMaterialCateID;
	private User user;
    private Materialcategory materialCategory;

    public Long getUserMaterialCateID() {
        return userMaterialCateID;
    }

    public void setUserMaterialCateID(Long userMaterialCateID) {
        this.userMaterialCateID = userMaterialCateID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Materialcategory getMaterialCategory() {
        return materialCategory;
    }

    public void setMaterialCategory(Materialcategory materialCategory) {
        this.materialCategory = materialCategory;
    }
}