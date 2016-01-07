package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.PriceBank;
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
public class PriceBankBean extends AbstractBean<PriceBank> {
    public PriceBankBean(){
        this.pojo = new PriceBank();
    }

    private String type;
    private Boolean colour = Boolean.FALSE;
    private Boolean thickness = Boolean.FALSE;
    private Date effectedDate;

    private List<PriceUpdateDTO> priceUpdates = LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(PriceUpdateDTO.class));

    public List<PriceUpdateDTO> getPriceUpdates() {
        return priceUpdates;
    }

    public void setPriceUpdates(List<PriceUpdateDTO> priceUpdates) {
        this.priceUpdates = priceUpdates;
    }

    public Date getEffectedDate() {
        return effectedDate;
    }

    public void setEffectedDate(Date effectedDate) {
        this.effectedDate = effectedDate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Boolean getColour() {
        return colour;
    }

    public void setColour(Boolean colour) {
        this.colour = colour;
    }

    public Boolean getThickness() {
        return thickness;
    }

    public void setThickness(Boolean thickness) {
        this.thickness = thickness;
    }
}
