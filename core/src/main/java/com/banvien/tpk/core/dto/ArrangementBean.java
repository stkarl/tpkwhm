package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Arrangement;
import com.banvien.tpk.core.domain.ArrangementDetail;
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
public class ArrangementBean extends AbstractBean<Arrangement> {
    public ArrangementBean(){
        this.pojo = new Arrangement();
    }

    private Date fromDate;
    private Date toDate;
    private List<ArrangementDetail> arrangementDetails = LazyList.decorate(new ArrayList(), FactoryUtils.instantiateFactory(ArrangementDetail.class));

    public List<ArrangementDetail> getArrangementDetails() {
        return arrangementDetails;
    }

    public void setArrangementDetails(List<ArrangementDetail> arrangementDetails) {
        this.arrangementDetails = arrangementDetails;
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
}
