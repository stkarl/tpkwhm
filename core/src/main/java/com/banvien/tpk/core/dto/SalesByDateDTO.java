package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Customer;
import com.banvien.tpk.core.domain.User;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by KhanhChu on 12/9/2017.
 */
public class SalesByDateDTO implements Serializable {
    private User salesman;
    private Timestamp date;
    private double weight = 0d;
    private int noCustomer = 0;
    Map<Customer, Double> customerConsumption = new HashMap<Customer, Double>();

    public SalesByDateDTO(Timestamp confirmedDate, User createdBy) {
        date = confirmedDate;
        salesman = createdBy;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public int getNoCustomer() {
        return noCustomer;
    }

    public void setNoCustomer(int noCustomer) {
        this.noCustomer = noCustomer;
    }

    public Map<Customer, Double> getCustomerConsumption() {
        return customerConsumption;
    }

    public void setCustomerConsumption(Map<Customer, Double> customerConsumption) {
        this.customerConsumption = customerConsumption;
    }

    public User getSalesman() {
        return salesman;
    }

    public void setSalesman(User salesman) {
        this.salesman = salesman;
    }
}
