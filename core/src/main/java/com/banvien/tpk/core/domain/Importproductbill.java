package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE importproductbill</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Importproductbill implements Serializable {

	/**
	 * Attribute importProductBillID.
	 */
	private Long importProductBillID;
	
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
	 * Attribute createdDate.
	 */
	private Timestamp createdDate;
	
	/**
	 * Attribute produceDate.
	 */
	private Timestamp produceDate;
	
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
	 private User UpdatedBy;

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
	 * Attribute produceGroup.
	 */
	private String produceGroup;
	
	/**
	 * List of Importproduct
	 */
	private List<Importproduct> importproducts = null;

    private List<ImportProductBillLog> logs;

    private Market market;

    private Customer customer;

    private User confirmedBy;

    private Timestamp confirmedDate;

    private ProductionPlan productionPlan;

    private WarehouseMap warehouseMap;

    private Boolean editable = Boolean.FALSE;

    private Boolean deletable = Boolean.FALSE;

    private Importproductbill parentBill;

    private BuyContract buyContract;

    private Exportproductbill exportProductBill;

    private Boolean tempBill;

    public Boolean getTempBill() {
        return tempBill;
    }

    public void setTempBill(Boolean tempBill) {
        this.tempBill = tempBill;
    }

    public Exportproductbill getExportProductBill() {
        return exportProductBill;
    }

    public void setExportProductBill(Exportproductbill exportProductBill) {
        this.exportProductBill = exportProductBill;
    }

    public BuyContract getBuyContract() {
        return buyContract;
    }

    public void setBuyContract(BuyContract buyContract) {
        this.buyContract = buyContract;
    }

    public Importproductbill getParentBill() {
        return parentBill;
    }

    public void setParentBill(Importproductbill parentBill) {
        this.parentBill = parentBill;
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

    public List<ImportProductBillLog> getLogs() {
        return logs;
    }

    public void setLogs(List<ImportProductBillLog> logs) {
        this.logs = logs;
    }

    public ProductionPlan getProductionPlan() {
        return productionPlan;
    }

    public void setProductionPlan(ProductionPlan productionPlan) {
        this.productionPlan = productionPlan;
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

    public Market getMarket() {
        return market;
    }

    public void setMarket(Market market) {
        this.market = market;
    }

    /**
	 * <p> 
	 * </p>
	 * @return importProductBillID
	 */
	public Long getImportProductBillID() {
		return importProductBillID;
	}

	/**
	 * @param importProductBillID new value for importProductBillID 
	 */
	public void setImportProductBillID(Long importProductBillID) {
		this.importProductBillID = importProductBillID;
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
	 * @return produceDate
	 */
	public Timestamp getProduceDate() {
		return produceDate;
	}

	/**
	 * @param produceDate new value for produceDate 
	 */
	public void setProduceDate(Timestamp produceDate) {
		this.produceDate = produceDate;
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
	
	/**
	 * <p> 
	 * </p>
	 * @return produceGroup
	 */
	public String getProduceGroup() {
		return produceGroup;
	}

	/**
	 * @param produceGroup new value for produceGroup 
	 */
	public void setProduceGroup(String produceGroup) {
		this.produceGroup = produceGroup;
	}
	
	/**
	 * Get the list of Importproduct
	 */
	 public List<Importproduct> getImportproducts() {
	 	return this.importproducts;
	 }
	 
	/**
	 * Set the list of Importproduct
	 */
	 public void setImportproducts(List<Importproduct> importproducts) {
	 	this.importproducts = importproducts;
	 }


    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public User getUpdatedBy() {
        return UpdatedBy;
    }

    public void setUpdatedBy(User updatedBy) {
        UpdatedBy = updatedBy;
    }
}