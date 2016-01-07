package com.banvien.tpk.core.dto;

/**
 * Created with IntelliJ IDEA.
 * User: BV-Dev1
 * Date: 11/30/12
 * Time: 4:36 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserImportBean extends AbstractBean<UserDTO> {
    public Long getRegionID() {
        return regionID;
    }

    public void setRegionID(Long regionID) {
        this.regionID = regionID;
    }

    public Long getDistributorID() {
        return distributorID;
    }

    public void setDistributorID(Long distributorID) {
        this.distributorID = distributorID;
    }

    private Long regionID;

    private Long distributorID;
}
