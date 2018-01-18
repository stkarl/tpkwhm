package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Customer;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by KhanhChu on 1/14/2018.
 */
public class OweByDateDTO implements Serializable {
    private Customer customer;
    private Map<String, DailyOweDTO> oweByDates = new HashMap<String, DailyOweDTO>();
    private Double initOwe = 0d;
    private Double totalPay = 0d;
    private Double totalBuy = 0d;
    private Double finalOwe = 0d;

    public OweByDateDTO(Customer customer) {
        this.customer = customer;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Double getInitOwe() {
        return initOwe;
    }

    public void setInitOwe(Double initOwe) {
        this.initOwe = initOwe;
    }

    public Double getFinalOwe() {
        return finalOwe;
    }

    public void setFinalOwe(Double finalOwe) {
        this.finalOwe = finalOwe;
    }

    public Map<String, DailyOweDTO> getOweByDates() {
        return oweByDates;
    }

    public void setOweByDates(Map<String, DailyOweDTO> oweByDates) {
        this.oweByDates = oweByDates;
    }

    public Double getTotalPay() {
        return totalPay;
    }

    public void setTotalPay(Double totalPay) {
        this.totalPay = totalPay;
    }

    public Double getTotalBuy() {
        return totalBuy;
    }

    public void setTotalBuy(Double totalBuy) {
        this.totalBuy = totalBuy;
    }
}
