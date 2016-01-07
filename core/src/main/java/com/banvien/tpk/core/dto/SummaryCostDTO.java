package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.ProductionPlan;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 20/02/14
 * Time: 23:09
 * To change this template use File | Settings | File Templates.
 */
public class SummaryCostDTO implements Serializable {
    Map<Long,List<Importproduct>> mapPlanProducts;
    Map<Long,ProductionPlan> mapIDPlan;
    Map<Long,ProducedProductDTO> mapPlanTotalProducedProduct;
    Map<Long,List<UsedMaterialDTO>> mapPlanUsedMaterial;
    Map<Long,Double> mapPlanProductAverageCost;
    Map<Long,Double> mapPlanArrangementFee;

    public Map<Long, Double> getMapPlanArrangementFee() {
        return mapPlanArrangementFee;
    }

    public void setMapPlanArrangementFee(Map<Long, Double> mapPlanArrangementFee) {
        this.mapPlanArrangementFee = mapPlanArrangementFee;
    }

    public Map<Long, Double> getMapPlanProductAverageCost() {
        return mapPlanProductAverageCost;
    }

    public void setMapPlanProductAverageCost(Map<Long, Double> mapPlanProductAverageCost) {
        this.mapPlanProductAverageCost = mapPlanProductAverageCost;
    }

    public Map<Long, List<Importproduct>> getMapPlanProducts() {
        return mapPlanProducts;
    }

    public void setMapPlanProducts(Map<Long, List<Importproduct>> mapPlanProducts) {
        this.mapPlanProducts = mapPlanProducts;
    }

    public Map<Long, ProductionPlan> getMapIDPlan() {
        return mapIDPlan;
    }

    public void setMapIDPlan(Map<Long, ProductionPlan> mapIDPlan) {
        this.mapIDPlan = mapIDPlan;
    }

    public Map<Long, ProducedProductDTO> getMapPlanTotalProducedProduct() {
        return mapPlanTotalProducedProduct;
    }

    public void setMapPlanTotalProducedProduct(Map<Long, ProducedProductDTO> mapPlanTotalProducedProduct) {
        this.mapPlanTotalProducedProduct = mapPlanTotalProducedProduct;
    }

    public Map<Long, List<UsedMaterialDTO>> getMapPlanUsedMaterial() {
        return mapPlanUsedMaterial;
    }

    public void setMapPlanUsedMaterial(Map<Long, List<UsedMaterialDTO>> mapPlanUsedMaterial) {
        this.mapPlanUsedMaterial = mapPlanUsedMaterial;
    }
}
