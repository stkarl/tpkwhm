package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Exportmaterialbill;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.security.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class ExportmaterialbillBean extends AbstractBean<Exportmaterialbill> {
    public ExportmaterialbillBean(){
        this.pojo = new Exportmaterialbill();
    }

    private List<ItemInfoDTO> itemInfos =  LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(ItemInfoDTO.class));

    private Date fromDate;

    private Date toDate;

    private Long warehouseID;

    private Long supplierID;

    private String code;

    private Long materialID;

    private Long originID;

    private Date expiredDate;

    private Long exportTypeID;

    private Long customerID;

    private Long marketID;

    private Long materialCategoryID;

    private Long productionPlanID;

    private Double fromQuantity;

    private Double toQuantity;

    public Double getFromQuantity() {
        return fromQuantity;
    }

    public void setFromQuantity(Double fromQuantity) {
        this.fromQuantity = fromQuantity;
    }

    public Double getToQuantity() {
        return toQuantity;
    }

    public void setToQuantity(Double toQuantity) {
        this.toQuantity = toQuantity;
    }

    public Long getProductionPlanID() {
        return productionPlanID;
    }

    public void setProductionPlanID(Long productionPlanID) {
        this.productionPlanID = productionPlanID;
    }

    public Long getMaterialCategoryID() {
        return materialCategoryID;
    }

    public void setMaterialCategoryID(Long materialCategoryID) {
        this.materialCategoryID = materialCategoryID;
    }

    public Long getMarketID() {
        return marketID;
    }

    public void setMarketID(Long marketID) {
        this.marketID = marketID;
    }

    public Long getExportTypeID() {
        return exportTypeID;
    }

    public void setExportTypeID(Long exportTypeID) {
        this.exportTypeID = exportTypeID;
    }

    public Long getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Long customerID) {
        this.customerID = customerID;
    }

    public List<ItemInfoDTO> getItemInfos() {
        return itemInfos;
    }

    public void setItemInfos(List<ItemInfoDTO> itemInfos) {
        this.itemInfos = itemInfos;
    }

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    public Long getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(Long warehouseID) {
        this.warehouseID = warehouseID;
    }

    public Long getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(Long supplierID) {
        this.supplierID = supplierID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Long getMaterialID() {
        return materialID;
    }

    public void setMaterialID(Long materialID) {
        this.materialID = materialID;
    }

    public Long getOriginID() {
        return originID;
    }

    public void setOriginID(Long originID) {
        this.originID = originID;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }
}
