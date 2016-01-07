package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Overlaytype;
import com.banvien.tpk.core.domain.Size;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/21/14
 * Time: 7:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class SummaryByOverlayDTO implements Serializable {
    private List<Size> sizes;
    private List<Overlaytype> overlayTypes;
    private Map<Long,Map<Long,SummaryDetailByOverlayDTO>> mapSizeOverlayDetail;
    private Map<Long,SummaryDetailByOverlayDTO> mapTotalSummary;
    private String materialName;
    private String productName;
    private Map<Long,String> mapOverlaySummaryOriginQuantity;
    private Map<Long,List<Long>> mapOverlayOrigins;
    private Map<Long, Map<Long, Double>> mapOverlayOriginQuantity;

    public Map<Long, List<Long>> getMapOverlayOrigins() {
        return mapOverlayOrigins;
    }

    public void setMapOverlayOrigins(Map<Long, List<Long>> mapOverlayOrigins) {
        this.mapOverlayOrigins = mapOverlayOrigins;
    }

    public Map<Long, String> getMapOverlaySummaryOriginQuantity() {
        return mapOverlaySummaryOriginQuantity;
    }

    public void setMapOverlaySummaryOriginQuantity(Map<Long, String> mapOverlaySummaryOriginQuantity) {
        this.mapOverlaySummaryOriginQuantity = mapOverlaySummaryOriginQuantity;
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

    public Map<Long, SummaryDetailByOverlayDTO> getMapTotalSummary() {
        return mapTotalSummary;
    }

    public void setMapTotalSummary(Map<Long, SummaryDetailByOverlayDTO> mapTotalSummary) {
        this.mapTotalSummary = mapTotalSummary;
    }

    public List<Size> getSizes() {
        return sizes;
    }

    public void setSizes(List<Size> sizes) {
        this.sizes = sizes;
    }

    public List<Overlaytype> getOverlayTypes() {
        return overlayTypes;
    }

    public void setOverlayTypes(List<Overlaytype> overlayTypes) {
        this.overlayTypes = overlayTypes;
    }

    public Map<Long, Map<Long, SummaryDetailByOverlayDTO>> getMapSizeOverlayDetail() {
        return mapSizeOverlayDetail;
    }

    public void setMapSizeOverlayDetail(Map<Long, Map<Long, SummaryDetailByOverlayDTO>> mapSizeOverlayDetail) {
        this.mapSizeOverlayDetail = mapSizeOverlayDetail;
    }

    public void setMapOverlayOriginQuantity(Map<Long, Map<Long, Double>> mapOverlayOriginQuantity) {
        this.mapOverlayOriginQuantity = mapOverlayOriginQuantity;
    }

    public Map<Long, Map<Long, Double>> getMapOverlayOriginQuantity() {
        return mapOverlayOriginQuantity;
    }
}
