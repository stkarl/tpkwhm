package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.User;

import java.util.List;

/**
 * User: BAN
 * Date: 6/21/12
 * Time: 12:19 PM
 */
public class UserDTO {
    public Long getUserID() {
        return userID;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }


    private Long userID;

	/**
	 * Attribute username.
	 */
	private String userName;

	/**
	 * Attribute password
	 */
	 private String password;

	/**
	 * Attribute fullname.
	 */
	private String fullName;

    /**
     * Attribute LiveManager.
     */
    private String liveManager;

    public String getLiveManager() {
        return liveManager;
    }

    public void setLiveManager(String liveManager) {
        this.liveManager = liveManager;
    }

    public String getDistributorName() {
        return distributorName;
    }

    public void setDistributorName(String distributorName) {
        this.distributorName = distributorName;
    }

    /**
   	 * Attribute Distributor Name.
   	 */
   	private String distributorName;

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getSuccess() {
        return success;
    }

    public void setSuccess(String success) {
        this.success = success;
    }

    /**
   	 * Attribute role.
   	 */
   	private String success;

    /**
   	 * Attribute role.
   	 */
   	private String role;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    /**
   	 * Attribute email.
   	 */
    private String email;

    /**
   	 * Attribute status.
   	 */
    private Integer status;


    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }


    public List<String> getDistributor() {
        return distributor;
    }

    public void setDistributor(List<String> distributor) {
        this.distributor = distributor;
    }

    /**
   	 * Attribute distributor.
   	 */
    private List<String> distributor;

    /**
   	 * Attribute region.
   	 */
    private String region;



    public UserDTO(User b) {
        setUserName(b.getUserName());
        setFullName(b.getFullname());
        setPassword(b.getPassword());
        setEmail(b.getEmail());
        setStatus(b.getStatus());
        setRole(b.getRole());
        setUserID(b.getUserID());
    }

    public UserDTO() {

    }
}
