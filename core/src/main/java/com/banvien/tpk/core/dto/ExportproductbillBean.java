package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Exportproductbill;
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
public class ExportproductbillBean extends AbstractBean<Exportproductbill> {
    public ExportproductbillBean(){
        this.pojo = new Exportproductbill();
    }
    private List<ItemInfoDTO> itemInfos =  LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(ItemInfoDTO.class));

    private Date fromDate;

    private Date toDate;

    private Long warehouseID;

    private Long supplierID;

    private String code;

    private String productCode;

    private Long materialID;

    private Long originID;

    private Timestamp expiredDate;

    private Long exportTypeID;

    private Long customerID;

    private Boolean isBlackProduct = Boolean.FALSE;

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public Boolean getIsBlackProduct() {
        return isBlackProduct;
    }

    public void setIsBlackProduct(Boolean blackProduct) {
        isBlackProduct = blackProduct;
    }

    public Long getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Long customerID) {
        this.customerID = customerID;
    }

    public Long getExportTypeID() {
        return exportTypeID;
    }

    public void setExportTypeID(Long exportTypeID) {
        this.exportTypeID = exportTypeID;
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

    public Timestamp getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Timestamp expiredDate) {
        this.expiredDate = expiredDate;
    }
}
