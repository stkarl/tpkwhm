package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE importmaterial</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 *
 */
public class Importmaterial implements Serializable {

    /**
     * Attribute importMaterialID.
     */
    private Long importMaterialID;

    /**
     * Attribute importmaterialbill
     */
    private Importmaterialbill importmaterialbill;

    /**
     * Attribute material
     */
    private Material material;

    /**
     * Attribute origin
     */
    private Origin origin;

    /**
     * Attribute expiredDate.
     */
    private Timestamp expiredDate;

    /**
     * Attribute quantity1.
     */
    private Double quantity;

    /**
     * Attribute unit
     */

    /**
     * Attribute quantity2.
     */
    private Double remainQuantity;

    /**
     * Attribute money.
     */
    private Double money;

    /**
     * Attribute note.
     */
    private String note;

    /**
     * Attribute market
     */
    private Market market;

    private String code;

    private Warehouse warehouse;

    private WarehouseMap warehouseMap;

    private Integer status;

    private Timestamp importDate;


    private String detailInfo;

    public String getDetailInfo() {
        return detailInfo;
    }

    public void setDetailInfo(String detailInfo) {
        this.detailInfo = detailInfo;
    }

    public Timestamp getImportDate() {
        return importDate;
    }

    public void setImportDate(Timestamp importDate) {
        this.importDate = importDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public WarehouseMap getWarehouseMap() {
        return warehouseMap;
    }

    public void setWarehouseMap(WarehouseMap warehouseMap) {
        this.warehouseMap = warehouseMap;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    /**
     * <p>
     * </p>
     * @return importMaterialID
     */
    public Long getImportMaterialID() {
        return importMaterialID;
    }

    /**
     * @param importMaterialID new value for importMaterialID
     */
    public void setImportMaterialID(Long importMaterialID) {
        this.importMaterialID = importMaterialID;
    }

    /**
     * get importmaterialbill
     */
    public Importmaterialbill getImportmaterialbill() {
        return this.importmaterialbill;
    }

    /**
     * set importmaterialbill
     */
    public void setImportmaterialbill(Importmaterialbill importmaterialbill) {
        this.importmaterialbill = importmaterialbill;
    }

    /**
     * get material
     */
    public Material getMaterial() {
        return this.material;
    }

    /**
     * set material
     */
    public void setMaterial(Material material) {
        this.material = material;
    }

    /**
     * get origin
     */
    public Origin getOrigin() {
        return this.origin;
    }

    /**
     * set origin
     */
    public void setOrigin(Origin origin) {
        this.origin = origin;
    }

    /**
     * <p>
     * </p>
     * @return expiredDate
     */
    public Timestamp getExpiredDate() {
        return expiredDate;
    }

    /**
     * @param expiredDate new value for expiredDate
     */
    public void setExpiredDate(Timestamp expiredDate) {
        this.expiredDate = expiredDate;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    /**
     * get unit
     */



    public Double getRemainQuantity() {
        return remainQuantity;
    }

    public void setRemainQuantity(Double remainQuantity) {
        this.remainQuantity = remainQuantity;
    }

    /**
     * <p>
     * </p>
     * @return money
     */
    public Double getMoney() {
        return money;
    }

    /**
     * @param money new value for money
     */
    public void setMoney(Double money) {
        this.money = money;
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
     * get market
     */
    public Market getMarket() {
        return this.market;
    }

    /**
     * set market
     */
    public void setMarket(Market market) {
        this.market = market;
    }



}