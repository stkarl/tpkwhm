package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;


/**
 * <p>Pojo mapping TABLE exportproductbill</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Exportproductbill implements Serializable {

	/**
	 * Attribute exportProductBillID.
	 */
	private Long exportProductBillID;
	
	/**
	 * Attribute receiver.
	 */
	private String receiver;
	
	/**
	 * Attribute customer
	 */
	 private Customer customer;	

	/**
	 * Attribute exporttype
	 */
	 private Exporttype exporttype;	

	/**
	 * Attribute warehouse
	 */
	 private Warehouse exportWarehouse;

	/**
	 * Attribute warehouse
	 */
	 private Warehouse receiveWarehouse;

	/**
	 * Attribute code.
	 */
	private String code;
	
	/**
	 * Attribute description.
	 */
	private String description;
	
	/**
	 * Attribute user
	 */
	 private User createdBy;

	/**
	 * Attribute createdDate.
	 */
	private Timestamp createdDate;
	
	/**
	 * Attribute exportDate.
	 */
	private Timestamp exportDate;
	
	/**
	 * Attribute status.
	 */
	private Integer status;
	
	/**
	 * Attribute user
	 */
	 private User updatedBy;

	/**
	 * Attribute updatedDate.
	 */
	private Timestamp updatedDate;
	
	/**
	 * Attribute note.
	 */
	private String note;
	
	/**
	 * Attribute totalMoney.
	 */
	private Double totalMoney;
	
	/**
	 * List of Exportproduct
	 */
	private List<Exportproduct> exportproducts = null;

    private List<ExportProductBillLog> logs;

    private Timestamp confirmedDate;

    private User confirmedBy;

    private ProductionPlan productionPlan;

    private Boolean editable = Boolean.FALSE;

    private Boolean deletable = Boolean.FALSE;

    private BookProductBill bookProductBill;

    private Integer sellStatus;

	private String vehicle;

	public String getVehicle() {
		return vehicle;
	}

	public void setVehicle(String vehicle) {
		this.vehicle = vehicle;
	}

	public Integer getSellStatus() {
        return sellStatus;
    }

    public void setSellStatus(Integer sellStatus) {
        this.sellStatus = sellStatus;
    }

    public BookProductBill getBookProductBill() {
        return bookProductBill;
    }

    public void setBookProductBill(BookProductBill bookProductBill) {
        this.bookProductBill = bookProductBill;
    }

    public Boolean getEditable() {
        return editable;
    }

    public void setEditable(Boolean editable) {
        this.editable = editable;
    }

    public Boolean getDeletable() {
        return deletable;
    }

    public void setDeletable(Boolean deletable) {
        this.deletable = deletable;
    }

    public List<ExportProductBillLog> getLogs() {
        return logs;
    }

    public void setLogs(List<ExportProductBillLog> logs) {
        this.logs = logs;
    }

    public ProductionPlan getProductionPlan() {
        return productionPlan;
    }

    public void setProductionPlan(ProductionPlan productionPlan) {
        this.productionPlan = productionPlan;
    }

    public Timestamp getConfirmedDate() {
        return confirmedDate;
    }

    public void setConfirmedDate(Timestamp confirmedDate) {
        this.confirmedDate = confirmedDate;
    }

    public User getConfirmedBy() {
        return confirmedBy;
    }

    public void setConfirmedBy(User confirmedBy) {
        this.confirmedBy = confirmedBy;
    }

    /**
	 * <p> 
	 * </p>
	 * @return exportProductBillID
	 */
	public Long getExportProductBillID() {
		return exportProductBillID;
	}

	/**
	 * @param exportProductBillID new value for exportProductBillID 
	 */
	public void setExportProductBillID(Long exportProductBillID) {
		this.exportProductBillID = exportProductBillID;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return receiver
	 */
	public String getReceiver() {
		return receiver;
	}

	/**
	 * @param receiver new value for receiver 
	 */
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	
	/**
	 * get customer
	 */
	public Customer getCustomer() {
		return this.customer;
	}
	
	/**
	 * set customer
	 */
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	/**
	 * get exporttype
	 */
	public Exporttype getExporttype() {
		return this.exporttype;
	}
	
	/**
	 * set exporttype
	 */
	public void setExporttype(Exporttype exporttype) {
		this.exporttype = exporttype;
	}


	/**
	 * <p> 
	 * </p>
	 * @return code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code new value for code 
	 */
	public void setCode(String code) {
		this.code = code;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description new value for description 
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * <p> 
	 * </p>
	 * @return createdDate
	 */
	public Timestamp getCreatedDate() {
		return createdDate;
	}

	/**
	 * @param createdDate new value for createdDate 
	 */
	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return exportDate
	 */
	public Timestamp getExportDate() {
		return exportDate;
	}

	/**
	 * @param exportDate new value for exportDate 
	 */
	public void setExportDate(Timestamp exportDate) {
		this.exportDate = exportDate;
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

	/**
	 * <p> 
	 * </p>
	 * @return updatedDate
	 */
	public Timestamp getUpdatedDate() {
		return updatedDate;
	}

	/**
	 * @param updatedDate new value for updatedDate 
	 */
	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return note
	 */
	public String getNote() {
		return note;
	}

	/**
	 * @param note new value for note 
	 */
	public void setNote(String note) {
		this.note = note;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return totalMoney
	 */
	public Double getTotalMoney() {
		return totalMoney;
	}

	/**
	 * @param totalMoney new value for totalMoney 
	 */
	public void setTotalMoney(Double totalMoney) {
		this.totalMoney = totalMoney;
	}
	
	/**
	 * Get the list of Exportproduct
	 */
	 public List<Exportproduct> getExportproducts() {
	 	return this.exportproducts;
	 }
	 
	/**
	 * Set the list of Exportproduct
	 */
	 public void setExportproducts(List<Exportproduct> exportproducts) {
	 	this.exportproducts = exportproducts;
	 }

    public Warehouse getExportWarehouse() {
        return exportWarehouse;
    }

    public void setExportWarehouse(Warehouse exportWarehouse) {
        this.exportWarehouse = exportWarehouse;
    }

    public Warehouse getReceiveWarehouse() {
        return receiveWarehouse;
    }

    public void setReceiveWarehouse(Warehouse receiveWarehouse) {
        this.receiveWarehouse = receiveWarehouse;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public User getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(User updatedBy) {
        this.updatedBy = updatedBy;
    }
}