package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.Importproductbill;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.security.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class ImportproductbillBean extends AbstractBean<Importproductbill> {
    public ImportproductbillBean(){
        this.pojo = new Importproductbill();
    }

    private List<MainMaterialInfoDTO> mainMaterials =  LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(MainMaterialInfoDTO.class));


    private List<ItemInfoDTO> itemInfos =  LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(ItemInfoDTO.class));

    private List<Importproduct> reImportProducts =  LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(Importproduct.class));

    private Date fromDate;

    private Date toDate;

    private Long warehouseID;

    private Long supplierID;

    private String code;

    private String productCode;

    private Long materialID;

    private Long originID;

    private Timestamp expiredDate;

    private Map<Long,Double> rootMaterialMoneyMap;

    private Long productionPlanID;

    private Boolean isBlackProduct;

    private Boolean isReImport = Boolean.FALSE;

    private ItemInfoDTO productInfo;

    private Boolean tempBill;

    //for merge

    private Long marketID;
    private String description;
    private Date importDate;
    private List<Long> billIDs;

    public Long getMarketID() {
        return marketID;
    }

    public void setMarketID(Long marketID) {
        this.marketID = marketID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public List<Long> getBillIDs() {
        return billIDs;
    }

    public void setBillIDs(List<Long> billIDs) {
        this.billIDs = billIDs;
    }

    public Boolean getTempBill() {
        return tempBill;
    }

    public void setTempBill(Boolean tempBill) {
        this.tempBill = tempBill;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public ItemInfoDTO getProductInfo() {
        return productInfo;
    }

    public void setProductInfo(ItemInfoDTO productInfo) {
        this.productInfo = productInfo;
    }

    public Boolean getReImport() {
        return isReImport;
    }

    public void setReImport(Boolean reImport) {
        isReImport = reImport;
    }

    public List<Importproduct> getReImportProducts() {
        return reImportProducts;
    }

    public void setReImportProducts(List<Importproduct> reImportProducts) {
        this.reImportProducts = reImportProducts;
    }

    public Boolean getIsBlackProduct() {
        return isBlackProduct;
    }

    public void setIsBlackProduct(Boolean blackProduct) {
        isBlackProduct = blackProduct;
    }

    public List<MainMaterialInfoDTO> getMainMaterials() {
        return mainMaterials;
    }

    public void setMainMaterials(List<MainMaterialInfoDTO> mainMaterials) {
        this.mainMaterials = mainMaterials;
    }

    public Long getProductionPlanID() {
        return productionPlanID;
    }

    public void setProductionPlanID(Long productionPlanID) {
        this.productionPlanID = productionPlanID;
    }

    public Map<Long, Double> getRootMaterialMoneyMap() {
        return rootMaterialMoneyMap;
    }

    public void setRootMaterialMoneyMap(Map<Long, Double> rootMaterialMoneyMap) {
        this.rootMaterialMoneyMap = rootMaterialMoneyMap;
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
