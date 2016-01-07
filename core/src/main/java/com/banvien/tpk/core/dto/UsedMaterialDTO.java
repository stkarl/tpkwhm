package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.*;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 09/04/2014
 * Time: 11:27
 * To change this template use File | Settings | File Templates.
 */
public class UsedMaterialDTO implements Serializable {
    private Productname productName;
    private Material material;
    private Unit unit;
    private Double totalUsed;
    private Double totalKgUsed;
    private Double totalMUsed;
    private String note;
    private Double cost;
    private Double totalCost;
    private Timestamp startDate;
    private Timestamp endDate;
    private String width;
    private Size size;
    private ProductionPlan plan;
    private List<UsedMaterialDTO> usedMaterialDTOs = new ArrayList<UsedMaterialDTO>();

    public UsedMaterialDTO() {
    }

    public UsedMaterialDTO(Productname productName, Material material, Unit unit, Double totalUsed, Double totalKgUsed, Double totalMUsed, String note, Double cost, Double totalCost, Timestamp startDate, Timestamp endDate, String width, Size size, ProductionPlan plan, List<UsedMaterialDTO> usedMaterialDTOs) {
        this.productName = productName;
        this.material = material;
        this.unit = unit;
        this.totalUsed = totalUsed;
        this.totalKgUsed = totalKgUsed;
        this.totalMUsed = totalMUsed;
        this.note = note;
        this.cost = cost;
        this.totalCost = totalCost;
        this.startDate = startDate;
        this.endDate = endDate;
        this.width = width;
        this.size = size;
        this.plan = plan;
        this.usedMaterialDTOs = usedMaterialDTOs;
    }

    public UsedMaterialDTO(UsedMaterialDTO usedMaterialDTO) {
        this.productName = usedMaterialDTO.getProductName();
        this.material = usedMaterialDTO.getMaterial();
        this.unit = usedMaterialDTO.getUnit();
        this.totalUsed = usedMaterialDTO.getTotalUsed();
        this.totalKgUsed = usedMaterialDTO.getTotalKgUsed();
        this.totalMUsed = usedMaterialDTO.getTotalMUsed();
        this.note = usedMaterialDTO.getNote();
        this.cost = usedMaterialDTO.getCost();
        this.totalCost = usedMaterialDTO.getTotalCost();
        this.startDate = usedMaterialDTO.getStartDate();
        this.endDate = usedMaterialDTO.getEndDate();
        this.width = usedMaterialDTO.getWidth();
        this.size = usedMaterialDTO.getSize();
        this.plan = usedMaterialDTO.getPlan();
        this.usedMaterialDTOs = usedMaterialDTO.usedMaterialDTOs;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public List<UsedMaterialDTO> getUsedMaterialDTOs() {
        return usedMaterialDTOs;
    }

    public void setUsedMaterialDTOs(List<UsedMaterialDTO> usedMaterialDTOs) {
        this.usedMaterialDTOs = usedMaterialDTOs;
    }

    public ProductionPlan getPlan() {
        return plan;
    }

    public void setPlan(ProductionPlan plan) {
        this.plan = plan;
    }

    public String getWidth() {
        return width;
    }

    public void setWidth(String width) {
        this.width = width;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public Double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(Double totalCost) {
        this.totalCost = totalCost;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public Unit getUnit() {
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }

    public Productname getProductName() {
        return productName;
    }

    public void setProductName(Productname productName) {
        this.productName = productName;
    }

    public Material getMaterial() {
        return material;
    }

    public void setMaterial(Material material) {
        this.material = material;
    }

    public Double getTotalUsed() {
        return totalUsed;
    }

    public void setTotalUsed(Double totalUsed) {
        this.totalUsed = totalUsed;
    }

    public Double getTotalKgUsed() {
        return totalKgUsed;
    }

    public void setTotalKgUsed(Double totalKgUsed) {
        this.totalKgUsed = totalKgUsed;
    }

    public Double getTotalMUsed() {
        return totalMUsed;
    }

    public void setTotalMUsed(Double totalMUsed) {
        this.totalMUsed = totalMUsed;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}

