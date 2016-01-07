package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.ProductionPlan;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 20/02/14
 * Time: 23:09
 * To change this template use File | Settings | File Templates.
 */
public class SummaryCostByProductDTO implements Serializable {
    Map<Long,List<Importproduct>> mapProductProduceds;
    Map<Long,ProducedProductDTO> mapProductTotalProduced;
    Map<Long,List<UsedMaterialDTO>> mapProductUsedMaterials;
    Map<Long,Double> mapProductAverageCost;
    Map<Long,Double> mapProductArrangementFee;

    public Map<Long, Double> getMapProductArrangementFee() {
        return mapProductArrangementFee;
    }

    public void setMapProductArrangementFee(Map<Long, Double> mapProductArrangementFee) {
        this.mapProductArrangementFee = mapProductArrangementFee;
    }

    public Map<Long, List<Importproduct>> getMapProductProduceds() {
        return mapProductProduceds;
    }

    public void setMapProductProduceds(Map<Long, List<Importproduct>> mapProductProduceds) {
        this.mapProductProduceds = mapProductProduceds;
    }

    public Map<Long, ProducedProductDTO> getMapProductTotalProduced() {
        return mapProductTotalProduced;
    }

    public void setMapProductTotalProduced(Map<Long, ProducedProductDTO> mapProductTotalProduced) {
        this.mapProductTotalProduced = mapProductTotalProduced;
    }

    public Map<Long, List<UsedMaterialDTO>> getMapProductUsedMaterials() {
        return mapProductUsedMaterials;
    }

    public void setMapProductUsedMaterials(Map<Long, List<UsedMaterialDTO>> mapProductUsedMaterials) {
        this.mapProductUsedMaterials = mapProductUsedMaterials;
    }

    public Map<Long, Double> getMapProductAverageCost() {
        return mapProductAverageCost;
    }

    public void setMapProductAverageCost(Map<Long, Double> mapProductAverageCost) {
        this.mapProductAverageCost = mapProductAverageCost;
    }
}
