package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.ImportMaterialBillLogDAO;
import com.banvien.tpk.core.dao.ImportmaterialDAO;
import com.banvien.tpk.core.dao.ImportmaterialbillDAO;
import com.banvien.tpk.core.domain.ImportMaterialBillLog;
import com.banvien.tpk.core.domain.Importmaterial;
import com.banvien.tpk.core.domain.Importmaterialbill;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.ImportmaterialbillBean;
import com.banvien.tpk.core.dto.ItemInfoDTO;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ImportmaterialbillServiceImpl extends GenericServiceImpl<Importmaterialbill,Long>
        implements ImportmaterialbillService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ImportmaterialbillDAO ImportmaterialbillDAO;

    public void setImportmaterialbillDAO(ImportmaterialbillDAO ImportmaterialbillDAO) {
        this.ImportmaterialbillDAO = ImportmaterialbillDAO;
    }

    private ImportmaterialDAO importmaterialDAO;

    public void setImportmaterialDAO(ImportmaterialDAO importmaterialDAO) {
        this.importmaterialDAO = importmaterialDAO;
    }

    private ImportMaterialBillLogDAO importMaterialBillLogDAO;

    public void setImportMaterialBillLogDAO(ImportMaterialBillLogDAO importMaterialBillLogDAO) {
        this.importMaterialBillLogDAO = importMaterialBillLogDAO;
    }

    @Override
    protected GenericDAO<Importmaterialbill, Long> getGenericDAO() {
        return ImportmaterialbillDAO;
    }

    @Override
    public void updateItem(ImportmaterialbillBean bean) throws ObjectNotFoundException, DuplicateException {
        Importmaterialbill dbItem = this.ImportmaterialbillDAO.findByIdNoAutoCommit(bean.getPojo().getImportMaterialBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importmaterialbill " + bean.getPojo().getImportMaterialBillID());
        Importmaterialbill pojo = bean.getPojo();
        if(pojo.getMarket() != null && pojo.getMarket().getMarketID() == null){
            dbItem.setMarket(null);
        }else{
            dbItem.setMarket(pojo.getMarket());
        }
        if(pojo.getWarehouseMap() != null && pojo.getWarehouseMap().getWarehouseMapID() == null){
            dbItem.setWarehouseMap(null);
        }else{
            dbItem.setWarehouseMap(pojo.getWarehouseMap());
        }
        dbItem.setCode(pojo.getCode().toUpperCase());
        dbItem.setCustomer(pojo.getCustomer());
        dbItem.setWarehouse(pojo.getWarehouse());
        dbItem.setDescription(pojo.getDescription());
        dbItem.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        if(pojo.getImportDate() == null){
            dbItem.setImportDate(new Timestamp(System.currentTimeMillis()));
        }
        dbItem.setTotalMoney(null);
        dbItem.setNote(pojo.getNote());
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setUpdatedBy(loginUser);
        dbItem.setStatus(Constants.WAIT_CONFIRM);
        dbItem = this.ImportmaterialbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,pojo.getNote(),1);
        saveOrUpdateImportMaterial(dbItem.getImportMaterials(),bean.getItemInfos(),dbItem);
    }

    private void saveOrUpdateImportMaterial(List<Importmaterial> dbImportMaterials, List<ItemInfoDTO> itemInfoDTOs, Importmaterialbill bill){
        for(ItemInfoDTO item : itemInfoDTOs){
            if(item.getMaterial() != null && item.getMaterial().getMaterialID() != null && item.getMaterial().getMaterialID() > 0 && item.getQuantity() != null){
                Importmaterial importmaterial = null;
                if(dbImportMaterials !=null && dbImportMaterials.size() > 0){ //case update
                    for(int i = dbImportMaterials.size() - 1; i >= 0; i--){
                        Importmaterial dbImportMaterial = dbImportMaterials.get(i);
                        if(dbImportMaterial.getMaterial().getMaterialID().equals(item.getMaterial().getMaterialID())){
                            importmaterial = dbImportMaterial;
                            dbImportMaterials.remove(i);
                            break;
                        }
                    }
                    if(importmaterial == null){
                        importmaterial = new Importmaterial();
                        saveOrUpdateImportMaterialInDetail(item,importmaterial,bill);
                    }else{
                        saveOrUpdateImportMaterialInDetail(item,importmaterial,bill);
                    }
                }else{ //case add new
                    importmaterial = new Importmaterial();
                    saveOrUpdateImportMaterialInDetail(item,importmaterial,bill);
                }
            }
        }
        if(dbImportMaterials!= null && !dbImportMaterials.isEmpty()){
            this.importmaterialDAO.deleteAll(dbImportMaterials);
        }
    }

    private void saveOrUpdateImportMaterialInDetail(ItemInfoDTO item, Importmaterial importmaterial,Importmaterialbill bill){
        importmaterial.setImportmaterialbill(bill);
        importmaterial.setCode(item.getCode().toUpperCase());
        importmaterial.setWarehouse(bill.getWarehouse());
        importmaterial.setStatus(Constants.ROOT_MATERIAL_STATUS_WAIT_CONFIRM);
        importmaterial.setImportDate(bill.getImportDate());
        importmaterial.setMaterial(item.getMaterial());
        if(bill.getWarehouseMap() != null && bill.getWarehouseMap().getWarehouseMapID() != null && bill.getWarehouseMap().getWarehouseMapID() > 0){
            importmaterial.setWarehouseMap(bill.getWarehouseMap());
        }
        else{
            importmaterial.setWarehouseMap(null);
        }
        if(item.getExpiredDate() != null){
            importmaterial.setExpiredDate(item.getExpiredDate());
        }else{
            importmaterial.setExpiredDate(null);
        }
        if(item.getOrigin() != null && item.getOrigin().getOriginID() != null && item.getOrigin().getOriginID() > 0){
            importmaterial.setOrigin(item.getOrigin());
        }
        else{
            importmaterial.setOrigin(null);
        }
        if(bill.getMarket() != null && bill.getMarket().getMarketID() != null && bill.getMarket().getMarketID() > 0){
            importmaterial.setMarket(bill.getMarket());
        }
        else{
            importmaterial.setMarket(null);
        }
        if(item.getQuantity() != null && item.getQuantity() > 0){
            importmaterial.setQuantity(item.getQuantity());
            importmaterial.setRemainQuantity(item.getQuantity());
        }
        else{
            importmaterial.setQuantity(null);
            importmaterial.setRemainQuantity(null);
        }
        if(item.getNote() != null && StringUtils.isNotBlank(item.getNote())){
            importmaterial.setNote(item.getNote());
        }
        else{
            importmaterial.setNote(null);
        }
        importmaterialDAO.saveOrUpdate(importmaterial);
    }

    @Override
    public void addNew(ImportmaterialbillBean bean) throws DuplicateException {
        Importmaterialbill pojo = bean.getPojo();
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        pojo.setCreatedBy(loginUser);
        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        if(pojo.getImportDate() == null){
            pojo.setImportDate(new Timestamp(System.currentTimeMillis()));
        }
        if(pojo.getMarket() != null && pojo.getMarket().getMarketID() == null){
            pojo.setMarket(null);
        }
        if(pojo.getWarehouseMap() != null && pojo.getWarehouseMap().getWarehouseMapID() == null){
            pojo.setWarehouseMap(null);
        }
        pojo.setCode(pojo.getCode().toUpperCase());
        pojo.setStatus(Constants.WAIT_CONFIRM);
        pojo = this.ImportmaterialbillDAO.save(pojo);
        saveLog(loginUser,pojo,pojo.getNote(),1);
        saveOrUpdateImportMaterial(null,bean.getItemInfos(),pojo);
    }

    private void saveLog(User loginUser,Importmaterialbill bill,String note, Integer status){
        ImportMaterialBillLog log = new ImportMaterialBillLog();
        log.setImportmaterialbill(bill);
        log.setNote(note);
        log.setStatus(status);
        log.setCreatedBy(loginUser);
        log.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        importMaterialBillLogDAO.save(log);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                Long ID = Long.parseLong(id);
                ImportmaterialbillDAO.delete(ID);
            }
        }
        return res;
    }

    @Override
    public Object[] search(ImportmaterialbillBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        if(bean.getCode() != null && StringUtils.isNotBlank(bean.getCode())){
            properties.put("code",bean.getCode());
        }
        if(bean.getFromDate() != null){
            whereClause.append(" AND importDate >= '").append(bean.getFromDate()).append("'");
        }
        if(bean.getToDate() != null){
            whereClause.append(" AND importDate <= '").append(bean.getToDate()).append("'");
        }
        if(bean.getSupplierID() != null &&  bean.getSupplierID() > 0){
            properties.put("customer.customerID",bean.getSupplierID());
        }
        if(bean.getMaterialID() != null &&  bean.getMaterialID() > 0){
            whereClause.append(" AND EXISTS (SELECT 1 FROM Importmaterial im where im.importmaterialbill.importMaterialBillID = A.importMaterialBillID AND im.material.materialID = ").append(bean.getMaterialID()).append(")");
        }
        if(bean.getWarehouseID() != null &&  bean.getWarehouseID() > 0){
            properties.put("warehouse.warehouseID",bean.getWarehouseID());
        }
        if(bean.getSortExpression() == null){
            bean.setSortExpression("importDate");
        }
        if(bean.getSortDirection() == null){
            bean.setSortDirection("1");
        }
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            properties.put("warehouse.warehouseID", SecurityUtils.getPrincipal().getWarehouseID());
        }
        properties.put("billGroup",Constants.MATERIAL_GROUP_BUY);
        return this.ImportmaterialbillDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public void updateReject(String note, Long billID, Long userID) {
        Importmaterialbill bill = this.ImportmaterialbillDAO.findByIdNoAutoCommit(billID);
        bill.setNote(note);
        bill.setStatus(Constants.REJECTED);
        User loginUser = new User();
        loginUser.setUserID(userID);
        bill.setConfirmedBy(loginUser);
        bill.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        this.ImportmaterialbillDAO.update(bill);
        saveLog(loginUser,bill,note,0);
    }

    @Override
    public void updateConfirm(ImportmaterialbillBean bean) throws ObjectNotFoundException {
        Importmaterialbill dbItem = this.ImportmaterialbillDAO.findByIdNoAutoCommit(bean.getPojo().getImportMaterialBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importmaterialbill " + bean.getPojo().getImportMaterialBillID());
        dbItem.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setConfirmedBy(loginUser);
        dbItem.setStatus(Constants.CONFIRMED);
        dbItem = this.ImportmaterialbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,bean.getPojo().getNote(),1);
        for(Importmaterial item : dbItem.getImportMaterials()){
            item.setStatus(Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
            importmaterialDAO.update(item);
        }
    }

    @Override
    public String getLatestPNKPL() {
        return this.ImportmaterialbillDAO.getLatestPNKPL();
    }

    @Override
    public void updateConfirmMoney(ImportmaterialbillBean bean) throws ObjectNotFoundException {
        Importmaterialbill dbItem = this.ImportmaterialbillDAO.findByIdNoAutoCommit(bean.getPojo().getImportMaterialBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importmaterialbill " + bean.getPojo().getImportMaterialBillID());
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setTotalMoney(bean.getPojo().getTotalMoney());
        dbItem = this.ImportmaterialbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,bean.getPojo().getNote(),1);
        for(Importmaterial item : dbItem.getImportMaterials()){
            item.setMoney(bean.getMaterialMoneyMap().get(item.getImportMaterialID()));
            importmaterialDAO.update(item);
        }
    }

    @Override
    public List<Importmaterialbill> findAllByOrderAndDateLimit(String orderBy, Long date) {
        return this.ImportmaterialbillDAO.findAllByOrderAndDateLimit(orderBy,date);
    }
}