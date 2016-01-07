package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.*;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 20/02/14
 * Time: 23:09
 * To change this template use File | Settings | File Templates.
 */
public class ItemInfoDTO implements Serializable {
    private Long itemID;
    private Size size;
    private String code;
    private Timestamp expiredDate;
    private Double quantityM;
    private Double quantityKg;
    private Double quantityPure;
    private Double quantityOverall;
    private Double quantityActual;
    private Double money;
    private Origin origin;
    private Thickness thickness;

    private Double quantity;
    private Material material;
    private Productname productName;
    private Colour colour;
    private Market market;
    private String core;
    private String note;
    private String produceTeam;
    private Map<Long,Double> qualityQuantityMap;
    private Stiffness stiffness;
    private Overlaytype overlayType;
    private WarehouseMap warehouseMap;
    private Double usedQuantity;

    public Double getQuantityPure() {
        return quantityPure;
    }

    public void setQuantityPure(Double quantityPure) {
        this.quantityPure = quantityPure;
    }

    public Double getQuantityOverall() {
        return quantityOverall;
    }

    public void setQuantityOverall(Double quantityOverall) {
        this.quantityOverall = quantityOverall;
    }

    public Double getQuantityActual() {
        return quantityActual;
    }

    public void setQuantityActual(Double quantityActual) {
        this.quantityActual = quantityActual;
    }

    public Double getUsedQuantity() {
        return usedQuantity;
    }

    public void setUsedQuantity(Double usedQuantity) {
        this.usedQuantity = usedQuantity;
    }

    public WarehouseMap getWarehouseMap() {
        return warehouseMap;
    }

    public void setWarehouseMap(WarehouseMap warehouseMap) {
        this.warehouseMap = warehouseMap;
    }

    public Overlaytype getOverlayType() {
        return overlayType;
    }

    public void setOverlayType(Overlaytype overlayType) {
        this.overlayType = overlayType;
    }

    public Stiffness getStiffness() {
        return stiffness;
    }

    public void setStiffness(Stiffness stiffness) {
        this.stiffness = stiffness;
    }

    public String getProduceTeam() {
        return produceTeam;
    }

    public void setProduceTeam(String produceTeam) {
        this.produceTeam = produceTeam;
    }

    public Map<Long, Double> getQualityQuantityMap() {
        return qualityQuantityMap;
    }

    public void setQualityQuantityMap(Map<Long, Double> qualityQuantityMap) {
        this.qualityQuantityMap = qualityQuantityMap;
    }

    public Market getMarket() {
        return market;
    }

    public void setMarket(Market market) {
        this.market = market;
    }


    public String getCore() {
        return core;
    }

    public void setCore(String core) {
        this.core = core;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Colour getColour() {
        return colour;
    }

    public void setColour(Colour colour) {
        this.colour = colour;
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

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public Thickness getThickness() {
        return thickness;
    }

    public void setThickness(Thickness thickness) {
        this.thickness = thickness;
    }

    public Long getItemID() {
        return itemID;
    }

    public void setItemID(Long itemID) {
        this.itemID = itemID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Timestamp getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Timestamp expiredDate) {
        this.expiredDate = expiredDate;
    }

    public Double getQuantityM() {
        return quantityM;
    }

    public void setQuantityM(Double quantityM) {
        this.quantityM = quantityM;
    }

    public Double getQuantityKg() {
        return quantityKg;
    }

    public void setQuantityKg(Double quantityKg) {
        this.quantityKg = quantityKg;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Origin getOrigin() {
        return origin;
    }

    public void setOrigin(Origin origin) {
        this.origin = origin;
    }
}
