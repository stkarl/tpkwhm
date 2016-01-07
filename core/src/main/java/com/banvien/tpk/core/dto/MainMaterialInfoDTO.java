package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.*;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 20/02/14
 * Time: 23:09
 * To change this template use File | Settings | File Templates.
 */
public class MainMaterialInfoDTO implements Serializable {
    private Long itemID;
    private Double cutOff;
    private Double importBack;
    private Double totalM;
    private Double usedMet;

    private Double totalKg;
    private List<ItemInfoDTO> itemInfos =  LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(ItemInfoDTO.class));
    private String detailInfo;
    private List<Importproduct> importproducts;
    private Map<Long,List<Importproduct>> materialProductsMap;
    private String mainMaterialCode;
    private String mainMaterialName;
    private String mainMaterialSize;
    private String mainMaterialSpecific;

    public Double getUsedMet() {
        return usedMet;
    }

    public void setUsedMet(Double usedMet) {
        this.usedMet = usedMet;
    }

    public Double getImportBack() {
        return importBack;
    }

    public void setImportBack(Double importBack) {
        this.importBack = importBack;
    }

    public Double getTotalKg() {
        return totalKg;
    }

    public void setTotalKg(Double totalKg) {
        this.totalKg = totalKg;
    }

    public String getMainMaterialName() {
        return mainMaterialName;
    }

    public void setMainMaterialName(String mainMaterialName) {
        this.mainMaterialName = mainMaterialName;
    }

    public String getMainMaterialSize() {
        return mainMaterialSize;
    }

    public void setMainMaterialSize(String mainMaterialSize) {
        this.mainMaterialSize = mainMaterialSize;
    }

    public String getMainMaterialSpecific() {
        return mainMaterialSpecific;
    }

    public void setMainMaterialSpecific(String mainMaterialSpecific) {
        this.mainMaterialSpecific = mainMaterialSpecific;
    }

    public Double getTotalM() {
        return totalM;
    }

    public void setTotalM(Double totalM) {
        this.totalM = totalM;
    }

    public String getMainMaterialCode() {
        return mainMaterialCode;
    }

    public void setMainMaterialCode(String mainMaterialCode) {
        this.mainMaterialCode = mainMaterialCode;
    }

    public Map<Long, List<Importproduct>> getMaterialProductsMap() {
        return materialProductsMap;
    }

    public void setMaterialProductsMap(Map<Long, List<Importproduct>> materialProductsMap) {
        this.materialProductsMap = materialProductsMap;
    }

    public List<Importproduct> getImportproducts() {
        return importproducts;
    }

    public void setImportproducts(List<Importproduct> importproducts) {
        this.importproducts = importproducts;
    }

    public String getDetailInfo() {
        return detailInfo;
    }

    public void setDetailInfo(String detailInfo) {
        this.detailInfo = detailInfo;
    }

    public List<ItemInfoDTO> getItemInfos() {
        return itemInfos;
    }

    public void setItemInfos(List<ItemInfoDTO> itemInfos) {
        this.itemInfos = itemInfos;
    }

    public void setItemID(Long itemID) {
        this.itemID = itemID;
    }

    public Long getItemID() {
        return itemID;
    }

    public Double getCutOff() {
        return cutOff;
    }

    public void setCutOff(Double cutOff) {
        this.cutOff = cutOff;
    }

}
