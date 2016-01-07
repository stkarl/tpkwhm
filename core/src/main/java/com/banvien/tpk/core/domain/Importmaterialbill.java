package com.banvien.tpk.core.domain;

import com.banvien.tpk.core.Constants;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE importmaterialbill</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Importmaterialbill implements Serializable {

	/**
	 * Attribute importMaterialBillID.
	 */
	private Long importMaterialBillID;
	
	/**
	 * Attribute customer
	 */
	 private Customer customer;	

	/**
	 * Attribute warehouse
	 */
	 private Warehouse warehouse;	

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
	 * Attribute importDate.
	 */
	private Timestamp importDate;
	
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
	 * Attribute totalMoney.
	 */
	private Double totalMoney;
	
	/**
	 * Attribute note.
	 */
	private String note;
	
	/**
	 * List of Importmaterial
	 */
	private List<Importmaterial> importMaterials = null;

    private List<ImportMaterialBillLog> logs;

    private Market market;

    private User confirmedBy;

    private Timestamp confirmedDate;

    private WarehouseMap warehouseMap;

    private Timestamp createdDate;

    private Boolean editable = Boolean.FALSE;
    private Boolean deletable = Boolean.FALSE;
    private String billGroup = Constants.MATERIAL_GROUP_BUY;

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public String getBillGroup() {
        return billGroup;
    }

    public void setBillGroup(String billGroup) {
        this.billGroup = billGroup;
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

    public WarehouseMap getWarehouseMap() {
        return warehouseMap;
    }

    public void setWarehouseMap(WarehouseMap warehouseMap) {
        this.warehouseMap = warehouseMap;
    }

    public List<ImportMaterialBillLog> getLogs() {
        return logs;
    }

    public void setLogs(List<ImportMaterialBillLog> logs) {
        this.logs = logs;
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

    public Market getMarket() {
        return market;
    }

    public void setMarket(Market market) {
        this.market = market;
    }

    /**
	 * <p> 
	 * </p>
	 * @return importMaterialBillID
	 */
	public Long getImportMaterialBillID() {
		return importMaterialBillID;
	}

	/**
	 * @param importMaterialBillID new value for importMaterialBillID 
	 */
	public void setImportMaterialBillID(Long importMaterialBillID) {
		this.importMaterialBillID = importMaterialBillID;
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
	 * get warehouse
	 */
	public Warehouse getWarehouse() {
		return this.warehouse;
	}
	
	/**
	 * set warehouse
	 */
	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
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

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    /**
	 * <p> 
	 * </p>
	 * @return importDate
	 */
	public Timestamp getImportDate() {
		return importDate;
	}

	/**
	 * @param importDate new value for importDate 
	 */
	public void setImportDate(Timestamp importDate) {
		this.importDate = importDate;
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

    public List<Importmaterial> getImportMaterials() {
        return importMaterials;
    }

    public void setImportMaterials(List<Importmaterial> importMaterials) {
        this.importMaterials = importMaterials;
    }
}