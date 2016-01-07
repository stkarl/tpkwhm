package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.*;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.ExportproductbillBean;
import com.banvien.tpk.core.dto.ItemInfoDTO;
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

public class ExportproductbillServiceImpl extends GenericServiceImpl<Exportproductbill,Long>
                                                    implements ExportproductbillService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ExportproductbillDAO exportproductbillDAO;

    public void setExportproductbillDAO(ExportproductbillDAO exportproductbillDAO) {
        this.exportproductbillDAO = exportproductbillDAO;
    }

    private ExportproductDAO exportproductDAO;

    public void setExportproductDAO(ExportproductDAO exportproductDAO) {
        this.exportproductDAO = exportproductDAO;
    }

    private ImportproductDAO importproductDAO;

    public void setImportproductDAO(ImportproductDAO importproductDAO) {
        this.importproductDAO = importproductDAO;
    }

    private ImportproductbillDAO importproductbillDAO;

    public void setImportproductbillDAO(ImportproductbillDAO importproductbillDAO) {
        this.importproductbillDAO = importproductbillDAO;
    }


    private ExportProductBillLogDAO exportProductBillLogDAO;

    public void setExportProductBillLogDAO(ExportProductBillLogDAO exportProductBillLogDAO) {
        this.exportProductBillLogDAO = exportProductBillLogDAO;
    }

    private CustomerDAO customerDAO;

    public void setCustomerDAO(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    private ProductionPlanDAO productionPlanDAO;

    public void setProductionPlanDAO(ProductionPlanDAO productionPlanDAO) {
        this.productionPlanDAO = productionPlanDAO;
    }

    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Override
	protected GenericDAO<Exportproductbill, Long> getGenericDAO() {
		return exportproductbillDAO;
	}

    @Override
    public void updateExportRootMaterialBill(ExportproductbillBean bean) throws ObjectNotFoundException, DuplicateException {
        Exportproductbill dbItem = this.exportproductbillDAO.findByIdNoAutoCommit(bean.getPojo().getExportProductBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Exportproductbill " + bean.getPojo().getExportProductBillID());
        Exportproductbill pojo = bean.getPojo();
        verifyPojo(pojo);
        dbItem.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        if(pojo.getExportDate() == null){
            dbItem.setExportDate(new Timestamp(System.currentTimeMillis()));
        }else{
            dbItem.setExportDate(pojo.getExportDate());
        }
        User loginUser = this.userDAO.findByIdNoAutoCommit(bean.getLoginID());
        dbItem.setUpdatedBy(loginUser);
        dbItem.setStatus(Constants.WAIT_CONFIRM);
        if((pojo.getExporttype() != null && pojo.getExporttype().getExportTypeID() != null && pojo.getExporttype().getExportTypeID() > 0 && pojo.getExporttype().getCode() != null) || (dbItem.getBookProductBill() != null)){
            if(dbItem.getBookProductBill() == null){
                dbItem.setCode(pojo.getCode().toUpperCase());
                dbItem.setDescription(pojo.getDescription());
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
                }else if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_SAN_XUAT)){
                    dbItem.setStatus(Constants.CONFIRMED);
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
                if(pojo.getProductionPlan() != null && pojo.getProductionPlan().getProductionPlanID() != null &&  pojo.getProductionPlan().getProductionPlanID() > 0){
                    ProductionPlan plan = this.productionPlanDAO.findByIdNoAutoCommit(pojo.getProductionPlan().getProductionPlanID());
                    dbItem.setExportDate(plan.getDate());
                }
            }
            if(loginUser.getRole().equals(Constants.QLKHO_ROLE)){
                dbItem.setStatus(Constants.CONFIRMED);
            }
            dbItem.setVehicle(pojo.getVehicle());
            dbItem = this.exportproductbillDAO.update(dbItem);
            saveLog(loginUser,dbItem,pojo.getNote(),1);

            saveOrUpdateExportProduct(dbItem.getExportproducts(), bean.getItemInfos(), dbItem,pojo.getExporttype().getCode());
        }
    }

    private void saveOrUpdateExportProduct(List<Exportproduct> dbExportproducts, List<ItemInfoDTO> itemInfoDTOs, Exportproductbill bill,String exportType){
        for(ItemInfoDTO item : itemInfoDTOs){
            if(item.getItemID() != null && item.getItemID() > 0){
                Exportproduct exportproduct = null;
                if(dbExportproducts != null && dbExportproducts.size() > 0){          // case update
                    for(int i = dbExportproducts.size() - 1; i >= 0; i--){
                        Exportproduct ePd = dbExportproducts.get(i);
                        if(ePd.getImportproduct().getImportProductID().equals(item.getItemID())){
                            exportproduct = ePd;
                            dbExportproducts.remove(i);
                            break;
                        }
                    }
                    if(exportproduct == null){
                        saveExportProductInDetail(item,exportproduct,bill,exportType);
                    }else{
                        updateImportProduct(item,bill,exportType);
                    }
                }else{ //case add new
                    saveExportProductInDetail(item,exportproduct,bill,exportType);
                }
            }
        }
        List<Long> dragBackProducts = new ArrayList<Long>();
        if(dbExportproducts!= null && !dbExportproducts.isEmpty()){
            for(Exportproduct expPrd : dbExportproducts){
                dragBackProducts.add(expPrd.getImportproduct().getImportProductID());
            }
            if(bill.getBookProductBill() != null){
                this.importproductDAO.updateDragBackProducts(bill.getExportWarehouse().getWarehouseID(), dragBackProducts,Constants.ROOT_MATERIAL_STATUS_BOOKED);
            }else{
                this.importproductDAO.updateDragBackProducts(bill.getExportWarehouse().getWarehouseID(), dragBackProducts,Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
            }
            this.exportproductDAO.deleteAll(dbExportproducts);
        }
    }

    private void saveExportProductInDetail(ItemInfoDTO item,Exportproduct exportproduct,Exportproductbill bill,String exportType){
        Importproduct importproduct = updateImportProduct(item,bill,exportType);
        exportproduct = new Exportproduct();
        exportproduct.setExportproductbill(bill);
        exportproduct.setImportproduct(importproduct);
        this.exportproductDAO.save(exportproduct);
    }

    private Importproduct updateImportProduct(ItemInfoDTO item,Exportproductbill bill,String exportType){
        Importproduct importproduct = this.importproductDAO.findByIdNoAutoCommit(item.getItemID());
        importproduct.setStatus(Constants.ROOT_MATERIAL_STATUS_USED);
        if(exportType.equals(Constants.EXPORT_TYPE_CHUYEN_KHO)){
            importproduct.setStatus(Constants.ROOT_MATERIAL_STATUS_EXPORTING);
        }else if(exportType.equals(Constants.EXPORT_TYPE_SAN_XUAT)){
            importproduct.setStatus(Constants.ROOT_MATERIAL_STATUS_WAIT_TO_USE);
        }else if(exportType.equals(Constants.EXPORT_TYPE_BAN)){
        }else{
        }
        importproduct = this.importproductDAO.update(importproduct);
        return importproduct;
    }

    private void verifyPojo(Exportproductbill pojo){
        if(pojo.getProductionPlan() != null && pojo.getProductionPlan().getProductionPlanID() == null){
            pojo.setProductionPlan(null);
        }
        if(pojo.getCustomer() != null && pojo.getCustomer().getCustomerID() == null){
            pojo.setCustomer(null);
        }
        if(pojo.getReceiveWarehouse() != null && pojo.getReceiveWarehouse().getWarehouseID() == null){
            pojo.setReceiveWarehouse(null);
        }
    }

    @Override
    public void addExportRootMaterialBill(ExportproductbillBean bean) throws DuplicateException {
        Exportproductbill pojo = bean.getPojo();
        verifyPojo(pojo);
        User loginUser = this.userDAO.findByIdNoAutoCommit(bean.getLoginID());
        pojo.setCreatedBy(loginUser);
        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        if(pojo.getExportDate() == null){
            pojo.setExportDate(new Timestamp(System.currentTimeMillis()));
        }
        pojo.setStatus(Constants.WAIT_CONFIRM);
        if(pojo.getExporttype() != null && pojo.getExporttype().getExportTypeID() != null && pojo.getExporttype().getCode() != null){
            if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_BAN)){
                pojo.setReceiveWarehouse(null);
                pojo.setProductionPlan(null);
            }else if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_CHUYEN_KHO)){
                pojo.setCustomer(null);
                pojo.setProductionPlan(null);

            }else if(pojo.getExporttype().getCode().equals(Constants.EXPORT_TYPE_SAN_XUAT)){
                pojo.setStatus(Constants.CONFIRMED);
                pojo.setCustomer(null);
                pojo.setReceiveWarehouse(null);
            }else{
                pojo.setCustomer(null);
                pojo.setReceiveWarehouse(null);
                pojo.setProductionPlan(null);
            }

            pojo.setCode(pojo.getCode().toUpperCase());
            if(pojo.getProductionPlan() != null && pojo.getProductionPlan().getProductionPlanID() != null &&  pojo.getProductionPlan().getProductionPlanID() > 0){
                ProductionPlan plan = this.productionPlanDAO.findByIdNoAutoCommit(pojo.getProductionPlan().getProductionPlanID());
                pojo.setExportDate(plan.getDate());
            }
            if(loginUser.getRole().equals(Constants.QLKHO_ROLE)){
                pojo.setStatus(Constants.CONFIRMED);
            }
            pojo = this.exportproductbillDAO.save(pojo);
            saveLog(loginUser,pojo,pojo.getNote(),1);
            saveOrUpdateExportProduct(null, bean.getItemInfos(), pojo,pojo.getExporttype().getCode());
        }
    }

    private void saveLog(User loginUser,Exportproductbill bill,String note, Integer status){
        ExportProductBillLog log = new ExportProductBillLog();
        log.setExportproductbill(bill);
        log.setNote(note);
        log.setStatus(status);
        log.setCreatedBy(loginUser);
        log.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        exportProductBillLogDAO.save(log);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                Long ID = Long.parseLong(id);
                Exportproductbill bill = this.exportproductbillDAO.findByIdNoAutoCommit(ID);
                if(bill.getBookProductBill() != null){
                    updateDragBackExportBookProduct(bill, Constants.ROOT_MATERIAL_STATUS_BOOKED);
                }else{
                    updateDragBackExportBookProduct(bill, Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                }
                exportproductbillDAO.delete(ID);
            }
        }
        return res;
    }

    @Override
    public Object[] search(ExportproductbillBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            whereClause.append(" AND ( exportWarehouse.warehouseID = ").append(SecurityUtils.getPrincipal().getWarehouseID())
            .append(" OR (receiveWarehouse.warehouseID = ").append(SecurityUtils.getPrincipal().getWarehouseID()).append(" AND status <> ").append(Constants.REJECTED)
            .append(" AND status <> ").append(Constants.WAIT_CONFIRM).append("))");
        }
        if(bean.getCode() != null && StringUtils.isNotBlank(bean.getCode())){
            properties.put("code",bean.getCode());
        }
        if(StringUtils.isNotBlank(bean.getProductCode())){
            whereClause.append(" AND EXISTS(SELECT 1 FROM Exportproduct ep WHERE ep.exportproductbill.exportProductBillID = A.exportProductBillID")
                    .append(" AND ep.importproduct.productCode = '").append(bean.getProductCode()).append("')");
        }
        if(bean.getFromDate() != null){
            whereClause.append(" AND exportDate >= '").append(bean.getFromDate()).append("'");
        }
        if(bean.getToDate() != null){
            whereClause.append(" AND exportDate <= '").append(bean.getToDate()).append("'");
        }
        if(bean.getCustomerID() != null &&  bean.getCustomerID() > 0){
            properties.put("customer.customerID",bean.getCustomerID());
        }
        if(bean.getWarehouseID() != null &&  bean.getWarehouseID() > 0){
            properties.put("receiveWarehouse.warehouseID",bean.getWarehouseID());
        }
        if(bean.getExportTypeID() != null &&  bean.getExportTypeID() > 0){
            properties.put("exporttype.exportTypeID",bean.getExportTypeID());
        }
        if(bean.getIsBlackProduct()){
            whereClause.append(" AND EXISTS(SELECT 1 FROM Exportproduct ep WHERE ep.exportproductbill.exportProductBillID = A.exportProductBillID")
            .append(" AND ep.importproduct.productname.code = '").append(Constants.PRODUCT_BLACK).append("')");
        }else{
            whereClause.append(" AND EXISTS(SELECT 1 FROM Exportproduct ep WHERE ep.exportproductbill.exportProductBillID = A.exportProductBillID")
                    .append(" AND ep.importproduct.productname.code <> '").append(Constants.PRODUCT_BLACK).append("')");
        }
        if(bean.getSortExpression() == null &&  bean.getSortDirection() == null){
            bean.setSortExpression("exportDate");
            bean.setSortDirection("1");
        }
        return this.exportproductbillDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public void updateReject(String note, Long billID, Long userID) {
        Exportproductbill bill = updateRejectGeneral(note, billID, userID);
        if(bill.getBookProductBill() == null){
//            updateDragBackExportBookProduct(bill, Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
        }else{
            updateDragBackExportBookProduct(bill, Constants.ROOT_MATERIAL_STATUS_BOOKED);
        }
    }

    private Exportproductbill updateRejectGeneral(String note, Long billID, Long userID) {
        Exportproductbill bill = this.exportproductbillDAO.findByIdNoAutoCommit(billID);
        bill.setNote(note);
        bill.setStatus(Constants.REJECTED);
        User loginUser = new User();
        loginUser.setUserID(userID);
        bill.setConfirmedBy(loginUser);
        bill.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        bill = this.exportproductbillDAO.update(bill);
        saveLog(loginUser,bill,note,0);
        return bill;
    }

    @Override
    public void updateRejectTransfer(String note, Long billID, Long userID) {
        updateRejectGeneral(note, billID, userID);
    }

    private void updateDragBackExportBookProduct(Exportproductbill bill,Integer status){
        List<Long> dragBackProducts = new ArrayList<Long>();
        for(Exportproduct expPrd : bill.getExportproducts()){
            dragBackProducts.add(expPrd.getImportproduct().getImportProductID());
        }
        this.importproductDAO.updateDragBackProducts(bill.getExportWarehouse().getWarehouseID(), dragBackProducts, status);
    }

    @Override
    public void updateConfirm(ExportproductbillBean bean) throws ObjectNotFoundException {
        updateConfirm(bean,Constants.CONFIRMED);
    }

    private Exportproductbill updateConfirm(ExportproductbillBean bean, Integer confirmed) throws ObjectNotFoundException {
        Exportproductbill dbItem = this.exportproductbillDAO.findByIdNoAutoCommit(bean.getPojo().getExportProductBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Exportproductbill " + bean.getPojo().getExportProductBillID());
        dbItem.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setConfirmedBy(loginUser);
        dbItem.setStatus(confirmed);
        dbItem.setNote(bean.getPojo().getNote());
        dbItem = this.exportproductbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,bean.getPojo().getNote(),1);
        return dbItem;
    }


    @Override
    public void updateConfirmTransfer(ExportproductbillBean bean) throws ObjectNotFoundException {
        Exportproductbill dbItem = updateConfirm(bean,Constants.CONFIRMED_TRANSFER);
        if(dbItem.getExporttype().getCode().equals(Constants.EXPORT_TYPE_CHUYEN_KHO)){
            for(Exportproduct item : dbItem.getExportproducts()){
                Importproduct importproduct = item.getImportproduct();
                importproduct.setStatus(Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                importproduct.setWarehouse(dbItem.getReceiveWarehouse());
                importproductDAO.update(importproduct);
            }
        }
    }

    @Override
    public String getLatestPXKTON() {
        return this.exportproductbillDAO.getLatestPXKTON();
    }

    @Override
    public List<Exportproductbill> findAllByOrderAndDateLimit(String importDate, Boolean black, Long date) {
        return exportproductbillDAO.findAllByOrderAndDateLimit(importDate,black,date);  //To change body of implemented methods use File | Settings | File Templates.
    }
}