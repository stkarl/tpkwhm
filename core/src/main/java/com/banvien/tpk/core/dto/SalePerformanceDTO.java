package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Customer;
import com.banvien.tpk.core.domain.User;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by KhanhChu on 20/11/2017.
 */
public class SalePerformanceDTO implements Serializable {
    private User salesman;
    private Map<String, SalesByDateDTO> salesByDates = new HashMap<String, SalesByDateDTO>();
    private Double totalWeight = 0d;
    private int totalCustomer = 0;
    Map<Customer, Double> customerConsumption = new HashMap<Customer, Double>();

    public SalePerformanceDTO() {
    }

    public SalePerformanceDTO(User createdBy) {
        salesman = createdBy;
    }

    public User getSalesman() {
        return salesman;
    }

    public void setSalesman(User salesman) {
        this.salesman = salesman;
    }

    public Map<String, SalesByDateDTO> getSalesByDates() {
        return salesByDates;
    }

    public void setSalesByDates(Map<String, SalesByDateDTO> salesByDates) {
        this.salesByDates = salesByDates;
    }

    public Double getTotalWeight() {
        return totalWeight;
    }

    public void setTotalWeight(Double totalWeight) {
        this.totalWeight = totalWeight;
    }

    public int getTotalCustomer() {
        return totalCustomer;
    }

    public void setTotalCustomer(int totalCustomer) {
        this.totalCustomer = totalCustomer;
    }

    public Map<Customer, Double> getCustomerConsumption() {
        return customerConsumption;
    }

    public void setCustomerConsumption(Map<Customer, Double> customerConsumption) {
        this.customerConsumption = customerConsumption;
    }
}
