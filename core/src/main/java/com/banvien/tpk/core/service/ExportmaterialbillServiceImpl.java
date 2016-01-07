package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.*;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExportmaterialbillServiceImpl extends GenericServiceImpl<Exportmaterialbill,Long>
        implements ExportmaterialbillService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ExportmaterialbillDAO exportmaterialbillDAO;

    public void setExportmaterialbillDAO(ExportmaterialbillDAO exportmaterialbillDAO) {
        this.exportmaterialbillDAO = exportmaterialbillDAO;
    }

    private ExportmaterialDAO exportmaterialDAO;

    public void setExportmaterialDAO(ExportmaterialDAO exportmaterialDAO) {
        this.exportmaterialDAO = exportmaterialDAO;
    }

    private ExportMaterialBillLogDAO exportMaterialBillLogDAO;

    public void setExportMaterialBillLogDAO(ExportMaterialBillLogDAO exportMaterialBillLogDAO) {
        this.exportMaterialBillLogDAO = exportMaterialBillLogDAO;
    }

    private ImportmaterialDAO importmaterialDAO;

    public void setImportmaterialDAO(ImportmaterialDAO importmaterialDAO) {
        this.importmaterialDAO = importmaterialDAO;
    }


    private ProductionPlanDAO productionPlanDAO;

    public void setProductionPlanDAO(ProductionPlanDAO productionPlanDAO) {
        this.productionPlanDAO = productionPlanDAO;
    }

    private MachineDAO machineDAO;
    private MachinecomponentDAO machinecomponentDAO;
    private MaintenancehistoryDAO maintenancehistoryDAO;

    public void setMaintenancehistoryDAO(MaintenancehistoryDAO maintenancehistoryDAO) {
        this.maintenancehistoryDAO = maintenancehistoryDAO;
    }

    public void setMachineDAO(MachineDAO machineDAO) {
        this.machineDAO = machineDAO;
    }

    public void setMachinecomponentDAO(MachinecomponentDAO machinecomponentDAO) {
        this.machinecomponentDAO = machinecomponentDAO;
    }

    private MaterialcategoryDAO materialcategoryDAO;

    public void setMaterialcategoryDAO(MaterialcategoryDAO materialcategoryDAO) {
        this.materialcategoryDAO = materialcategoryDAO;
    }

    @Override
    protected GenericDAO<Exportmaterialbill, Long> getGenericDAO() {
        return exportmaterialbillDAO;
    }


    @Override
    public void updateItem(ExportmaterialbillBean bean) throws ObjectNotFoundException, DuplicateException {
        Exportmaterialbill dbItem = this.exportmaterialbillDAO.findByIdNoAutoCommit(bean.getPojo().getExportMaterialBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Exportmaterialbill " + bean.getPojo().getExportMaterialBillID());
        Exportmaterialbill pojo = bean.getPojo();
        verifyPojo(pojo);
        Timestamp now = new Timestamp(System.currentTimeMillis());
        dbItem.setCode(pojo.getCode().toUpperCase());
        dbItem.setDescription(pojo.getDescription());
        dbItem.setUpdatedDate(now);
        if(pojo.getExportDate() == null){
            dbItem.setExportDate(now);
        }
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setUpdatedBy(loginUser);
        Integer preStatus = dbItem.getStatus();
        dbItem.setStatus(Constants.WAIT_CONFIRM);
        if(pojo.getExporttype() != null && pojo.getExporttype().getExportTypeID() != null && pojo.getExporttype().getExportTypeID() > 0 && pojo.getExporttype().getCode() != null){
            dbItem.setExporttype(pojo.getExporttype());
            if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_BAN)){
                dbItem.setReceiveWarehouse(null);
                dbItem.setProductionPlan(null);
                if(pojo.getCustomer() != null && pojo.getCustomer().getCustomerID() >0){
                    dbItem.setCustomer(pojo.getCustomer());
                }
            }else if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_CHUYEN_KHO)){
                dbItem.setCustomer(null);
                dbItem.setProductionPlan(null);
                if(pojo.getReceiveWarehouse() != null && pojo.getReceiveWarehouse().getWarehouseID() >0){
                    dbItem.setReceiveWarehouse(pojo.getReceiveWarehouse());
                }
            }else if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_SAN_XUAT) || pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_BTSC)){
                dbItem.setCustomer(null);
                dbItem.setReceiveWarehouse(null);
                if(pojo.getProductionPlan() != null && pojo.getProductionPlan().getProductionPlanID() >0){
                    dbItem.setProductionPlan(pojo.getProductionPlan());
                }
            }else{
                dbItem.setCustomer(null);
                dbItem.setReceiveWarehouse(null);
                dbItem.setProductionPlan(null);
            }
            //@TODO do more specific if required
            if(!pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_BTSC)){
                if(dbItem.getExporttype().getCode().equals(Constants.EXPORT_TYPE_BTSC)){

                }
                dbItem.setMachine(null);
                dbItem.setMachinecomponent(null);
            }else{
                Long machineID = pojo.getMachine() != null && pojo.getMachine().getMachineID() != null ? pojo.getMachine().getMachineID() : null;
                Long machineComponentID = pojo.getMachinecomponent() != null && pojo.getMachinecomponent().getMachineComponentID() != null ? pojo.getMachinecomponent().getMachineComponentID() : null;
                if((dbItem.getMachine() != null && dbItem.getMachine().getMachineID() != machineID) || dbItem.getMachine() == null){
                    updateMachineAndComponentStatus(machineID, machineComponentID, loginUser, now, pojo.getDescription());
                }else if((dbItem.getMachinecomponent() != null && dbItem.getMachinecomponent().getMachineComponentID() != machineComponentID) ||  (dbItem.getMachinecomponent() == null && machineComponentID != null)){
                    updateMachineAndComponentStatus(machineID, machineComponentID, loginUser, now, pojo.getDescription());
                }
            }
            if(pojo.getProductionPlan() != null && pojo.getProductionPlan().getProductionPlanID() != null &&  pojo.getProductionPlan().getProductionPlanID() > 0){
                ProductionPlan plan = this.productionPlanDAO.findByIdNoAutoCommit(pojo.getProductionPlan().getProductionPlanID());
                dbItem.setExportDate(plan.getDate());
            }
            dbItem = this.exportmaterialbillDAO.update(dbItem);
            saveLog(loginUser,dbItem,pojo.getNote(),1);

            saveOrUpdateExportMaterial(dbItem.getExportmaterials(), bean.getItemInfos(), dbItem,pojo.getExporttype().getCode(), preStatus);
        }
    }

    private void verifyPojo(Exportmaterialbill pojo){
        if(pojo.getProductionPlan() != null && pojo.getProductionPlan().getProductionPlanID() == null){
            pojo.setProductionPlan(null);
        }
        if(pojo.getCustomer() != null && pojo.getCustomer().getCustomerID() == null){
            pojo.setCustomer(null);
        }
        if(pojo.getReceiveWarehouse() != null && pojo.getReceiveWarehouse().getWarehouseID() == null){
            pojo.setReceiveWarehouse(null);
        }
        if(pojo.getMachine() != null && pojo.getMachine().getMachineID() == null){
            pojo.setMachine(null);
        }
        if(pojo.getMachinecomponent() != null && pojo.getMachinecomponent().getMachineComponentID() == null){
            pojo.setMachinecomponent(null);
        }
    }

    @Override
    public void addNew(ExportmaterialbillBean bean) throws DuplicateException {
        Exportmaterialbill pojo = bean.getPojo();
        verifyPojo(pojo);
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        pojo.setCreatedBy(loginUser);
        Timestamp now = new Timestamp(System.currentTimeMillis());
        pojo.setCreatedDate(now);
        if(pojo.getExportDate() == null){
            pojo.setExportDate(now);
        }
        pojo.setStatus(Constants.WAIT_CONFIRM);
        if(pojo.getExporttype() != null && pojo.getExporttype().getExportTypeID() != null && pojo.getExporttype().getCode() != null){
            if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_BAN)){
                pojo.setReceiveWarehouse(null);
                pojo.setProductionPlan(null);
            }else if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_CHUYEN_KHO)){
                pojo.setCustomer(null);
                pojo.setProductionPlan(null);
            }else if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_SAN_XUAT) || pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_BTSC)){
                pojo.setCustomer(null);
                pojo.setReceiveWarehouse(null);
            }else{
                pojo.setCustomer(null);
                pojo.setReceiveWarehouse(null);
                pojo.setProductionPlan(null);
            }

            if(!pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_BTSC)){
                pojo.setMachine(null);
                pojo.setMachinecomponent(null);
            }else{
                Long machineID = pojo.getMachine() != null && pojo.getMachine().getMachineID() != null ? pojo.getMachine().getMachineID() : null;
                Long machineComponentID = pojo.getMachinecomponent() != null && pojo.getMachinecomponent().getMachineComponentID() != null ? pojo.getMachinecomponent().getMachineComponentID() : null;
                updateMachineAndComponentStatus(machineID,machineComponentID,loginUser,now,pojo.getDescription());
            }

            pojo.setCode(pojo.getCode().toUpperCase());
            if(pojo.getProductionPlan() != null && pojo.getProductionPlan().getProductionPlanID() != null &&  pojo.getProductionPlan().getProductionPlanID() > 0){
                ProductionPlan plan = this.productionPlanDAO.findByIdNoAutoCommit(pojo.getProductionPlan().getProductionPlanID());
                pojo.setExportDate(plan.getDate());
            }
            pojo = this.exportmaterialbillDAO.save(pojo);
            saveLog(loginUser,pojo,pojo.getNote(),1);
            saveOrUpdateExportMaterial(null, bean.getItemInfos(), pojo, pojo.getExporttype().getCode(),null);
            if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_BTSC)){
                pojo.setMachine(null);
                pojo.setMachinecomponent(null);
            }
        }
    }

    private void updateMachineAndComponentStatus(Long machineID, Long machineComponentID, User loginUser, Timestamp curTime,String note) {
        if(machineID != null){
            Machine machine = this.machineDAO.findByIdNoAutoCommit(machineID);
            machine.setLastMaintenanceDate(curTime);
            machine.setStatus(Constants.MACHINE_NORMAL);
            this.machineDAO.update(machine);
            Machinecomponent machinecomponent = null;
            if(machineComponentID != null){
                machinecomponent = this.machinecomponentDAO.findByIdNoAutoCommit(machineComponentID);
                machinecomponent.setLastMaintenanceDate(curTime);
                machinecomponent.setStatus(Constants.MACHINE_NORMAL);
                this.machinecomponentDAO.update(machinecomponent);
            }

            Maintenancehistory maintenancehistory = new Maintenancehistory();
            maintenancehistory.setMachinecomponent(machinecomponent);
            maintenancehistory.setMachine(machine);
            maintenancehistory.setCreatedDate(curTime);
            maintenancehistory.setCreatedBy(loginUser);
            maintenancehistory.setMaintenanceDate(curTime);
            maintenancehistory.setNote(note);
            this.maintenancehistoryDAO.save(maintenancehistory);
        }
    }

    private void saveLog(User loginUser,Exportmaterialbill bill,String note, Integer status){
        ExportMaterialBillLog log = new ExportMaterialBillLog();
        log.setExportmaterialbill(bill);
        log.setNote(note);
        log.setStatus(status);
        log.setCreatedBy(loginUser);
        log.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        exportMaterialBillLogDAO.save(log);
    }

    private void saveOrUpdateExportMaterial(List<Exportmaterial> dbExportmaterials, List<ItemInfoDTO> itemInfoDTOs, Exportmaterialbill bill,String exportType, Integer billPreStatus){
        for(ItemInfoDTO item : itemInfoDTOs){
            Boolean isExist = Boolean.FALSE;
            if(item.getItemID() != null && item.getItemID() > 0 && item.getUsedQuantity() != null && item.getUsedQuantity() > 0){
                Exportmaterial exportmaterial = null;
                if(dbExportmaterials != null && dbExportmaterials.size() > 0){          // case update
                    for(int i = dbExportmaterials.size() - 1; i >= 0; i--){
                        Exportmaterial ePd =  dbExportmaterials.get(i);
                        if(ePd.getImportmaterial().getImportMaterialID().equals(item.getItemID())){
                            exportmaterial = ePd;
                            dbExportmaterials.remove(i);
                            isExist = Boolean.TRUE;
                            break;
                        }
                    }
                    if(!isExist){
                        exportmaterial = new Exportmaterial();
                    }
                }else{
                    exportmaterial = new Exportmaterial();
                }
                saveOrUpdateExportMaterialInDetail(item, exportmaterial, bill, exportType, billPreStatus);
            }
        }
        if(dbExportmaterials!= null && !dbExportmaterials.isEmpty()){
            for(Exportmaterial expPrd : dbExportmaterials){
                Importmaterial importmaterial = expPrd.getImportmaterial();
                if(importmaterial.getRemainQuantity() <= 0){
                    importmaterial.setRemainQuantity(expPrd.getQuantity());
                    importmaterial.setStatus(Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                    importmaterial.setWarehouse(bill.getExportWarehouse());
                }else{
                    importmaterial.setRemainQuantity(importmaterial.getRemainQuantity() + expPrd.getQuantity());
                }
                this.importmaterialDAO.update(importmaterial);
            }
            this.exportmaterialDAO.deleteAll(dbExportmaterials);
        }
    }

    private void saveOrUpdateExportMaterialInDetail(ItemInfoDTO item,Exportmaterial exportmaterial,Exportmaterialbill bill,String exportType, Integer billPreStatus){
        Importmaterial importmaterial = this.importmaterialDAO.findByIdNoAutoCommit(item.getItemID());
        if(exportmaterial != null && exportmaterial.getQuantity() != null && billPreStatus.equals(Constants.WAIT_CONFIRM)){
            // case edit -> + quantity
            importmaterial.setRemainQuantity(importmaterial.getRemainQuantity() + exportmaterial.getQuantity());
        }
        Double remainQuantity = importmaterial.getRemainQuantity();
        importmaterial = updateImportMaterial(importmaterial,item,bill,exportType,exportmaterial);  // - quantity
        exportmaterial.setExportmaterialbill(bill);
        exportmaterial.setImportmaterial(importmaterial);
        exportmaterial.setPrevious(remainQuantity);
        if(exportType.equals(Constants.EXPORT_TYPE_CHUYEN_KHO)){    //TODO: required to export all quantity if not export to sell - change if require
            exportmaterial.setQuantity(remainQuantity);
        }else{
            exportmaterial.setQuantity(item.getUsedQuantity());
        }
        this.exportmaterialDAO.saveOrUpdate(exportmaterial);
    }

    private Importmaterial updateImportMaterial(Importmaterial importmaterial,ItemInfoDTO item,Exportmaterialbill bill,String exportType,Exportmaterial exportmaterial){
        if(item.getUsedQuantity() != null && item.getUsedQuantity() > 0){
            if(item.getUsedQuantity() +  0.0001d >= importmaterial.getRemainQuantity() || exportType.equals(Constants.EXPORT_TYPE_CHUYEN_KHO)){  //sai so -+ double type
                importmaterial.setStatus(Constants.ROOT_MATERIAL_STATUS_USED);
                if(exportType.equals(Constants.EXPORT_TYPE_CHUYEN_KHO)){
                    importmaterial.setStatus(Constants.ROOT_MATERIAL_STATUS_EXPORTING);
                    importmaterial.setWarehouse(bill.getReceiveWarehouse());
                }
                importmaterial.setRemainQuantity(0d);
            }else{
                importmaterial.setStatus(Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                importmaterial.setRemainQuantity(importmaterial.getRemainQuantity() - item.getUsedQuantity());
            }
            importmaterial = this.importmaterialDAO.update(importmaterial);
        }
        return importmaterial;
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                Long ID = Long.parseLong(id);
                Exportmaterialbill bill = this.exportmaterialbillDAO.findByIdNoAutoCommit(ID);
                pushMaterialBack(bill.getExportWarehouse(),bill.getExportmaterials(),Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                exportmaterialbillDAO.delete(ID);
            }
        }
        return res;
    }

    private void pushMaterialBack(Warehouse warehouse,List<Exportmaterial> exportmaterials,Integer status){  // case reject or delete
        for(Exportmaterial exportmaterial : exportmaterials){
            Importmaterial importmaterial = exportmaterial.getImportmaterial();
            importmaterial.setWarehouse(warehouse);
            importmaterial.setStatus(status);
            importmaterial.setRemainQuantity(importmaterial.getRemainQuantity() + exportmaterial.getQuantity() );
            this.importmaterialDAO.update(importmaterial);
        }
    }

    @Override
    public Object[] search(ExportmaterialbillBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            whereClause.append(" AND ( exportWarehouse.warehouseID = ").append(SecurityUtils.getPrincipal().getWarehouseID())
                    .append(" OR (receiveWarehouse.warehouseID = ").append(SecurityUtils.getPrincipal().getWarehouseID()).append(" AND status <> ").append(Constants.REJECTED)
                    .append("))");
        }
        if(bean.getCode() != null && StringUtils.isNotBlank(bean.getCode())){
            properties.put("code", bean.getCode());
        }
        if(bean.getFromDate() != null){
            whereClause.append(" AND exportDate >= '").append(bean.getFromDate()).append("'");
        }
        if(bean.getToDate() != null){
            whereClause.append(" AND exportDate <= '").append(bean.getToDate()).append("'");
        }
        if(bean.getMaterialID() != null &&  bean.getMaterialID() > 0){
            whereClause.append(" AND EXISTS (SELECT 1 FROM Exportmaterial em where em.exportmaterialbill.exportMaterialBillID = A.exportMaterialBillID AND em.importmaterial.material.materialID = ").append(bean.getMaterialID()).append(")");
        }
        if(bean.getSupplierID() != null &&  bean.getSupplierID() > 0){
            properties.put("customer.customerID",bean.getSupplierID());
        }
        if(bean.getWarehouseID() != null &&  bean.getWarehouseID() > 0){
            properties.put("receiveWarehouse.warehouseID",bean.getWarehouseID());
        }
        if(bean.getExportTypeID() != null &&  bean.getExportTypeID() > 0){
            properties.put("exporttype.exportTypeID",bean.getExportTypeID());
        }
        if(bean.getSortExpression() == null){
            bean.setSortExpression("exportDate");
        }
        if(bean.getSortDirection() == null){
            bean.setSortDirection("1");
        }
        return this.exportmaterialbillDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public void updateReject(String note, Long billID, Long loginUserId) {
        Exportmaterialbill bill = this.exportmaterialbillDAO.findByIdNoAutoCommit(billID);
        bill.setNote(note);
        bill.setStatus(Constants.REJECTED);
        User loginUser = new User();
        loginUser.setUserID(loginUserId);
        bill.setConfirmedBy(loginUser);
        bill.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        bill = this.exportmaterialbillDAO.update(bill);
        saveLog(loginUser,bill,note,0);
        pushMaterialBack(bill.getExportWarehouse(), bill.getExportmaterials(), Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
    }

    @Override
    public void updateConfirm(ExportmaterialbillBean bean) throws ObjectNotFoundException {    // confirm export
        Exportmaterialbill dbItem = this.exportmaterialbillDAO.findByIdNoAutoCommit(bean.getPojo().getExportMaterialBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Exportmaterialbill " + bean.getPojo().getExportMaterialBillID());
        dbItem.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setConfirmedBy(loginUser);
        dbItem.setStatus(Constants.CONFIRMED);
        dbItem.setNote(bean.getPojo().getNote());
        dbItem = this.exportmaterialbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,bean.getPojo().getNote(),1);
    }

    @Override
    public String getLatestPXKPL() {
        return this.exportmaterialbillDAO.getLatestPXKPL();
    }

    @Override
    public ExportMaterialReportDTO reportExportMaterial(ExportMaterialReportBean bean) {

        ExportMaterialReportDTO reportDTO = new ExportMaterialReportDTO();
        if(bean.getMaterialCategoryID() != null && bean.getMaterialCategoryID() > 0){
            Materialcategory materialcategory = materialcategoryDAO.findByIdNoAutoCommit(bean.getMaterialCategoryID());
            bean.setCateCode(materialcategory.getCode());
        }

        List<ExportMaterialReportDetailDTO> initialValue = importmaterialDAO.findAllInitialMaterial(bean);

        List<ExportMaterialReportDetailDTO> importDuringDateValue = importmaterialDAO.findAllImportDuringDate(bean);
        Object[]  objMapImportValue = mappingMaterialValue(importDuringDateValue);
        Map<String,Double> mapImportValue = (Map<String, Double>) objMapImportValue[0];
        Map<String,ExportMaterialReportDetailDTO> mappingMaterialDTO = (Map<String, ExportMaterialReportDetailDTO>) objMapImportValue[1];
        addNewImportToInitVal(initialValue, mappingMaterialDTO);

        List<ExportMaterialReportDetailDTO> exportUtilDateValue = exportmaterialDAO.findAllExportUtilDate(bean);
        Object[]  objMapExportUtilDateValue = mappingMaterialValue(exportUtilDateValue);
        Map<String,Double> mapExportUtilDateValue = (Map<String, Double>) objMapExportUtilDateValue[0];


        List<ExportMaterialReportDetailDTO> exportDuringDateValue = exportmaterialDAO.findAllExportDuringDate(bean);
        Object[]  objMapExportDuringDateValue = mappingMaterialValue(exportDuringDateValue);
        Map<String,Double> mapExportDuringDateValue = (Map<String, Double>) objMapExportDuringDateValue[0];

        reportDTO.setInitialValue(initialValue);
        reportDTO.setMapExportDuringDateValue(mapExportDuringDateValue);
        reportDTO.setMapExportUtilDateValue(mapExportUtilDateValue);
        reportDTO.setMapImportValue(mapImportValue);
        return reportDTO;
    }

    @Override
    public List<Exportmaterialbill> findAllByOrderAndDateLimit(String orderBy, Long date) {
        return this.exportmaterialbillDAO.findAllByOrderAndDateLimit(orderBy,date);  //To change body of implemented methods use File | Settings | File Templates.
    }

    private void addNewImportToInitVal(List<ExportMaterialReportDetailDTO> initialValue, Map<String, ExportMaterialReportDetailDTO> mappingMaterialDTO) {
        List<String> materialIDs = new ArrayList<String>();
        if(initialValue != null && initialValue.size() > 0){
            String key,origin;
            for(ExportMaterialReportDetailDTO detailDTO : initialValue){
                origin = detailDTO.getOrigin() != null ? detailDTO.getOrigin().getOriginID().toString() : "";
                key = detailDTO.getMaterial().getMaterialID() + "_" + origin;
                materialIDs.add(key);
            }
            for(String keyMap : mappingMaterialDTO.keySet()){
                if(!materialIDs.contains(keyMap)){
                    ExportMaterialReportDetailDTO exportMaterialReportDetailDTO = new ExportMaterialReportDetailDTO();
                    exportMaterialReportDetailDTO.setMaterial(mappingMaterialDTO.get(keyMap).getMaterial());
                    exportMaterialReportDetailDTO.setOrigin(mappingMaterialDTO.get(keyMap).getOrigin());
                    exportMaterialReportDetailDTO.setImportDate(mappingMaterialDTO.get(keyMap).getImportDate());
                    exportMaterialReportDetailDTO.setQuantity(0d);
                    initialValue.add(exportMaterialReportDetailDTO);
                }
            }

        }
    }

    private Object[] mappingMaterialValue(List<ExportMaterialReportDetailDTO> materialValues) {
        Map<String, Double> mappingMaterialValue = new HashMap<String, Double>();
        Map<String, ExportMaterialReportDetailDTO> mappingMaterialDTO = new HashMap<String, ExportMaterialReportDetailDTO>();
        if(materialValues != null && materialValues.size() > 0){
            String key, origin;
            for(ExportMaterialReportDetailDTO detailDTO : materialValues){
                origin = detailDTO.getOrigin() != null ? detailDTO.getOrigin().getOriginID().toString() : "";
                key = detailDTO.getMaterial().getMaterialID() + "_" + origin;
                mappingMaterialValue.put(key, detailDTO.getQuantity());
                mappingMaterialDTO.put(key, detailDTO);
            }
        }
        return new Object[]{mappingMaterialValue,mappingMaterialDTO};
    }
}