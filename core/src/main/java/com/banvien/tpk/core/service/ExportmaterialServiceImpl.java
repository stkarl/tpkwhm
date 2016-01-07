package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.*;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.*;

public class ExportmaterialServiceImpl extends GenericServiceImpl<Exportmaterial,Long>
        implements ExportmaterialService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ExportmaterialDAO exportmaterialDAO;
    private ExportproductDAO exportproductDAO;
    private ExporttypeDAO exporttypeDAO;
    private MaterialMeasurementDAO materialMeasurementDAO;
    private ImportproductDAO importproductDAO;
    private ArrangementDAO arrangementDAO;

    public void setArrangementDAO(ArrangementDAO arrangementDAO) {
        this.arrangementDAO = arrangementDAO;
    }

    public void setImportproductDAO(ImportproductDAO importproductDAO) {
        this.importproductDAO = importproductDAO;
    }

    public void setMaterialMeasurementDAO(MaterialMeasurementDAO materialMeasurementDAO) {
        this.materialMeasurementDAO = materialMeasurementDAO;
    }

    public void setExporttypeDAO(ExporttypeDAO exporttypeDAO) {
        this.exporttypeDAO = exporttypeDAO;
    }

    public void setExportproductDAO(ExportproductDAO exportproductDAO) {
        this.exportproductDAO = exportproductDAO;
    }

    public void setExportmaterialDAO(ExportmaterialDAO exportmaterialDAO) {
        this.exportmaterialDAO = exportmaterialDAO;
    }

    @Override
    protected GenericDAO<Exportmaterial, Long> getGenericDAO() {
        return exportmaterialDAO;
    }

    @Override
    public void updateItem(ExportmaterialBean ExportmaterialBean) throws ObjectNotFoundException, DuplicateException {
        Exportmaterial dbItem = this.exportmaterialDAO.findByIdNoAutoCommit(ExportmaterialBean.getPojo().getExportMaterialID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Exportmaterial " + ExportmaterialBean.getPojo().getExportMaterialID());

        Exportmaterial pojo = ExportmaterialBean.getPojo();

        this.exportmaterialDAO.detach(dbItem);
        this.exportmaterialDAO.update(pojo);
    }

    @Override
    public void addNew(ExportmaterialBean ExportmaterialBean) throws DuplicateException {
        Exportmaterial pojo = ExportmaterialBean.getPojo();
        pojo = this.exportmaterialDAO.save(pojo);
        ExportmaterialBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                exportmaterialDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ExportmaterialBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        return this.exportmaterialDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public SummaryUsedMaterialDTO reportUsedMaterial(SearchUsedMaterialBean bean) {
        SummaryUsedMaterialDTO result = null;
        try {
            Long warehouseID = bean.getWarehouseID() != null && bean.getWarehouseID() > 0 ? bean.getWarehouseID() : null;
            result = new SummaryUsedMaterialDTO();
            List<UsedMaterialDTO> usedMaterials = this.exportmaterialDAO.findExportMaterial(bean);
            List<UsedMaterialDTO> usedProducts = this.exportproductDAO.findExportProduct4Production(bean);
            Object[] usedMaterialArr = setUsedMaterialsTogetherWithMainMaterial(usedProducts,usedMaterials);

            List<UsedMaterialDTO> mainUsedMaterials = (List<UsedMaterialDTO>) usedMaterialArr[0];
            List<UsedMaterialDTO> shareUsedMaterials = (List<UsedMaterialDTO>) usedMaterialArr[1];

            result.setUsedProducts(mainUsedMaterials);
            result.setShareUsedMaterials(shareUsedMaterials);

            if(bean.getExportTypeID() != null && bean.getExportTypeID() > 0 && usedProducts != null && usedProducts.size() > 0){
                Exporttype exporttype = this.exporttypeDAO.findByIdNoAutoCommit(bean.getExportTypeID());
                if(exporttype.getCode().equals(Constants.EXPORT_TYPE_SAN_XUAT)){
                    Timestamp start = null;
                    Timestamp end = null;
                    for(UsedMaterialDTO usedMaterialDTO : usedProducts){
                       if(start == null || start.after(usedMaterialDTO.getStartDate())){
                            start = usedMaterialDTO.getStartDate();
                        }
                        if(end == null || end.before(usedMaterialDTO.getEndDate())){
                            end = usedMaterialDTO.getStartDate();
                        }
                    }
                    if(bean.getFromExportedDate() != null){
                        start = new Timestamp(bean.getFromExportedDate().getTime()) ;
                    }
                    if(bean.getToExportedDate() != null){
                        end = new Timestamp(bean.getToExportedDate().getTime()) ;
                    }

                    Map<Long, List<UsedMaterialDTO>> mapWarehouseMaterialMeasurementUseds = getUsedMeasurementMaterials(warehouseID,start,end, bean.getProductionType());
                    result.setUsedMeasurementMaterials(sumMeasurementMaterialUsed(mapWarehouseMaterialMeasurementUseds));
                }
            }
            result.setUsedMaterials(usedMaterials);
        } catch (Exception e) {
            logger.error(e.getCause().getMessage());
        }
        return result;
    }

    private Object[] setUsedMaterialsTogetherWithMainMaterial(List<UsedMaterialDTO> usedProducts, List<UsedMaterialDTO> usedMaterials) {
        // group product quantity and find plans used those products
        Map<Long,UsedMaterialDTO> mapProductNameUsedMaterial = new HashMap<Long, UsedMaterialDTO>();
        Map<Long,List<Long>> mapProductNameInPlans = new HashMap<Long, List<Long>>();
        for(UsedMaterialDTO usedProduct : usedProducts){
            Long nameID = usedProduct.getProductName().getProductNameID();
            Long planID = usedProduct.getPlan().getProductionPlanID();
            if(usedProduct.getSize() != null){
                String[] sizeArr = StringUtils.split(usedProduct.getSize().getName(), "x");
                usedProduct.setWidth(sizeArr[sizeArr.length - 1]);
            }
            UsedMaterialDTO usedMaterialDTO = mapProductNameUsedMaterial.get(nameID);
            if(usedMaterialDTO != null){
                Double oldKg = usedMaterialDTO.getTotalKgUsed() != null ? usedMaterialDTO.getTotalKgUsed() : 0d;
                Double curKg = usedProduct.getTotalKgUsed() != null ? usedProduct.getTotalKgUsed() : 0d;
                usedMaterialDTO.setTotalKgUsed(oldKg + curKg);
                Double oldM = usedMaterialDTO.getTotalMUsed() != null ? usedMaterialDTO.getTotalMUsed() : 0d;
                Double curM = usedProduct.getTotalMUsed() != null ? usedProduct.getTotalMUsed() : 0d;
                usedMaterialDTO.setTotalMUsed(oldM + curM);
            }else{
                mapProductNameUsedMaterial.put(nameID,usedProduct);
            }

            if(!mapProductNameInPlans.containsKey(nameID)){
                List<Long> planIDs = new ArrayList<Long>();
                planIDs.add(planID);
                mapProductNameInPlans.put(nameID,planIDs);
            }else{
                mapProductNameInPlans.get(nameID).add(planID);
            }
        }

        //group materials quantity and find plans used those materials
        Map<Long,UsedMaterialDTO> mapMaterialUsedMaterial = new HashMap<Long, UsedMaterialDTO>();
        Map<Long,List<Long>> mapMaterialInPlans = new HashMap<Long, List<Long>>();
        for(UsedMaterialDTO materialUsed : usedMaterials){
            Long materialID = materialUsed.getMaterial().getMaterialID();
            Long planID = materialUsed.getPlan().getProductionPlanID();
            UsedMaterialDTO tempMaterialUsed = mapMaterialUsedMaterial.get(materialID);
            if(tempMaterialUsed != null){
                tempMaterialUsed.setTotalUsed(tempMaterialUsed.getTotalUsed() + materialUsed.getTotalUsed());
            }else{
                mapMaterialUsedMaterial.put(materialID,materialUsed);
            }

            if(!mapMaterialInPlans.containsKey(materialID)){
                List<Long> planIDs = new ArrayList<Long>();
                planIDs.add(planID);
                mapMaterialInPlans.put(materialID,planIDs);
            }else{
                mapMaterialInPlans.get(materialID).add(planID);
            }
        }
        List<UsedMaterialDTO> mainUsedMaterials = new ArrayList<UsedMaterialDTO>();
        List<UsedMaterialDTO> notSameUsedMaterials = new ArrayList<UsedMaterialDTO>();
        // set sub materials in the same plans to main product used
        for(Long productNameID : mapProductNameUsedMaterial.keySet()){
            UsedMaterialDTO mainUsedMaterial = mapProductNameUsedMaterial.get(productNameID);
            List<Long> planID4Mains = mapProductNameInPlans.get(productNameID);

            for(Long materialID : mapMaterialUsedMaterial.keySet()){
                UsedMaterialDTO subMaterial = mapMaterialUsedMaterial.get(materialID);
                List<Long> planID4Subs = mapMaterialInPlans.get(materialID);
                if(planID4Mains.containsAll(planID4Subs)){
                    mainUsedMaterial.getUsedMaterialDTOs().add(subMaterial);
                    notSameUsedMaterials.add(subMaterial);
                }
            }
            mainUsedMaterials.add(mainUsedMaterial);
        }
         //find same material
        List<UsedMaterialDTO> sameUsedMaterials = new ArrayList<UsedMaterialDTO>();
        for(Long materialID : mapMaterialUsedMaterial.keySet()){
            UsedMaterialDTO subMaterial = mapMaterialUsedMaterial.get(materialID);
            if(!notSameUsedMaterials.contains(subMaterial)){
                sameUsedMaterials.add(subMaterial);
            }
        }
        return new Object[]{mainUsedMaterials,sameUsedMaterials} ;
    }

    private List<UsedMaterialDTO> sumMeasurementMaterialUsed(Map<Long, List<UsedMaterialDTO>> mapWarehouseMaterialMeasurementUseds){
        Map<Long,UsedMaterialDTO> mapMaterialUsed = new HashMap<Long, UsedMaterialDTO>();
        if(mapWarehouseMaterialMeasurementUseds != null){
            for(Long keyWarehouseID : mapWarehouseMaterialMeasurementUseds.keySet()){
                for(UsedMaterialDTO measurementMaterial : mapWarehouseMaterialMeasurementUseds.get(keyWarehouseID)){
                    Long materialID = measurementMaterial.getMaterial().getMaterialID();
                    if(!mapMaterialUsed.containsKey(materialID)){
                        mapMaterialUsed.put(materialID,measurementMaterial);
                    }else {
                        mapMaterialUsed.get(materialID).setTotalUsed(mapMaterialUsed.get(materialID).getTotalUsed() + measurementMaterial.getTotalUsed());
                    }
                }
            }
        }
        return new ArrayList<UsedMaterialDTO>(mapMaterialUsed.values()) ;
    }

    private Map<Long, List<UsedMaterialDTO>> getUsedMeasurementMaterials(Long warehouseID, Timestamp startDate, Timestamp endDate, Integer productionType){
        List<MaterialMeasurement> materialMeasurements = this.materialMeasurementDAO.findUsedInProduction(warehouseID,startDate,endDate,productionType);
        if(materialMeasurements != null){
            Map<Long, List<UsedMaterialDTO>> mapWarehouseMaterialUseds = new HashMap<Long, List<UsedMaterialDTO>>();
            for(MaterialMeasurement measurement : materialMeasurements){
                Long measureWarehouseID = measurement.getWarehouse().getWarehouseID();
                UsedMaterialDTO usedMaterialDTO = new UsedMaterialDTO();
                usedMaterialDTO.setMaterial(measurement.getMaterial());
                usedMaterialDTO.setUnit(measurement.getMaterial().getUnit());
                usedMaterialDTO.setTotalUsed(measurement.getValue());
                usedMaterialDTO.setCost(measurement.getMaterial().getPrice());

                List<UsedMaterialDTO> usedMaterialDTOs =  mapWarehouseMaterialUseds.get(measureWarehouseID);
                if(usedMaterialDTOs == null){
                    usedMaterialDTOs = new ArrayList<UsedMaterialDTO>();
                    usedMaterialDTOs.add(usedMaterialDTO);
                    mapWarehouseMaterialUseds.put(measureWarehouseID,usedMaterialDTOs);
                }else {
                    usedMaterialDTOs.add(usedMaterialDTO);
                }
            }
            return mapWarehouseMaterialUseds;
        }else {
            return null;
        }
    }


    @Override
    public List<Exportmaterial> findExportByPlan(Long productionPlanID) {
        return this.exportmaterialDAO.findExportByPlan(productionPlanID);
    }

    @Override
    public Object[] reportProductionCost(SearchProductionCostBean bean) {
        SummaryCostDTO result = new SummaryCostDTO();
        SummaryCostByProductDTO summaryCostByProductDTO = null;
        ProducedProductBean producedProductBean = new ProducedProductBean();
        producedProductBean.setProductNameID(bean.getProductNameID());
        producedProductBean.setProducedProductID(bean.getProducedProductID());
        producedProductBean.setSizeID(bean.getSizeID());
        producedProductBean.setToDate(bean.getToDate());
        producedProductBean.setFromDate(bean.getFromDate());
        producedProductBean.setReportSummaryProduction(Boolean.TRUE);
        producedProductBean.setReportCost(Boolean.TRUE);
        List<Importproduct> producedProducts = this.importproductDAO.findImportProduct(producedProductBean);
        if(producedProducts != null && producedProducts.size() >0){
            summaryProductPrice(result,producedProducts);
            //summary by date , material & product
            summaryCostByProductDTO = summaryReportByProduct(result);// => return 4 new type of report
        }else{
            return null;
        }
        return new Object[]{result, summaryCostByProductDTO} ;
    }


    private void summaryProductPrice(SummaryCostDTO result,List<Importproduct> products){
        List<Long> productionPlanIDs = new ArrayList<Long>();
        Map<Long,List<Importproduct>> mapPlanProducts = new HashMap<Long, List<Importproduct>>();
        Map<Long,ProductionPlan> mapIDPlan = new HashMap<Long, ProductionPlan>();
        for(Importproduct producedProduct : products){
            Long planID = producedProduct.getImportproductbill().getProductionPlan() != null ? producedProduct.getImportproductbill().getProductionPlan().getProductionPlanID() : null;
            if(planID != null){
                if(!productionPlanIDs.contains(planID)){
                    productionPlanIDs.add(planID);
                }

                if(!mapIDPlan.containsKey(planID)){
                    mapIDPlan.put(planID,producedProduct.getImportproductbill().getProductionPlan());
                }

                if(!mapPlanProducts.containsKey(planID)){
                    List<Importproduct> importproducts = new ArrayList<Importproduct>();
                    importproducts.add(producedProduct);
                    mapPlanProducts.put(planID,importproducts);
                }else{
                    mapPlanProducts.get(planID).add(producedProduct);
                }

            }
        }
        Map<Long,List<UsedMaterialDTO>> mapPlanUsedMaterial = null;
        Map<Long,ProducedProductDTO> mapPlanTotalProducedProduct = null;
        Map<Long,List<Importproduct>> mapPlanMainUsedMaterials = null;
        Map<Long,Double> mapPlanArrangementFee = null;
        if(productionPlanIDs != null && productionPlanIDs.size() > 0){
            mapPlanMainUsedMaterials = mappingPlanMainUsedMaterials(productionPlanIDs);
            mapPlanTotalProducedProduct = mappingPlanProducedProduct(productionPlanIDs);
            mapPlanUsedMaterial =  mappingPlanUsedMaterialsCost(productionPlanIDs);
            mappingPlanMeasuredMaterialCost(mapPlanUsedMaterial, productionPlanIDs);
            mappingPlanMainUsedMaterialCost(mapPlanUsedMaterial, mapPlanMainUsedMaterials);
//            mapPlanArrangementFee = mappingPlanArrangementFee(mapPlanUsedMaterial, productionPlanIDs, mapIDPlan);
        }

        Map<Long,Double> mapPlanProductAverageCost = mappingPlanAverageCost(mapPlanUsedMaterial,mapPlanTotalProducedProduct, mapPlanArrangementFee);

        result.setMapIDPlan(mapIDPlan);
        result.setMapPlanProducts(mapPlanProducts);
        result.setMapPlanTotalProducedProduct(mapPlanTotalProducedProduct);
        result.setMapPlanUsedMaterial(mapPlanUsedMaterial);
        result.setMapPlanProductAverageCost(mapPlanProductAverageCost);
//        result.setMapPlanArrangementFee(mapPlanArrangementFee);
    }

    private Map<Long,Double> mappingPlanArrangementFee(Map<Long, List<UsedMaterialDTO>> mapPlanUsedMaterial, List<Long> productionPlanIDs, Map<Long, ProductionPlan> mapIDPlan) {
        Map<Long,Double> mapPlanArrangementFee = new HashMap<Long, Double>();
        List<Arrangement> arrangements = this.arrangementDAO.findByPlanIDs(productionPlanIDs);
        for(Long planID : mapIDPlan.keySet()){
            Timestamp date = mapIDPlan.get(planID).getDate();
            for(Arrangement arrangement : arrangements){
                if(date.getTime() >= arrangement.getFromDate().getTime() && date.getTime() <= arrangement.getToDate().getTime()){
                    mapPlanArrangementFee.put(planID, arrangement.getAverage() / 1000);
                }
            }
        }
        return mapPlanArrangementFee;
    }

    private Map<Long, Double> mappingPlanAverageCost(Map<Long, List<UsedMaterialDTO>> mapPlanUsedMaterial, Map<Long, ProducedProductDTO> mapPlanTotalProducedProduct, Map<Long, Double> mapPlanArrangementFee) {
        Map<Long,Double> mapPlanProductAverageCost = new HashMap<Long, Double>();
        if(mapPlanUsedMaterial != null && mapPlanUsedMaterial.size() > 0){
            for(Long planID : mapPlanUsedMaterial.keySet()){
                Double totalCost = 0d;
                for(UsedMaterialDTO usedMaterialDTO : mapPlanUsedMaterial.get(planID)){
                    Double cost = 0d;
                    if(usedMaterialDTO.getCost() != null && usedMaterialDTO.getTotalUsed() != null){
                        cost =  usedMaterialDTO.getTotalUsed() / mapPlanTotalProducedProduct.get(planID).getTotalProduced() * usedMaterialDTO.getCost();
                    }
                    totalCost +=  cost;
                }
//                totalCost +=  mapPlanArrangementFee.get(planID) != null ? mapPlanArrangementFee.get(planID) : 0d;
                mapPlanProductAverageCost.put(planID,totalCost);
            }
        }
        return mapPlanProductAverageCost;
    }

    private void mappingPlanMainUsedMaterialCost(Map<Long, List<UsedMaterialDTO>> mapPlanUsedMaterial, Map<Long,List<Importproduct>> mapPlanMainUsedMaterials) {
        if(mapPlanMainUsedMaterials != null && mapPlanMainUsedMaterials.size() > 0){
            for(Long planID : mapPlanMainUsedMaterials.keySet()){
                List<Importproduct> mainUsedMaterials = mapPlanMainUsedMaterials.get(planID);
                Importproduct sampleProduct = mainUsedMaterials.get(0);
                if(sampleProduct != null && sampleProduct.getProductqualitys() != null && sampleProduct.getProductqualitys().size() > 0){
                    SummaryCostDTO result = new SummaryCostDTO();
                    summaryProductPrice(result,mainUsedMaterials);
                    Double averageProductCostByPlan = 0d;
                    if(result.getMapPlanProductAverageCost() != null && result.getMapPlanProductAverageCost().size() > 0){
                        int counter = 0;
                        Double totalCost = 0d;
                        for(Long key : result.getMapPlanProductAverageCost().keySet()){
                            if(result.getMapPlanProductAverageCost().get(key) > 0){
                                totalCost += result.getMapPlanProductAverageCost().get(key);
                                counter++;
                            }
                        }
                        averageProductCostByPlan = counter > 0 ?  totalCost/counter : 0d;
                    }
                    UsedMaterialDTO mainUsedMaterial = new UsedMaterialDTO();
                    mainUsedMaterial.setProductName(sampleProduct.getProductname());
                    mainUsedMaterial.setUnit(sampleProduct.getUnit2());
                    mainUsedMaterial.setCost(averageProductCostByPlan);
                    Double totalQuantity = 0d;
                    for(Importproduct mainMaterial : mainUsedMaterials){
                        totalQuantity +=  mainMaterial.getQuantity2Pure() != null ? mainMaterial.getQuantity2Pure() : 0d;
                        totalQuantity -=  mainMaterial.getImportBack() != null ? mainMaterial.getImportBack() : 0d;

                    }
                    mainUsedMaterial.setTotalUsed(totalQuantity);
                    addUsedMaterialToMap(mapPlanUsedMaterial,planID,mainUsedMaterial);
                }else{
                    UsedMaterialDTO mainUsedMaterial = new UsedMaterialDTO();
                    mainUsedMaterial.setProductName(sampleProduct.getProductname());
                    mainUsedMaterial.setUnit(sampleProduct.getUnit2());
                    Double totalQuantity = 0d;
                    Double totalCost = 0d;
                    Integer notHavePrice = 0;
                    for(Importproduct importproduct : mainUsedMaterials){
                        totalQuantity += importproduct.getQuantity2Pure() != null ? importproduct.getQuantity2Pure() : 0d;
                        totalQuantity -=  importproduct.getImportBack() != null ? importproduct.getImportBack() : 0d;
                        if(importproduct.getMoney() != null){
                            totalCost += importproduct.getMoney();
                        }else {
                            notHavePrice++;
                        }
                    }
                    Double cost = (mainUsedMaterials.size() - notHavePrice) != 0 ? totalCost / (mainUsedMaterials.size() - notHavePrice) : 0d;
                    mainUsedMaterial.setTotalUsed(totalQuantity);
                    mainUsedMaterial.setCost(cost);
                    addUsedMaterialToMap(mapPlanUsedMaterial,planID,mainUsedMaterial);
                }
            }
        }
    }

    private void addUsedMaterialToMap(Map<Long, List<UsedMaterialDTO>> mapPlanUsedMaterial,Long planID, UsedMaterialDTO mainUsedMaterial){
        if(!mapPlanUsedMaterial.containsKey(planID)){
            List<UsedMaterialDTO> usedMaterialDTOs = new ArrayList<UsedMaterialDTO>();
            usedMaterialDTOs.add(mainUsedMaterial);
            mapPlanUsedMaterial.put(planID,usedMaterialDTOs);
        }else {
            mapPlanUsedMaterial.get(planID).add(mainUsedMaterial);
        }
    }

    private  Map<Long,List<UsedMaterialDTO>> mappingPlanUsedMaterialsCost(List<Long> productionPlanIDs){
        List<Exportmaterial> exportmaterialsByPlan = this.exportmaterialDAO.findByProductionPlanIDs(productionPlanIDs);

        Map<Long,List<UsedMaterialDTO>> mapPlanUsedMaterial = new HashMap<Long, List<UsedMaterialDTO>>();

        Map<Long,Map<Long,Double>> mapPlanMaterialUsedValue = new HashMap<Long, Map<Long, Double>>();
        Map<Long,Double> mapMaterialCost = new HashMap<Long, Double>();
        Map<Long,Material> mapIdMaterial = new HashMap<Long, Material>();
        for(Exportmaterial exportmaterial : exportmaterialsByPlan){
            //map plan - material - used value
            Long planID = exportmaterial.getExportmaterialbill().getProductionPlan().getProductionPlanID();
            Long materialID = exportmaterial.getImportmaterial().getMaterial().getMaterialID();
            Double usedValue = exportmaterial.getQuantity();

            mapIdMaterial.put(materialID,exportmaterial.getImportmaterial().getMaterial());

            Map<Long,Double> mapMaterialUsedValue = mapPlanMaterialUsedValue.get(planID);
            if(mapMaterialUsedValue != null){
                if(!mapMaterialUsedValue.containsKey(materialID)){
                    mapMaterialUsedValue.put(materialID,usedValue);
                }else{
                    Double totalValue = mapMaterialUsedValue.get(materialID) + usedValue;
                    mapMaterialUsedValue.put(materialID,totalValue);
                }
            }else{
                mapMaterialUsedValue = new HashMap<Long, Double>();
                mapMaterialUsedValue.put(materialID,usedValue);
                mapPlanMaterialUsedValue.put(planID,mapMaterialUsedValue);
            }

            //map material - cost
            Double money = exportmaterial.getImportmaterial().getMoney() != null ? exportmaterial.getImportmaterial().getMoney() : 0d;
            Double cost = money;
            if(!mapMaterialCost.containsKey(materialID)){
                mapMaterialCost.put(materialID,cost);
            }else{
                Double prvCost = mapMaterialCost.get(materialID);
                cost = (cost + prvCost) / 2;
                mapMaterialCost.put(materialID,cost);
            }
        }
        // map plan - used materials
        for(Long planID : mapPlanMaterialUsedValue.keySet()){
            Map<Long,Double> mapMaterialUsedValue = mapPlanMaterialUsedValue.get(planID);
            List<UsedMaterialDTO> usedMaterialDTOs =  mapPlanUsedMaterial.get(planID);
            for(Long materialID : mapMaterialUsedValue.keySet()){
                UsedMaterialDTO usedMaterialDTO = new UsedMaterialDTO();
                usedMaterialDTO.setMaterial(mapIdMaterial.get(materialID));
                usedMaterialDTO.setTotalUsed(mapMaterialUsedValue.get(materialID));
                usedMaterialDTO.setCost(mapMaterialCost.get(materialID));
                usedMaterialDTO.setUnit(mapIdMaterial.get(materialID).getUnit());
                if(usedMaterialDTOs != null){
                    usedMaterialDTOs.add(usedMaterialDTO);
                }else {
                    usedMaterialDTOs = new ArrayList<UsedMaterialDTO>();
                    usedMaterialDTOs.add(usedMaterialDTO);
                    mapPlanUsedMaterial.put(planID,usedMaterialDTOs);
                }
            }
        }
        return mapPlanUsedMaterial;
    }

    private void mappingPlanMeasuredMaterialCost(Map<Long, List<UsedMaterialDTO>> mapPlanUsedMaterial, List<Long> productionPlanIDs) {
        List<Object[]> productionTimes = this.exportproductDAO.findProductionTimesByPlans(productionPlanIDs);
        if(productionTimes != null){
            for(Object[] objs : productionTimes){
                Long warehouseID = Long.valueOf(objs[0].toString());
                Long planID = Long.valueOf(objs[1].toString());
                Timestamp startDate = (Timestamp) objs[2];
                Timestamp endDate = (Timestamp) objs[3];
                Map<Long, List<UsedMaterialDTO>> mapWarehouseMaterialMeasurementUseds = getUsedMeasurementMaterials(warehouseID,startDate,endDate, null);
                //@TODO add production type filter 4 cost report
                if(!mapPlanUsedMaterial.containsKey(planID)){
                    mapPlanUsedMaterial.put(planID,sumMeasurementMaterialUsed(mapWarehouseMaterialMeasurementUseds));
                }else {
                    mapPlanUsedMaterial.get(planID).addAll(sumMeasurementMaterialUsed(mapWarehouseMaterialMeasurementUseds));
                }
            }
        }
    }

    private Map<Long,ProducedProductDTO> mappingPlanProducedProduct(List<Long> productionPlanIDs){
        List<Importproduct> producedProductsByPlan = this.importproductDAO.findByProductionPlanIDs(productionPlanIDs);
        Map<Long,ProducedProductDTO> mapPlanTotalProducedProduct = new HashMap<Long, ProducedProductDTO>();
        for(Importproduct producedProduct : producedProductsByPlan){
            try{
                Long planID = producedProduct.getImportproductbill().getProductionPlan().getProductionPlanID();
                if(!mapPlanTotalProducedProduct.containsKey(planID)){
                    ProducedProductDTO producedProductDTO = new ProducedProductDTO();
                    producedProductDTO.setProductname(producedProduct.getProductname());
                    producedProductDTO.setTotalProduced(producedProduct.getQuantity2Pure());
                    mapPlanTotalProducedProduct.put(planID,producedProductDTO);
                }else{
                    ProducedProductDTO producedProductDTO = mapPlanTotalProducedProduct.get(planID);
                    Double curVal = producedProductDTO.getTotalProduced() != null ? producedProductDTO.getTotalProduced() : 0d;
                    Double addVal = producedProduct.getQuantity2Pure() != null ? producedProduct.getQuantity2Pure() : 0d;
                    producedProductDTO.setTotalProduced(curVal + addVal);
                }
            }catch(Exception e){
                logger.error(e.getMessage(),e);
            }

        }
        return mapPlanTotalProducedProduct;
    }


    private Map<Long, List<Importproduct>> mappingPlanMainUsedMaterials(List<Long> productionPlanIDs) {
        List<Exportproduct> exportProductsByPlans = this.exportproductDAO.findExportProductsByPlans(productionPlanIDs);
        Map<Long,List<Importproduct>> mapPlanMainUsedMaterials = new HashMap<Long, List<Importproduct>>();
        if(exportProductsByPlans != null){
            for(Exportproduct exportproduct : exportProductsByPlans){
                Long planID = exportproduct.getExportproductbill().getProductionPlan() != null ? exportproduct.getExportproductbill().getProductionPlan().getProductionPlanID() : null;
                if(planID != null){
                    if(!mapPlanMainUsedMaterials.containsKey(planID)){
                        List<Importproduct> mainUsedMaterials = new ArrayList<Importproduct>();
                        mainUsedMaterials.add(exportproduct.getImportproduct());
                        mapPlanMainUsedMaterials.put(planID,mainUsedMaterials);
                    }else{
                        if(!mapPlanMainUsedMaterials.get(planID).contains(exportproduct.getImportproduct())){
                            mapPlanMainUsedMaterials.get(planID).add(exportproduct.getImportproduct());
                        }
                    }
                }
            }
        }

        return mapPlanMainUsedMaterials;
    }

    private SummaryCostByProductDTO summaryReportByProduct(SummaryCostDTO result) {

        Map<Long,ProducedProductDTO> mapProductProduced = new HashMap<Long, ProducedProductDTO>();
        Map<Long,Double> mapProductAverageCost = new HashMap<Long, Double>();
        Map<Long,Double> mapProductArrangementFee = new HashMap<Long, Double>();
        Map<Long,List<Importproduct>> mapProducts = new HashMap<Long, List<Importproduct>>();

        Map<Long,Map<String,UsedMaterialDTO>> mapProductMaterial = new HashMap<Long, Map<String, UsedMaterialDTO>>(); // will be convert 2 list
        for(Long planID : result.getMapPlanUsedMaterial().keySet()){
            ProducedProductDTO producedProductDTO = result.getMapPlanTotalProducedProduct().get(planID);
            Long productNameID = producedProductDTO.getProductname().getProductNameID();
            // mapping used material by product
            Map<String, UsedMaterialDTO> mapMaterial = mapProductMaterial.get(productNameID);
            String materialKey = "";
            for(UsedMaterialDTO usedMaterialDTO : result.getMapPlanUsedMaterial().get(planID)){
                if(usedMaterialDTO.getMaterial() != null){
                    materialKey = "M_" + usedMaterialDTO.getMaterial().getMaterialID();
                }else if(usedMaterialDTO.getProductName() != null){
                    materialKey = "P_" +usedMaterialDTO.getProductName().getProductNameID();
                }
                if(mapMaterial != null){
                    UsedMaterialDTO materialDTO = mapMaterial.get(materialKey);
                    if (materialDTO != null){
                        materialDTO.setTotalUsed(materialDTO.getTotalUsed() + usedMaterialDTO.getTotalUsed());
                        if(usedMaterialDTO.getCost() != null && usedMaterialDTO.getCost() > 0){
                            materialDTO.setCost(materialDTO.getCost() != null && materialDTO.getCost() > 0  ? (materialDTO.getCost() + usedMaterialDTO.getCost()) / 2 : usedMaterialDTO.getCost());
                        }
                    }else {
                        UsedMaterialDTO tempMaterial = new UsedMaterialDTO(usedMaterialDTO);
                        mapMaterial.put(materialKey, tempMaterial);
                    }
                }else {
                    mapMaterial = new HashMap<String, UsedMaterialDTO>();
                    UsedMaterialDTO materialDTO = new UsedMaterialDTO(usedMaterialDTO);
                    mapMaterial.put(materialKey, materialDTO);
                    mapProductMaterial.put(productNameID,mapMaterial);
                }
            }
            //mapping total produced by product
            ProducedProductDTO totalProduced = mapProductProduced.get(productNameID);
            if(totalProduced != null){
                totalProduced.setTotalProduced(totalProduced.getTotalProduced() + producedProductDTO.getTotalProduced());
            }else {
                ProducedProductDTO productDTO = new ProducedProductDTO(producedProductDTO);
                mapProductProduced.put(productNameID, productDTO);
            }

            //mapping average cost by product
            Double planAverageCost = result.getMapPlanProductAverageCost().get(planID);
            Double tempCost = mapProductAverageCost.get(productNameID);
            if(tempCost != null){
                mapProductAverageCost.put(productNameID, planAverageCost > 0 ? (tempCost + planAverageCost) / 2 : tempCost);
            }else {
                if(planAverageCost.doubleValue() > 0){
                    Double averageCostOfSum = new Double(planAverageCost.doubleValue());
                    mapProductAverageCost.put(productNameID,averageCostOfSum);
                }
            }

            //mapping arrangement fee by product
//            Double planArrangementFee = result.getMapPlanArrangementFee().get(planID) != null ? result.getMapPlanArrangementFee().get(planID) : 0d;
//            Double tempFee = mapProductArrangementFee.get(productNameID);
//            if(tempFee != null){
//                mapProductArrangementFee.put(productNameID, planArrangementFee > 0 ? (tempFee + planArrangementFee) / 2 : tempFee);
//            }else {
//                if(planArrangementFee.doubleValue() > 0){
//                    Double averageCostOfSum = new Double(planArrangementFee.doubleValue());
//                    mapProductArrangementFee.put(productNameID,averageCostOfSum);
//                }
//            }

            //mapping list produced by product
            List<Importproduct> tempList = mapProducts.get(productNameID);
            if(tempList != null){
                tempList.addAll(result.getMapPlanProducts().get(planID));
            }else {
                mapProducts.put(productNameID, result.getMapPlanProducts().get(planID));
            }
        }

        // grouping data if needed
        Map<Long,List<UsedMaterialDTO>> mapProductUsedMaterial = new HashMap<Long, List<UsedMaterialDTO>>();
        for(Long productNameId : mapProductMaterial.keySet()){
            mapProductUsedMaterial.put(productNameId, new ArrayList<UsedMaterialDTO>(mapProductMaterial.get(productNameId).values()));
        }

        SummaryCostByProductDTO summaryCostByProductDTO = new SummaryCostByProductDTO();
        summaryCostByProductDTO.setMapProductTotalProduced(mapProductProduced);
        summaryCostByProductDTO.setMapProductProduceds(mapProducts);
        summaryCostByProductDTO.setMapProductUsedMaterials(mapProductUsedMaterial);
        summaryCostByProductDTO.setMapProductAverageCost(mapProductAverageCost);
        summaryCostByProductDTO.setMapProductArrangementFee(mapProductArrangementFee);
        return summaryCostByProductDTO;
    }

}