package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.util.List;


/**
 * <p>Pojo mapping TABLE User</p>
 * <p></p>
 *
 * <p>Generated at Thu Jun 14 18:28:11 GMT+07:00 2012</p>
 * @author Salto-db Generator v1.1 / Hibernate pojos and xml mapping files.
 * 
 */
public class User implements Serializable {

    public static final String FIELD_USERNAME = "userName";

    public static final String FIELD_FULLNAME = "fullname";

    public static final String FIELD_EMAIL = "email";

    public static final String FIELD_STATUS = "status";

    public static final String FIELD_USERCODE = "userCode";

    public static final String FIELD_ROLE = "role";





    /**
	 * Attribute userID.
	 */
	private Long userID;
	
	/**
	 * Attribute userName.
	 */
	private String userName;
	
	/**
	 * Attribute password.
	 */
	private String password;
	
	/**
	 * Attribute fullname.
	 */
	private String fullname;
	
	/**
	 * Attribute email.
	 */
	private String email;
	
	/**
	 * Attribute status.
	 */
	private Integer status;
	
	/**
	 * Attribute role.
	 */
	private String role;


    /**
     * Attribute UserCode.
     */
    private String userCode;

    private Warehouse warehouse;

    private String phone;

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    /* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return userID
	 */
	public Long getUserID() {
		return userID;
	}

	/**
	 * @param userID new value for userID 
	 */
	public void setUserID(Long userID) {
		this.userID = userID;
	}
	
	/* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return userName
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName new value for userName 
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	/* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password new value for password 
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	
	/* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return fullname
	 */
	public String getFullname() {
		return fullname;
	}

	/**
	 * @param fullname new value for fullname 
	 */
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
	/* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email new value for email 
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	
	/* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return status
	 */
	public Integer getStatus() {
		return status;
	}

	/**
	 * @param status new value for status 
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	/* liste transiente */
	/**
	 * <p> 
	 * </p>
	 * @return role
	 */
	public String getRole() {
		return role;
	}

	/**
	 * @param role new value for role 
	 */
	public void setRole(String role) {
		this.role = role;
	}

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }
}