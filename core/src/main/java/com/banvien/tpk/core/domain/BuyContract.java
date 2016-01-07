package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 9/23/14
 * Time: 9:27 PM
 * To change this template use File | Settings | File Templates.
 */
public class BuyContract implements Serializable {
    private Long buyContractID;
    private String code;
    private Timestamp date;
    private Customer customer;
    private Integer noRoll;
    private Double weight;
    private User createdBy;
    private Timestamp createdDate;
    private List<Importproductbill> importProductBills;

    public Long getBuyContractID() {
        return buyContractID;
    }

    public void setBuyContractID(Long buyContractID) {
        this.buyContractID = buyContractID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
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

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public List<Importproductbill> getImportProductBills() {
        return importProductBills;
    }

    public void setImportProductBills(List<Importproductbill> importProductBills) {
        this.importProductBills = importProductBills;
    }
}
