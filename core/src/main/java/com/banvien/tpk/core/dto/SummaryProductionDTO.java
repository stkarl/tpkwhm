package com.banvien.tpk.core.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/21/14
 * Time: 7:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class SummaryProductionDTO implements Serializable {
    private List<SummaryProductionDetailDTO> summaryProductionDetails;
    private SummaryProductionDetailDTO overallDetail;
    private String materialName;
    private String productName;
    private List<Long> originIDs = new ArrayList<Long>();

    public List<Long> getOriginIDs() {
        return originIDs;
    }

    public void setOriginIDs(List<Long> originIDs) {
        this.originIDs = originIDs;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public List<SummaryProductionDetailDTO> getSummaryProductionDetails() {
        return summaryProductionDetails;
    }

    public void setSummaryProductionDetails(List<SummaryProductionDetailDTO> summaryProductionDetails) {
        this.summaryProductionDetails = summaryProductionDetails;
    }

    public SummaryProductionDetailDTO getOverallDetail() {
        return overallDetail;
    }

    public void setOverallDetail(SummaryProductionDetailDTO overallDetail) {
        this.overallDetail = overallDetail;
    }
}
