package com.banvien.tpk.core.dto;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/23/14
 * Time: 10:28 PM
 * To change this template use File | Settings | File Templates.
 */
public class ExportMaterialReportDTO implements Serializable {
    private List<ExportMaterialReportDetailDTO> initialValue;
    private Map<String,Double> mapImportValue;
    private Map<String,Double> mapExportUtilDateValue;
    private Map<String,Double> mapExportDuringDateValue;

    public List<ExportMaterialReportDetailDTO> getInitialValue() {
        return initialValue;
    }

    public void setInitialValue(List<ExportMaterialReportDetailDTO> initialValue) {
        this.initialValue = initialValue;
    }

    public Map<String, Double> getMapImportValue() {
        return mapImportValue;
    }

    public void setMapImportValue(Map<String, Double> mapImportValue) {
        this.mapImportValue = mapImportValue;
    }

    public Map<String, Double> getMapExportUtilDateValue() {
        return mapExportUtilDateValue;
    }

    public void setMapExportUtilDateValue(Map<String, Double> mapExportUtilDateValue) {
        this.mapExportUtilDateValue = mapExportUtilDateValue;
    }

    public Map<String, Double> getMapExportDuringDateValue() {
        return mapExportDuringDateValue;
    }

    public void setMapExportDuringDateValue(Map<String, Double> mapExportDuringDateValue) {
        this.mapExportDuringDateValue = mapExportDuringDateValue;
    }
}
