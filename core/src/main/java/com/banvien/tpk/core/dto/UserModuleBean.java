package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.UserModule;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class UserModuleBean extends AbstractBean<UserModule> {
    public UserModuleBean(){
        this.pojo = new UserModule();
    }

    private Long userID;
    private List<Long> moduleIDs;

    public Long getUserID() {
        return userID;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }

    public List<Long> getModuleIDs() {
        return moduleIDs;
    }

    public void setModuleIDs(List<Long> moduleIDs) {
        this.moduleIDs = moduleIDs;
    }
}
