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
public class UserModule implements Serializable {

	private Long userModuleID;
	 private User user;
    private Module module;

    public Long getUserModuleID() {
        return userModuleID;
    }

    public void setUserModuleID(Long userModuleID) {
        this.userModuleID = userModuleID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }
}