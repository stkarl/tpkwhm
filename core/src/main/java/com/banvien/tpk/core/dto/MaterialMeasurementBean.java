package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.domain.MaterialMeasurement;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 18/02/14
 * Time: 22:14
 * To change this template use File | Settings | File Templates.
 */
public class MaterialMeasurementBean extends AbstractBean<MaterialMeasurement> {
    public MaterialMeasurementBean(){
        this.pojo = new MaterialMeasurement();
    }
    private Date fromDate;
    private Date toDate;
    private Long warehouseID;
    private List<MeasurementDTO> measurements = LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(MeasurementDTO.class));

    public List<MeasurementDTO> getMeasurements() {
        return measurements;
    }

    public void setMeasurements(List<MeasurementDTO> measurements) {
        this.measurements = measurements;
    }

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    public Long getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(Long warehouseID) {
        this.warehouseID = warehouseID;
    }
}
