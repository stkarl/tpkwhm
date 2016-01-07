package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.BuyContract;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.Importproductbill;
import com.banvien.tpk.core.domain.ProductionPlan;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 20/02/14
 * Time: 23:09
 * To change this template use File | Settings | File Templates.
 */
public class BuyContractDTO implements Serializable {
    private Long buyContractID;
    private Integer noRoll;
    private Double weight;
    private String code;
    private Long customerID;
    private String customerName;
    private Timestamp startDate;
    private Timestamp endDate;
    private List<Importproductbill> importProductBills;
    private List<Importproduct> importProducts;
    private Double totalWeight;
    private Double totalMoney;

    public BuyContractDTO() {
    }

    public BuyContractDTO(BuyContract buyContract) {
        this.buyContractID = buyContract.getBuyContractID();
        this.weight = buyContract.getWeight();
        this.code = buyContract.getCode();
        this.customerID = buyContract.getCustomer().getCustomerID();
        this.customerName = buyContract.getCustomer().getName();
        this.startDate = buyContract.getDate();
    }

    public Double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(Double totalMoney) {
        this.totalMoney = totalMoney;
    }

    public List<Importproductbill> getImportProductBills() {
        return importProductBills;
    }

    public void setImportProductBills(List<Importproductbill> importProductBills) {
        this.importProductBills = importProductBills;
    }

    public List<Importproduct> getImportProducts() {
        return importProducts;
    }

    public void setImportProducts(List<Importproduct> importProducts) {
        this.importProducts = importProducts;
    }

    public Double getTotalWeight() {
        return totalWeight;
    }

    public void setTotalWeight(Double totalWeight) {
        this.totalWeight = totalWeight;
    }

    public Long getBuyContractID() {
        return buyContractID;
    }

    public void setBuyContractID(Long buyContractID) {
        this.buyContractID = buyContractID;
    }

    public Integer getNoRoll() {
        return noRoll;
    }

    public void setNoRoll(Integer noRoll) {
        this.noRoll = noRoll;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Long getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Long customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
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
}
