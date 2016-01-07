package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importmaterialbill;
import org.apache.commons.collections.list.LazyList;
import org.apache.commons.collections.FactoryUtils;


import java.security.Timestamp;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class ImportmaterialbillBean extends AbstractBean<Importmaterialbill> {
    public ImportmaterialbillBean(){
        this.pojo = new Importmaterialbill();
    }
    private List<ItemInfoDTO> itemInfos =  LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(ItemInfoDTO.class));

    private Date fromDate;

    private Date toDate;

    private Long warehouseID;

    private Long supplierID;

    private String code;

    private Long materialID;

    private Long originID;

    private Timestamp expiredDate;

    private Map<Long,Double> materialMoneyMap;

    public Map<Long, Double> getMaterialMoneyMap() {
        return materialMoneyMap;
    }

    private List<ImportMaterialDataDTO> importMaterialDataDTOs;

    public List<ImportMaterialDataDTO> getImportMaterialDataDTOs() {
        return importMaterialDataDTOs;
    }

    public void setImportMaterialDataDTOs(List<ImportMaterialDataDTO> importMaterialDataDTOs) {
        this.importMaterialDataDTOs = importMaterialDataDTOs;
    }

    public void setMaterialMoneyMap(Map<Long, Double> materialMoneyMap) {
        this.materialMoneyMap = materialMoneyMap;
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

    public List<ItemInfoDTO> getItemInfos() {
        return itemInfos;
    }

    public void setItemInfos(List<ItemInfoDTO> itemInfos) {
        this.itemInfos = itemInfos;
    }
}
