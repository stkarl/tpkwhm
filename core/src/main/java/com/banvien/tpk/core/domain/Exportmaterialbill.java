package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE exportmaterialbill</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Exportmaterialbill implements Serializable {

	/**
	 * Attribute exportMaterialBillID.
	 */
	private Long exportMaterialBillID;
	
	/**
	 * Attribute receiver.
	 */
	private String receiver;
	
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

    private User confirmedBy;

    private Timestamp confirmedDate;

    /**
	 * List of Exportmaterial
	 */
	private List<Exportmaterial> exportmaterials = null;

    private ProductionPlan productionPlan;

    private List<ExportMaterialBillLog> logs;

    private Customer customer;

    private Machine machine;

    private Machinecomponent machinecomponent;

    private Boolean editable = Boolean.FALSE;

    private Boolean deletable = Boolean.FALSE;

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

    public Machine getMachine() {
        return machine;
    }

    public void setMachine(Machine machine) {
        this.machine = machine;
    }

    public Machinecomponent getMachinecomponent() {
        return machinecomponent;
    }

    public void setMachinecomponent(Machinecomponent machinecomponent) {
        this.machinecomponent = machinecomponent;
    }

    public User getConfirmedBy() {
        return confirmedBy;
    }

    public void setConfirmedBy(User confirmedBy) {
        this.confirmedBy = confirmedBy;
    }

    public Timestamp getConfirmedDate() {
        return confirmedDate;
    }

    public void setConfirmedDate(Timestamp confirmedDate) {
        this.confirmedDate = confirmedDate;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public List<ExportMaterialBillLog> getLogs() {
        return logs;
    }

    public void setLogs(List<ExportMaterialBillLog> logs) {
        this.logs = logs;
    }

    public ProductionPlan getProductionPlan() {
        return productionPlan;
    }

    public void setProductionPlan(ProductionPlan productionPlan) {
        this.productionPlan = productionPlan;
    }

    /**
	 * <p> 
	 * </p>
	 * @return exportMaterialBillID
	 */
	public Long getExportMaterialBillID() {
		return exportMaterialBillID;
	}

	/**
	 * @param exportMaterialBillID new value for exportMaterialBillID 
	 */
	public void setExportMaterialBillID(Long exportMaterialBillID) {
		this.exportMaterialBillID = exportMaterialBillID;
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
	 * Get the list of Exportmaterial
	 */
	 public List<Exportmaterial> getExportmaterials() {
	 	return this.exportmaterials;
	 }
	 
	/**
	 * Set the list of Exportmaterial
	 */
	 public void setExportmaterials(List<Exportmaterial> exportmaterials) {
	 	this.exportmaterials = exportmaterials;
	 }


}