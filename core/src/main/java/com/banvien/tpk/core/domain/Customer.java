package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE customer</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Customer implements Serializable {

	/**
	 * Attribute customerID.
	 */
	private Long customerID;
	
	/**
	 * Attribute name.
	 */
	private String name;
	
	/**
	 * Attribute address.
	 */
	private String address;
	
	/**
	 * Attribute region
	 */
	 private Region region;	

	/**
	 * Attribute province
	 */
	 private Province province;	

	/**
	 * Attribute birthday.
	 */
	private Timestamp birthday;
	
	/**
	 * Attribute owe.
	 */
	private Double owe;
	
	/**
	 * Attribute limit.
	 */
	private Double oweLimit;
	
	/**
	 * Attribute lastPayDate.
	 */
	private Timestamp lastPayDate;
	
	/**
	 * Attribute dayAllow.
	 */
	private Integer dayAllow;
	
	/**
	 * Attribute status.
	 */
	private Integer status;

    private User createdBy;

    private List<OweLog> oweLogs;

    private String phone;

    private String fax;
    private String company;
    private String contact;
    private String contactPhone;

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public List<OweLog> getOweLogs() {
        return oweLogs;
    }

    public void setOweLogs(List<OweLog> oweLogs) {
        this.oweLogs = oweLogs;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    /**
	 * <p> 
	 * </p>
	 * @return customerID
	 */
	public Long getCustomerID() {
		return customerID;
	}

	/**
	 * @param customerID new value for customerID 
	 */
	public void setCustomerID(Long customerID) {
		this.customerID = customerID;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name new value for name 
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address new value for address 
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	
	/**
	 * get region
	 */
	public Region getRegion() {
		return this.region;
	}
	
	/**
	 * set region
	 */
	public void setRegion(Region region) {
		this.region = region;
	}

	/**
	 * get province
	 */
	public Province getProvince() {
		return this.province;
	}
	
	/**
	 * set province
	 */
	public void setProvince(Province province) {
		this.province = province;
	}

	/**
	 * <p> 
	 * </p>
	 * @return birthday
	 */
	public Timestamp getBirthday() {
		return birthday;
	}

	/**
	 * @param birthday new value for birthday 
	 */
	public void setBirthday(Timestamp birthday) {
		this.birthday = birthday;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return owe
	 */
	public Double getOwe() {
		return owe;
	}

	/**
	 * @param owe new value for owe 
	 */
	public void setOwe(Double owe) {
		this.owe = owe;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return limit
	 */
    public Double getOweLimit() {
        return oweLimit;
    }

    public void setOweLimit(Double oweLimit) {
        this.oweLimit = oweLimit;
    }

    /**
	 * <p> 
	 * </p>
	 * @return lastPayDate
	 */
	public Timestamp getLastPayDate() {
		return lastPayDate;
	}

	/**
	 * @param lastPayDate new value for lastPayDate 
	 */
	public void setLastPayDate(Timestamp lastPayDate) {
		this.lastPayDate = lastPayDate;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return dayAllow
	 */
	public Integer getDayAllow() {
		return dayAllow;
	}

	/**
	 * @param dayAllow new value for dayAllow 
	 */
	public void setDayAllow(Integer dayAllow) {
		this.dayAllow = dayAllow;
	}
	
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

}