package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importmaterial;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

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
public class SearchMaterialBean extends AbstractBean<Importmaterial> {
    public SearchMaterialBean(){
        this.pojo = new Importmaterial();
    }

    public SearchMaterialBean(Date fromImportedDate, Date toImportedDate, String code, Long warehouseID, Long materialID,
                              Long marketID, Long originID, Date expiredDate,Long materialCategoryID,
                              Double fromQuantity, Double toQuantity) {
        this.fromImportedDate = fromImportedDate;
        this.toImportedDate = toImportedDate;
        this.code = code;
        this.warehouseID = warehouseID;
        this.materialID = materialID;
        this.marketID = marketID;
        this.originID = originID;
        this.expiredDate = expiredDate;
        this.materialCategoryID = materialCategoryID;
        this.fromQuantity = fromQuantity;
        this.toQuantity = toQuantity;
    }

    private Long materialCategoryID;
    private Date fromImportedDate;
    private Date toImportedDate;
    private String code;
    private Long warehouseID;
    private Long materialID;
    private Long marketID;
    private Long originID;
    private Long warehouseMapID;
    private Date expiredDate;

    private Boolean isForExport = Boolean.FALSE;

    private List<SelectedItemDTO> selectedItems = LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(SelectedItemDTO.class));

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

    public Long getWarehouseMapID() {
        return warehouseMapID;
    }

    public void setWarehouseMapID(Long warehouseMapID) {
        this.warehouseMapID = warehouseMapID;
    }

    public List<SelectedItemDTO> getSelectedItems() {
        return selectedItems;
    }

    public void setSelectedItems(List<SelectedItemDTO> selectedItems) {
        this.selectedItems = selectedItems;
    }

    public Boolean getForExport() {
        return isForExport;
    }

    public void setForExport(Boolean forExport) {
        isForExport = forExport;
    }

    public Long getMaterialCategoryID() {
        return materialCategoryID;
    }

    public void setMaterialCategoryID(Long materialCategoryID) {
        this.materialCategoryID = materialCategoryID;
    }

    public Long getMaterialID() {
        return materialID;
    }

    public void setMaterialID(Long materialID) {
        this.materialID = materialID;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public Date getFromImportedDate() {
        return fromImportedDate;
    }

    public void setFromImportedDate(Date fromImportedDate) {
        this.fromImportedDate = fromImportedDate;
    }

    public Date getToImportedDate() {
        return toImportedDate;
    }

    public void setToImportedDate(Date toImportedDate) {
        this.toImportedDate = toImportedDate;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Long getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(Long warehouseID) {
        this.warehouseID = warehouseID;
    }

    public Long getMarketID() {
        return marketID;
    }

    public void setMarketID(Long marketID) {
        this.marketID = marketID;
    }

    public Long getOriginID() {
        return originID;
    }

    public void setOriginID(Long originID) {
        this.originID = originID;
    }
}
