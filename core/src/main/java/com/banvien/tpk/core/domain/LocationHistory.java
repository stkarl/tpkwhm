package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE locationhistory</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class LocationHistory implements Serializable {

	/**
	 * Attribute locationHistoryID.
	 */
	private Long locationHistoryID;
    private Timestamp createdDate;
    private User createdBy;
    private Importproduct importProduct;
    private Importmaterial importMaterial;
    private WarehouseMap oldLocation;
    private WarehouseMap newLocation;
    private Warehouse warehouse;

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public Long getLocationHistoryID() {
        return locationHistoryID;
    }

    public void setLocationHistoryID(Long locationHistoryID) {
        this.locationHistoryID = locationHistoryID;
    }

    public Importproduct getImportProduct() {
        return importProduct;
    }

    public void setImportProduct(Importproduct importProduct) {
        this.importProduct = importProduct;
    }

    public Importmaterial getImportMaterial() {
        return importMaterial;
    }

    public void setImportMaterial(Importmaterial importMaterial) {
        this.importMaterial = importMaterial;
    }

    public WarehouseMap getOldLocation() {
        return oldLocation;
    }

    public void setOldLocation(WarehouseMap oldLocation) {
        this.oldLocation = oldLocation;
    }

    public WarehouseMap getNewLocation() {
        return newLocation;
    }

    public void setNewLocation(WarehouseMap newLocation) {
        this.newLocation = newLocation;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
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
	 * @return locationHistoryID
	 */
	public Long getlocationHistoryID() {
		return locationHistoryID;
	}

	/**
	 * @param locationHistoryID new value for locationHistoryID 
	 */
	public void setlocationHistoryID(Long locationHistoryID) {
		this.locationHistoryID = locationHistoryID;
    }

}