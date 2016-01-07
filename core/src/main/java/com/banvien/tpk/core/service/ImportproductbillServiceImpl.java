package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.*;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.ImportBackDTO;
import com.banvien.tpk.core.dto.ImportproductbillBean;
import com.banvien.tpk.core.dto.ItemInfoDTO;
import com.banvien.tpk.core.dto.MainMaterialInfoDTO;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.util.GeneratorUtils;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ImportproductbillServiceImpl extends GenericServiceImpl<Importproductbill,Long>
        implements ImportproductbillService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ImportproductbillDAO ImportproductbillDAO;

    public void setImportproductbillDAO(ImportproductbillDAO ImportproductbillDAO) {
        this.ImportproductbillDAO = ImportproductbillDAO;
    }

    private ImportproductDAO importproductDAO;

    public void setImportproductDAO(ImportproductDAO importproductDAO) {
        this.importproductDAO = importproductDAO;
    }

    private ProductnameDAO productnameDAO;

    public void setProductnameDAO(ProductnameDAO productnameDAO) {
        this.productnameDAO = productnameDAO;
    }

    private UnitDAO unitDAO;

    public void setUnitDAO(UnitDAO unitDAO) {
        this.unitDAO = unitDAO;
    }

    private QualityDAO qualityDAO;

    public void setQualityDAO(QualityDAO qualityDAO) {
        this.qualityDAO = qualityDAO;
    }

    private ProductqualityDAO productqualityDAO;

    public void setProductqualityDAO(ProductqualityDAO productqualityDAO) {
        this.productqualityDAO = productqualityDAO;
    }

    private ImportProductBillLogDAO importProductBillLogDAO;

    public void setImportProductBillLogDAO(ImportProductBillLogDAO importProductBillLogDAO) {
        this.importProductBillLogDAO = importProductBillLogDAO;
    }

    private ProductionPlanDAO productionPlanDAO;

    public void setProductionPlanDAO(ProductionPlanDAO productionPlanDAO) {
        this.productionPlanDAO = productionPlanDAO;
    }

    @Override
    protected GenericDAO<Importproductbill, Long> getGenericDAO() {
        return ImportproductbillDAO;
    }

    @Override
    public void updateRootMaterialBill(ImportproductbillBean bean) throws ObjectNotFoundException, DuplicateException {
        Importproductbill dbItem = this.ImportproductbillDAO.findByIdNoAutoCommit(bean.getPojo().getImportProductBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importproductbill " + bean.getPojo().getImportProductBillID());
        Importproductbill pojo = bean.getPojo();
        dbItem.setCode(pojo.getCode().toUpperCase());
        dbItem.setCustomer(pojo.getCustomer());
        dbItem.setDescription(pojo.getDescription());
        if(pojo.getWarehouseMap() != null && pojo.getWarehouseMap().getWarehouseMapID() == null){
            dbItem.setWarehouseMap(null);
        }else{
            dbItem.setWarehouseMap(pojo.getWarehouseMap());
        }
        if(pojo.getMarket() != null && pojo.getMarket().getMarketID() == null){
            dbItem.setMarket(null);
        }else{
            dbItem.setMarket(pojo.getMarket());
        }
        if(pojo.getImportDate() == null){
            dbItem.setImportDate(new Timestamp(System.currentTimeMillis()));
        }
        dbItem.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setUpdatedBy(loginUser);
        dbItem.setStatus(Constants.WAIT_CONFIRM);
        if(pojo.getTempBill() != null && pojo.getTempBill()){
            dbItem.setStatus(Constants.CONFIRMED);
            dbItem.setTempBill(Boolean.TRUE);
        }
        dbItem = this.ImportproductbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,pojo.getNote(),1);
        saveOrUpdateImportProduct(dbItem.getImportproducts(), bean.getItemInfos(), dbItem);
    }

    private void saveOrUpdateImportProduct(List<Importproduct> dbImportProducts, List<ItemInfoDTO> itemInfoDTOs, Importproductbill bill) throws DuplicateException {
        Productname productname = this.productnameDAO.findByCode(Constants.PRODUCT_BLACK).get(0);
        Unit unitM = this.unitDAO.findByName(Constants.UNIT_MET).get(0);
        Unit unitKg = this.unitDAO.findByName(Constants.UNIT_KG).get(0);
        for(ItemInfoDTO item : itemInfoDTOs){
            if(item.getCode() != null && StringUtils.isNotBlank(item.getCode()) &&
                    (item.getQuantityM() != null || item.getQuantityKg() != null ||
                            item.getQuantityPure() != null || item.getQuantityActual() != null || item.getQuantityOverall() != null)){
                Importproduct importproduct = null;
                if(dbImportProducts != null && dbImportProducts.size() > 0){ //case update
                    for(int i = dbImportProducts.size() - 1; i >= 0; i--){
                        Importproduct dbImportProduct = dbImportProducts.get(i);
                        if(dbImportProduct.getProductCode().equalsIgnoreCase(item.getCode())){
                            importproduct = dbImportProduct;
                            dbImportProducts.remove(i);
                            break;
                        }
                    }
                    if(importproduct == null){
                        importproduct = new Importproduct();
                        saveOrUpdateImportProductInDetail(item,importproduct,bill,productname,unitM,unitKg,true,null);
                    }else{
                        saveOrUpdateImportProductInDetail(item,importproduct,bill,productname,unitM,unitKg,true,null);
                    }
                }else{ //case add new
                    importproduct = new Importproduct();
                    saveOrUpdateImportProductInDetail(item,importproduct,bill,productname,unitM,unitKg,true,null);
                }
            }
        }
        if(dbImportProducts!= null && !dbImportProducts.isEmpty()){
            this.importproductDAO.deleteAll(dbImportProducts);
        }
    }

    private void saveOrUpdateImportProductInDetail(ItemInfoDTO item, Importproduct importproduct,Importproductbill bill,Productname productname,Unit unitM,Unit unitKg,Boolean isBlackProduct,Importproduct mainMaterial) throws DuplicateException {
        importproduct.setImportproductbill(bill);
        importproduct.setProductname(productname);
        importproduct.setProductCode(item.getCode().toUpperCase());
        importproduct.setWarehouse(bill.getWarehouse());
        if(bill.getWarehouseMap() != null && bill.getWarehouseMap().getWarehouseMapID() != null && bill.getWarehouseMap().getWarehouseMapID() > 0){
            importproduct.setWarehouseMap(bill.getWarehouseMap());
        }  else{
            importproduct.setWarehouseMap(null);
        }
        importproduct.setStatus(Constants.ROOT_MATERIAL_STATUS_WAIT_CONFIRM);
        if(bill.getTempBill() != null && bill.getTempBill()){
            importproduct.setStatus(Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
        }
        if(isBlackProduct){
            importproduct.setImportDate(bill.getImportDate());
        }else{
            importproduct.setProduceDate(bill.getProduceDate());
        }

        if(item.getSize() != null && item.getSize().getSizeID() != null && item.getSize().getSizeID() > 0){
            importproduct.setSize(item.getSize());
        }
        else{
            importproduct.setSize(null);
        }
        if(item.getThickness() != null && item.getThickness().getThicknessID() != null && item.getThickness().getThicknessID() > 0){
            importproduct.setThickness(item.getThickness());
        }
        else{
            importproduct.setThickness(null);
        }
        if(item.getStiffness() != null && item.getStiffness().getStiffnessID() != null && item.getStiffness().getStiffnessID() > 0){
            importproduct.setStiffness(item.getStiffness());
        }
        else{
            importproduct.setStiffness(null);
        }
        if(item.getColour() != null && item.getColour().getColourID() != null && item.getColour().getColourID() > 0){
            importproduct.setColour(item.getColour());
        }
        else{
            importproduct.setColour(null);
        }
        if(item.getOrigin() != null && item.getOrigin().getOriginID() != null && item.getOrigin().getOriginID() > 0){
            importproduct.setOrigin(item.getOrigin());
        }
        else{
            importproduct.setOrigin(null);
        }
        if(item.getMarket() != null && item.getMarket().getMarketID() != null && item.getMarket().getMarketID() > 0){
            importproduct.setMarket(item.getMarket());
        }
        else{
            importproduct.setMarket(null);
        }
        if(item.getOverlayType() != null && item.getOverlayType().getOverlayTypeID() != null && item.getOverlayType().getOverlayTypeID() > 0){
            importproduct.setOverlaytype(item.getOverlayType());
        }
        else{
            importproduct.setOverlaytype(null);
        }
        if(mainMaterial != null){
            importproduct.setMainUsedMaterialCode(mainMaterial.getProductCode());
            importproduct.setMainUsedMaterial(mainMaterial);
        }
        else{
            importproduct.setMainUsedMaterial(null);
            importproduct.setMainUsedMaterialCode(null);
        }
        if(item.getQuantityM() != null && item.getQuantityM() > 0){
            importproduct.setUnit1(unitM);
            importproduct.setQuantity1(item.getQuantityM());
        }
        else{
            importproduct.setUnit1(null);
            importproduct.setQuantity1(null);
        }
        if((item.getQuantityKg() != null && item.getQuantityKg() > 0) ||
                (item.getQuantityOverall() != null && item.getQuantityOverall() > 0) ||
                (item.getQuantityPure() != null && item.getQuantityPure() > 0) ||
                (item.getQuantityActual() != null && item.getQuantityActual() > 0)){
            importproduct.setUnit2(unitKg);
        }else{
            importproduct.setUnit2(null);
        }

        if(item.getQuantityOverall() != null && item.getQuantityOverall() > 0){
            importproduct.setQuantity2(item.getQuantityOverall());
        }else if(item.getQuantityKg() != null && item.getQuantityKg() > 0){
            importproduct.setQuantity2(item.getQuantityKg());
        }
        else{
            importproduct.setQuantity2(null);
        }

        if(item.getQuantityPure() != null && item.getQuantityPure() > 0){
            importproduct.setQuantity2Pure(item.getQuantityPure());
        }
        if(item.getQuantityActual() != null && item.getQuantityActual() > 0){
            importproduct.setQuantity2Actual(item.getQuantityActual());
        }
        if(item.getCore() != null && StringUtils.isNotBlank(item.getCore())){
            importproduct.setCore(item.getCore());
        }
        else{
            importproduct.setCore(null);
        }
        if(item.getNote() != null && StringUtils.isNotBlank(item.getNote())){
            importproduct.setNote(item.getNote());
        }
        else{
            importproduct.setNote(null);
        }
        if(item.getProduceTeam() != null && StringUtils.isNotBlank(item.getProduceTeam())){
            importproduct.setProducedTeam(item.getProduceTeam());
        }
        else{
            importproduct.setProducedTeam(null);
        }
        try {
            importproductDAO.saveOrUpdate(importproduct);
        } catch (Exception e) {
            throw new DuplicateException("Có lỗi xảy ra, có thể mã tôn đã có trong hệ thống, vui lòng kiểm tra lại: " + importproduct.getProductCode() + "\n (" + e.getMessage() + ")");
        }
        if(item.getQualityQuantityMap() != null && item.getQualityQuantityMap().size() > 0 ){
            saveOrUpDateProductQuality(importproduct,item.getQualityQuantityMap(), unitM, null);
        }
    }

    private void saveOrUpDateProductQuality(Importproduct importproduct, Map<Long,Double> qualityQuantityMap, Unit unitM, Double oldMet){
        List<Productquality> dbProductQualities = importproduct.getProductqualitys();
        Productquality productquality = null;
        Double total = 0d;
        if(qualityQuantityMap != null){
            for(Long qualityID : qualityQuantityMap.keySet()){
                if(qualityQuantityMap.get(qualityID) != null && qualityQuantityMap.get(qualityID) > 0){
                    if(dbProductQualities != null && dbProductQualities.size() > 0){
                        for(int i = dbProductQualities.size() - 1; i >= 0; i--){
                            Productquality dbProductQuality = dbProductQualities.get(i);
                            if(dbProductQuality.getQuality().getQualityID().equals(qualityID)){
                                productquality = dbProductQuality;
                                dbProductQualities.remove(i);
                                break;
                            }
                        }
                        if(productquality == null){
                            productquality = new Productquality();
                            saveOrUpdateProductQualityInDetail(productquality,importproduct,qualityID,qualityQuantityMap.get(qualityID),unitM);
                        }else{
                            saveOrUpdateProductQualityInDetail(productquality,importproduct,qualityID,qualityQuantityMap.get(qualityID),unitM);
                        }
                    } else{
                        productquality = new Productquality();
                        saveOrUpdateProductQualityInDetail(productquality,importproduct,qualityID,qualityQuantityMap.get(qualityID),unitM);
                    }
                    total += qualityQuantityMap.get(qualityID);
                }
            }
            importproduct.setUnit1(unitM);
            importproduct.setQuantity1(total);
            importproductDAO.update(importproduct);
        }
        if(oldMet != null && oldMet != total && importproduct.getMainUsedMaterial() != null && importproduct.getMainUsedMaterial().getProductname().getCode().equalsIgnoreCase(Constants.PRODUCT_BLACK)){
            Double old = importproduct.getMainUsedMaterial().getQuantity1() != null ? importproduct.getMainUsedMaterial().getQuantity1() : 0;
            importproduct.getMainUsedMaterial().setQuantity1(old + (total - oldMet));
        }
        if(dbProductQualities!= null && !dbProductQualities.isEmpty()){
            this.productqualityDAO.deleteAll(dbProductQualities);
        }
    }

    private void saveOrUpdateProductQualityInDetail(Productquality productquality,Importproduct importproduct,Long qualityID,Double quantity,Unit unitM){
        Quality quality = this.qualityDAO.findByIdNoAutoCommit(qualityID);
        productquality.setImportproduct(importproduct);
        productquality.setQuality(quality);
        productquality.setUnit1(unitM);
        productquality.setQuantity1(quantity);
        this.productqualityDAO.saveOrUpdate(productquality);
    }



    @Override
    public void addNewRootMaterialBill(ImportproductbillBean bean) throws DuplicateException {
        Importproductbill pojo = bean.getPojo();
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        pojo.setCreatedBy(loginUser);
        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        if(pojo.getImportDate() == null){
            pojo.setImportDate(new Timestamp(System.currentTimeMillis()));
        }
        pojo.setCode(pojo.getCode().toUpperCase());
        pojo.setProduceGroup(Constants.PRODUCT_GROUP_BUY);
        pojo.setStatus(Constants.WAIT_CONFIRM);
        if(pojo.getTempBill() != null && pojo.getTempBill()){
            pojo.setStatus(Constants.CONFIRMED);
        }
        if(pojo.getMarket() != null && pojo.getMarket().getMarketID() == null){
            pojo.setMarket(null);
        }
        if(pojo.getWarehouseMap() != null && pojo.getWarehouseMap().getWarehouseMapID() == null){
            pojo.setWarehouseMap(null);
        }
        pojo = this.ImportproductbillDAO.save(pojo);
        saveLog(loginUser,pojo,pojo.getNote(),1);
        saveOrUpdateImportProduct(null, bean.getItemInfos(), pojo);
    }

    private void saveLog(User loginUser,Importproductbill bill,String note, Integer status){
        ImportProductBillLog log = new ImportProductBillLog();
        log.setImportproductbill(bill);
        log.setNote(note);
        log.setStatus(status);
        log.setCreatedBy(loginUser);
        log.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        importProductBillLogDAO.save(log);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                Long ID = Long.parseLong(id);
                Importproductbill bill = this.ImportproductbillDAO.findByIdNoAutoCommit(ID);
                pushTheirUsedProductBack(bill.getImportproducts(), Constants.ROOT_MATERIAL_STATUS_WAIT_TO_USE);
                ImportproductbillDAO.delete(ID);
            }
        }
        return res;
    }
    private void pushTheirUsedProductBack(List<Importproduct> importproducts, Integer status){
        List<Long> importproductList = new ArrayList<Long>();
        for(Importproduct importproduct : importproducts){
            Importproduct usedProduct = importproduct.getMainUsedMaterial();
            if(usedProduct != null && !importproductList.contains(usedProduct.getImportProductID())){
                usedProduct.setStatus(status);
                usedProduct.setCutOff(null);
                usedProduct.setImportBack(null);
                usedProduct.setUsedMet(null);
                this.importproductDAO.update(usedProduct);
                importproductList.add(usedProduct.getImportProductID());
            }
        }
    }

    private void pushProductBack(List<Importproduct> importproducts, Integer status){
        for(Importproduct importproduct : importproducts){
            importproduct.setStatus(status);
            importproduct.setCutOff(null);
            importproduct.setImportBack(null);
            importproduct.setUsedMet(null);
            this.importproductDAO.update(importproduct);
        }
    }

    @Override
    public Object[] search(ImportproductbillBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            properties.put("warehouse.warehouseID",SecurityUtils.getPrincipal().getWarehouseID());
        }
        if(bean.getCode() != null && StringUtils.isNotBlank(bean.getCode())){
            properties.put("code",bean.getCode());
        }
        if(bean.getTempBill() != null && bean.getTempBill()){
            properties.put("tempBill",bean.getTempBill());
        }
        if(StringUtils.isNotBlank(bean.getProductCode())){
            whereClause.append(" AND EXISTS(SELECT 1 FROM Importproduct ip WHERE ip.importproductbill.importProductBillID = A.importProductBillID")
                    .append(" AND ip.productCode = '").append(bean.getProductCode()).append("')");
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
        if(bean.getWarehouseID() != null &&  bean.getWarehouseID() > 0){
            properties.put("warehouse.warehouseID",bean.getWarehouseID());
        }
        if(bean.getReImport()){
            properties.put("produceGroup",Constants.PRODUCT_GROUP_RE_IMPORT);
        }else if(bean.getIsBlackProduct()){
            properties.put("produceGroup",Constants.PRODUCT_GROUP_BUY);
        }else {
            properties.put("produceGroup",Constants.PRODUCT_GROUP_PRODUCED);
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
        return this.ImportproductbillDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public void updateReject(String note, Long billID, Long userID) {
        Importproductbill bill = this.ImportproductbillDAO.findByIdNoAutoCommit(billID);
        bill.setNote(note);
        bill.setStatus(Constants.REJECTED);
        User loginUser = new User();
        loginUser.setUserID(userID);
        bill.setConfirmedBy(loginUser);
        bill.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        bill = this.ImportproductbillDAO.update(bill);
        saveLog(loginUser,bill,note,0);
        updateChildBill(note,billID,userID,Constants.REJECTED);

    }

    private void updateChildBill(String note, Long billID, Long userID,Integer status) {
        Importproductbill childBill = this.ImportproductbillDAO.findByParentBill(billID);
        if(childBill != null){
            childBill.setNote(note);
            childBill.setStatus(status);
            User loginUser = new User();
            loginUser.setUserID(userID);
            childBill.setConfirmedBy(loginUser);
            childBill.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
            childBill = this.ImportproductbillDAO.update(childBill);
            saveLog(loginUser,childBill,note,0);
            if(status.equals(Constants.CONFIRMED)){
                if(childBill.getImportproducts() != null && childBill.getImportproducts().size() > 0){
                    List<Long> productIDs = new ArrayList<Long>();
                    for(Importproduct item : childBill.getImportproducts()){
                        productIDs.add(item.getImportProductID());
                    }
                    importproductDAO.updateStatus(productIDs,Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                }
            }
        }
    }

    @Override
    public void updateConfirm(ImportproductbillBean bean) throws ObjectNotFoundException {
        Importproductbill dbItem = this.ImportproductbillDAO.findByIdNoAutoCommit(bean.getPojo().getImportProductBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importproductbill " + bean.getPojo().getImportProductBillID());
        dbItem.setConfirmedDate(new Timestamp(System.currentTimeMillis()));
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setConfirmedBy(loginUser);
        dbItem.setStatus(Constants.CONFIRMED);
        dbItem.setNote(bean.getPojo().getNote());
        dbItem = this.ImportproductbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,bean.getPojo().getNote(),1);
        List<Long> productIDs = new ArrayList<Long>();
        for(Importproduct item : dbItem.getImportproducts()){
            productIDs.add(item.getImportProductID());
        }
        importproductDAO.updateStatus(productIDs,Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
        updateChildBill(bean.getPojo().getNote(),bean.getPojo().getImportProductBillID(),bean.getLoginID(),Constants.CONFIRMED);
    }



    @Override
    public void updateConfirmMoney(ImportproductbillBean bean) throws ObjectNotFoundException {
        Importproductbill dbItem = this.ImportproductbillDAO.findByIdNoAutoCommit(bean.getPojo().getImportProductBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importproductbill " + bean.getPojo().getImportProductBillID());
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setTotalMoney(bean.getPojo().getTotalMoney());
        dbItem.setNote(bean.getPojo().getNote());
        if(bean.getPojo().getBuyContract() != null && bean.getPojo().getBuyContract().getBuyContractID() != null && bean.getPojo().getBuyContract().getBuyContractID() > 0){
            dbItem.setBuyContract(bean.getPojo().getBuyContract());
        }
        dbItem = this.ImportproductbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,bean.getPojo().getNote(),1);
        for(Importproduct item : dbItem.getImportproducts()){
            item.setMoney(bean.getRootMaterialMoneyMap().get(item.getImportProductID()));
            importproductDAO.update(item);
        }
    }

    @Override
    public Importproductbill findByParentBill(Long importProductBillID) {
        return this.ImportproductbillDAO.findByParentBill(importProductBillID);
    }

    @Override
    public void addProductBill(ImportproductbillBean bean) throws DuplicateException {
        Importproductbill pojo = bean.getPojo();
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        pojo.setCreatedBy(loginUser);
        pojo.setImportDate(new Timestamp(System.currentTimeMillis()));
        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        pojo.setProduceDate(new Timestamp(System.currentTimeMillis()));
        ProductionPlan plan = null;
        if(pojo.getProductionPlan() != null && pojo.getProductionPlan().getProductionPlanID() != null && pojo.getProductionPlan().getProductionPlanID() > 0){
            plan = this.productionPlanDAO.findByIdNoAutoCommit(pojo.getProductionPlan().getProductionPlanID());
        }
        if(plan != null){
            pojo.setProduceDate(plan.getDate());
            pojo.setImportDate(plan.getDate());
        }
        pojo.setCode(pojo.getCode().toUpperCase());
        pojo.setProduceGroup(Constants.PRODUCT_GROUP_PRODUCED);
        pojo.setStatus(Constants.WAIT_CONFIRM);
        if(pojo.getWarehouseMap() != null && pojo.getWarehouseMap().getWarehouseMapID() == null){
            pojo.setWarehouseMap(null);
        }
        pojo = this.ImportproductbillDAO.save(pojo);
        saveLog(loginUser,pojo,bean.getPojo().getNote(),1);
        saveOrUpdateProducedProduct(null, bean.getMainMaterials(), pojo);
    }



    private void saveOrUpdateProducedProduct(List<Importproduct> dbImportProducts, List<MainMaterialInfoDTO> mainMaterialInfoDTOs, Importproductbill bill) throws DuplicateException {
        List<Importproduct> dbMainMaterialUseds = new ArrayList<Importproduct>();
        List<Long> dbMainUsedMaterialIDs = new ArrayList<Long>();
        if(dbImportProducts !=null && dbImportProducts.size() > 0){ //case update
            for(Importproduct dbImportProduct : dbImportProducts){
                if(dbImportProduct.getMainUsedMaterial()!= null && !dbMainMaterialUseds.contains(dbImportProduct.getMainUsedMaterial())){
                    dbMainMaterialUseds.add(dbImportProduct.getMainUsedMaterial());
                    dbMainUsedMaterialIDs.add(dbImportProduct.getMainUsedMaterial().getImportProductID());
                }
            }
        }
        Unit unitM = this.unitDAO.findByName(Constants.UNIT_MET).get(0);
        Unit unitKg = this.unitDAO.findByName(Constants.UNIT_KG).get(0);
        List<ImportBackDTO> importBackDTOs = new ArrayList<ImportBackDTO>();
        for(MainMaterialInfoDTO item : mainMaterialInfoDTOs){
            boolean hasProduct = false;
            if(item.getItemID() != null && item.getItemID() > 0){
                Importproduct mainMaterial = this.importproductDAO.findByIdNoAutoCommit(item.getItemID());
                if(mainMaterial != null){
                    for(ItemInfoDTO itemInfoDTO : item.getItemInfos()){
                        if(itemInfoDTO.getCode() != null && StringUtils.isNotBlank(itemInfoDTO.getCode()) && (itemInfoDTO.getQuantityM() != null || itemInfoDTO.getQuantityPure() != null)
                                && itemInfoDTO.getProductName() != null && itemInfoDTO.getProductName().getProductNameID() != null && itemInfoDTO.getProductName().getProductNameID() > 0){
                            Productname productname = this.productnameDAO.findByIdNoAutoCommit(itemInfoDTO.getProductName().getProductNameID());
                            Importproduct importproduct = null;
                            if(dbImportProducts !=null && dbImportProducts.size() > 0){ //case update
                                for(int i =  dbImportProducts.size() - 1; i >= 0; i--){
                                    Importproduct dbImportProduct = dbImportProducts.get(i);
                                    if(dbImportProduct.getProductCode().equalsIgnoreCase(itemInfoDTO.getCode())){
                                        importproduct = dbImportProduct;
                                        dbImportProducts.remove(i);
                                        break;
                                    }
                                }
                                if(importproduct == null){
                                    importproduct = new Importproduct();
                                    saveOrUpdateImportProductInDetail(itemInfoDTO,importproduct,bill,productname,unitM,unitKg,false,mainMaterial);
                                }else{
                                    saveOrUpdateImportProductInDetail(itemInfoDTO,importproduct,bill,productname,unitM,unitKg,false,mainMaterial);
                                }
                                dbMainMaterialUseds.remove(mainMaterial);
                            }else{ //case add new
                                importproduct = new Importproduct();
                                saveOrUpdateImportProductInDetail(itemInfoDTO,importproduct,bill,productname,unitM,unitKg,false,mainMaterial);
                            }
                            hasProduct = true;
                        }
                    }
                    if(hasProduct){
                        Double importBack =  item.getImportBack() != null && item.getImportBack() > 0 ? item.getImportBack() : null;
                        mainMaterial.setCutOff(item.getCutOff());
                        mainMaterial.setImportBack(importBack);
                        if(importBack != null){
                            mainMaterial.setUsedMet(item.getUsedMet());
                        }else {
                            if(mainMaterial.getProductname().getCode().equals(Constants.PRODUCT_BLACK)){
                                mainMaterial.setUnit1(unitM);
                                mainMaterial.setQuantity1(item.getTotalM());
                                mainMaterial.setUsedMet(null);
                            }
                        }
                        mainMaterial.setStatus(Constants.ROOT_MATERIAL_STATUS_USED);
                        importproductDAO.update(mainMaterial);
                        if(importBack != null){
                            ImportBackDTO backDTO = new ImportBackDTO();
                            backDTO.setOriginalProduct(mainMaterial);
                            backDTO.setImportBackValue(importBack);
                            importBackDTOs.add(backDTO);
                        }
                    }
                }
            }
        }
        List<Importproduct> dbImportBackProducts = null;
        if(dbMainUsedMaterialIDs.size() > 0){
            dbImportBackProducts = this.importproductDAO.findImportBackByOriginalProducts(dbMainUsedMaterialIDs);
        }
        User user = bill.getUpdatedBy() != null ? bill.getUpdatedBy() : bill.getCreatedBy();
        saveOrUpdateImportBackProduct(dbImportBackProducts,importBackDTOs,bill.getWarehouse(),user,bill.getProduceDate(),bill);
        if(dbImportProducts!= null && !dbImportProducts.isEmpty()){
            this.importproductDAO.deleteAll(dbImportProducts);
        }
        if(dbMainMaterialUseds != null && !dbMainMaterialUseds.isEmpty()){
            pushProductBack(dbMainMaterialUseds, Constants.ROOT_MATERIAL_STATUS_WAIT_TO_USE);
        }
    }

    private void saveOrUpdateImportBackProduct(List<Importproduct> dbImportBackProducts, List<ImportBackDTO> importBackDTOs, Warehouse warehouse, User loginUser,Timestamp date, Importproductbill parentBill) {
        if(importBackDTOs != null && importBackDTOs.size() > 0){
            Importproductbill bill = this.ImportproductbillDAO.findByParentBill(parentBill.getImportProductBillID());
            if(bill == null){
                if(dbImportBackProducts == null || dbImportBackProducts.size() == 0){
                    bill = new Importproductbill();
                    bill.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                    bill.setWarehouse(warehouse);
                    bill.setStatus(Constants.WAIT_CONFIRM);
                    bill.setDescription(Constants.IMPORT_BACK_DATA);
                    bill.setCode(Constants.IMPORT_BACK_CODE);
                    bill.setCode(GeneratorUtils.generatePTNTCode());
                    bill.setProduceGroup(Constants.PRODUCT_GROUP_IMPORT_BACK);
                    bill.setCreatedBy(loginUser);
                    bill.setParentBill(parentBill);
                    bill.setProductionPlan(parentBill.getProductionPlan());
                }else{
                    bill = dbImportBackProducts.get(0).getImportproductbill();
                }
            }
            bill.setUpdatedBy(loginUser);
            bill.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
            bill.setStatus(Constants.WAIT_CONFIRM);
            bill = this.ImportproductbillDAO.saveOrUpdate(bill);

            for(ImportBackDTO importBackDTO : importBackDTOs){
                Importproduct importBackProduct = null;
                if(dbImportBackProducts != null && dbImportBackProducts.size() > 0){
                    for(int i =  dbImportBackProducts.size() - 1; i >= 0; i--){
                        Importproduct dbImportBackProduct = dbImportBackProducts.get(i);
                        if(dbImportBackProduct.getOriginalProduct().getImportProductID().equals(importBackDTO.getOriginalProduct().getImportProductID())){
                            importBackProduct = dbImportBackProduct;
                            dbImportBackProducts.remove(i);
                            break;
                        }
                    }
                    saveOrUpdateImportBackProductInDetail(importBackDTO,importBackProduct,bill,date);
                }else{
                    saveOrUpdateImportBackProductInDetail(importBackDTO,importBackProduct,bill,date);
                }
            }
        }
        if(dbImportBackProducts != null && !dbImportBackProducts.isEmpty()){
            this.importproductDAO.deleteAll(dbImportBackProducts);
        }
        if(importBackDTOs == null || importBackDTOs.size() == 0){
//            this.ImportproductbillDAO.deleteBlankBill();
        }
    }

    private void saveOrUpdateImportBackProductInDetail(ImportBackDTO importBackDTO, Importproduct importBackProduct, Importproductbill bill,Timestamp date) {
        Importproduct originalProduct = importBackDTO.getOriginalProduct();
        if(importBackProduct == null){
            importBackProduct = new Importproduct();
            importBackProduct.setProductname(originalProduct.getProductname());
            importBackProduct.setOrigin(originalProduct.getOrigin());
            importBackProduct.setMainUsedMaterial(originalProduct.getMainUsedMaterial());
            importBackProduct.setMainUsedMaterialCode(originalProduct.getMainUsedMaterialCode());
            importBackProduct.setNote(originalProduct.getNote());
            importBackProduct.setUnit1(originalProduct.getUnit1());
            importBackProduct.setUnit2(originalProduct.getUnit2());
            importBackProduct.setMarket(originalProduct.getMarket());
            importBackProduct.setSize(originalProduct.getSize());
            importBackProduct.setThickness(originalProduct.getThickness());
            importBackProduct.setStiffness(originalProduct.getStiffness());
            importBackProduct.setCore(originalProduct.getCore());
            importBackProduct.setColour(originalProduct.getColour());
            importBackProduct.setOverlaytype(originalProduct.getOverlaytype());
            importBackProduct.setImportDate(originalProduct.getImportDate());
            importBackProduct.setWarehouse(originalProduct.getWarehouse());
            importBackProduct.setWarehouseMap(originalProduct.getWarehouseMap());
            importBackProduct.setSuggestedDate(originalProduct.getSuggestedDate());
            importBackProduct.setSuggestedBy(originalProduct.getSuggestedBy());
            importBackProduct.setProductCode(originalProduct.getProductCode() + Constants.IMPORT_BACK_SUB_CODE);
            importBackProduct.setOriginalProduct(originalProduct);
        }
        importBackProduct.setStatus(Constants.ROOT_MATERIAL_STATUS_WAIT_CONFIRM);
        importBackProduct.setImportproductbill(bill);
        importBackProduct.setQuantity2Pure(importBackDTO.getImportBackValue());
        if(originalProduct.getQuantity2() != null){
            importBackProduct.setQuantity2(Math.ceil(originalProduct.getQuantity2() * importBackDTO.getImportBackValue() / originalProduct.getQuantity2Pure()));
        }
        if(originalProduct.getQuantity2Actual() != null){
            importBackProduct.setQuantity2Actual(Math.ceil(originalProduct.getQuantity2Actual() *  importBackDTO.getImportBackValue() /originalProduct.getQuantity2Pure()));
        }
        if(originalProduct.getQuantity1() != null){
            importBackProduct.setQuantity1(Math.ceil(originalProduct.getQuantity1() * importBackDTO.getImportBackValue() /  originalProduct.getQuantity2Pure()));
        }
        if(originalProduct.getMoney() != null){
            importBackProduct.setMoney(Math.ceil(originalProduct.getMoney() * importBackDTO.getImportBackValue() / originalProduct.getQuantity2Pure()));
        }
        if(originalProduct.getSuggestedPrice() != null){
            importBackProduct.setSuggestedPrice(Math.ceil(originalProduct.getSuggestedPrice() * importBackDTO.getImportBackValue() / originalProduct.getQuantity2Pure()));
        }
        this.importproductDAO.saveOrUpdate(importBackProduct);
    }

    @Override
    public void updateProductBill(ImportproductbillBean bean) throws ObjectNotFoundException, DuplicateException {
        Importproductbill dbItem = this.ImportproductbillDAO.findByIdNoAutoCommit(bean.getPojo().getImportProductBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importproductbill " + bean.getPojo().getImportProductBillID());
        Importproductbill pojo = bean.getPojo();
        dbItem.setCode(pojo.getCode().toUpperCase());
        if(pojo.getCustomer()!= null && pojo.getCustomer().getCustomerID() != null && pojo.getCustomer().getCustomerID() > 0){
            dbItem.setCustomer(pojo.getCustomer());
        }
        if(pojo.getWarehouseMap() != null && pojo.getWarehouseMap().getWarehouseMapID() == null){
            dbItem.setWarehouseMap(null);
        }else{
            dbItem.setWarehouseMap(pojo.getWarehouseMap());
        }
        dbItem.setDescription(pojo.getDescription());
        dbItem.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setUpdatedBy(loginUser);
        dbItem.setStatus(Constants.WAIT_CONFIRM);
        ProductionPlan plan = null;
        if(pojo.getProductionPlan() != null && pojo.getProductionPlan().getProductionPlanID() != null && pojo.getProductionPlan().getProductionPlanID() > 0){
            plan = this.productionPlanDAO.findByIdNoAutoCommit(pojo.getProductionPlan().getProductionPlanID());
        }
        if(plan != null){
            dbItem.setProduceDate(plan.getDate());
            dbItem.setImportDate(plan.getDate());
        }
        pojo = this.ImportproductbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,bean.getPojo().getNote(),1);
        saveOrUpdateProducedProduct(dbItem.getImportproducts(), bean.getMainMaterials(), pojo);
    }

    @Override
    public String getLatestPNKTON() {
        return this.ImportproductbillDAO.getLatestPNKTON();  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public String getLatestPTNTON() {
        return this.ImportproductbillDAO.getLatestPTNTON();
    }

    @Override
    public void saveReImportProduct(ImportproductbillBean bean) {
        Importproductbill pojo = bean.getPojo();
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        pojo.setCreatedBy(loginUser);
        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        if(pojo.getImportDate() == null){
            pojo.setImportDate(new Timestamp(System.currentTimeMillis()));
        }
        pojo.setCode(pojo.getCode().toUpperCase());
        pojo.setProduceGroup(Constants.PRODUCT_GROUP_RE_IMPORT);
        pojo.setStatus(Constants.WAIT_CONFIRM);
        if(pojo.getCustomer() != null && pojo.getCustomer().getCustomerID() == null){
            pojo.setCustomer(null);
        }
        if(pojo.getMarket() != null && pojo.getMarket().getMarketID() == null){
            pojo.setMarket(null);
        }
        if(pojo.getWarehouseMap() != null && pojo.getWarehouseMap().getWarehouseMapID() == null){
            pojo.setWarehouseMap(null);
        }
        pojo = this.ImportproductbillDAO.save(pojo);
        saveLog(loginUser, pojo, pojo.getNote(), 1);
        saveOrUpdateReImportProduct(null, bean.getReImportProducts(), pojo);
    }

    @Override
    public void updateReImportProuduct(ImportproductbillBean bean) throws ObjectNotFoundException {
        Importproductbill dbItem = this.ImportproductbillDAO.findByIdNoAutoCommit(bean.getPojo().getImportProductBillID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importproductbill " + bean.getPojo().getImportProductBillID());
        Importproductbill pojo = bean.getPojo();
        dbItem.setCode(pojo.getCode().toUpperCase());
        if(pojo.getCustomer() != null && pojo.getCustomer().getCustomerID() == null){
            dbItem.setCustomer(null);
        }else{
            dbItem.setCustomer(pojo.getCustomer());
        }
        dbItem.setDescription(pojo.getDescription());
        if(pojo.getWarehouseMap() != null && pojo.getWarehouseMap().getWarehouseMapID() == null){
            dbItem.setWarehouseMap(null);
        }else{
            dbItem.setWarehouseMap(pojo.getWarehouseMap());
        }
        if(pojo.getMarket() != null && pojo.getMarket().getMarketID() == null){
            dbItem.setMarket(null);
        }else{
            dbItem.setMarket(pojo.getMarket());
        }
        if(pojo.getImportDate() == null){
            dbItem.setImportDate(new Timestamp(System.currentTimeMillis()));
        }
        dbItem.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        User loginUser = new User();
        loginUser.setUserID(bean.getLoginID());
        dbItem.setUpdatedBy(loginUser);
        dbItem.setStatus(Constants.WAIT_CONFIRM);
        dbItem = this.ImportproductbillDAO.update(dbItem);
        saveLog(loginUser,dbItem,pojo.getNote(),1);
        saveOrUpdateReImportProduct(dbItem.getImportproducts(), bean.getReImportProducts(), dbItem);
    }

    private void saveOrUpdateReImportProduct(List<Importproduct> dbImportProducts, List<Importproduct> reImportProducts, Importproductbill bill) {
        if(reImportProducts != null && reImportProducts.size() > 0){
            Unit unitM = this.unitDAO.findByName(Constants.UNIT_MET).get(0);
            Unit unitKg = this.unitDAO.findByName(Constants.UNIT_KG).get(0);
            for(Importproduct reImportProductDTO : reImportProducts){
                if(reImportProductDTO.getProductname() != null && reImportProductDTO.getProductname().getProductNameID() != null && reImportProductDTO.getProductCode() != null && reImportProductDTO.getQuantity2Pure() != null){
                    Importproduct reImportProduct = null;
                    if(dbImportProducts != null && dbImportProducts.size() > 0){
                        String code = reImportProductDTO.getProductCode();
                        for(int i = dbImportProducts.size() - 1; i >= 0; i--){
                            Importproduct dbImportProduct = dbImportProducts.get(i);
                            if(dbImportProduct.getProductCode().equals(code)){
                                reImportProduct = dbImportProduct;
                                dbImportProducts.remove(i);
                                break;
                            }
                        }
                    }
                    saveOrUpdateReImportProductInDetail(reImportProductDTO, reImportProduct, bill, unitKg,unitM);
                }
            }

            if(dbImportProducts != null && !dbImportProducts.isEmpty()){
                this.importproductDAO.deleteAll(dbImportProducts);
            }
        }
    }

    private void saveOrUpdateReImportProductInDetail(Importproduct reImportProductDTO, Importproduct reImportProduct, Importproductbill bill, Unit unitKg, Unit unitM) {
        if(reImportProduct == null){
            reImportProduct = new Importproduct();
        }
        Importproduct originalProduct = null;
        try {
            originalProduct = this.importproductDAO.findEqualUnique("productCode",reImportProductDTO.getOriginalCode());
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }
        reImportProduct.setOriginalProduct(originalProduct);
        reImportProduct.setImportproductbill(bill);
        reImportProduct.setProductname(reImportProductDTO.getProductname());
        reImportProduct.setProductCode(reImportProductDTO.getProductCode().toUpperCase());
        reImportProduct.setWarehouse(bill.getWarehouse());
        reImportProduct.setStatus(Constants.ROOT_MATERIAL_STATUS_WAIT_CONFIRM);
        reImportProduct.setProduceDate(originalProduct != null ? originalProduct.getProduceDate() : bill.getImportDate());
        reImportProduct.setImportDate(bill.getImportDate());
        if(bill.getWarehouseMap() != null && bill.getWarehouseMap().getWarehouseMapID() != null && bill.getWarehouseMap().getWarehouseMapID() > 0){
            reImportProduct.setWarehouseMap(bill.getWarehouseMap());
        }else{
            reImportProduct.setWarehouseMap(null);
        }
        if(reImportProductDTO.getSize() != null && reImportProductDTO.getSize().getSizeID() != null && reImportProductDTO.getSize().getSizeID() > 0){
            reImportProduct.setSize(reImportProductDTO.getSize());
        }
        else{
            reImportProduct.setSize(null);
        }
        if(reImportProductDTO.getThickness() != null && reImportProductDTO.getThickness().getThicknessID() != null && reImportProductDTO.getThickness().getThicknessID() > 0){
            reImportProduct.setThickness(reImportProductDTO.getThickness());
        }
        else{
            reImportProduct.setThickness(null);
        }
        if(reImportProductDTO.getStiffness() != null && reImportProductDTO.getStiffness().getStiffnessID() != null && reImportProductDTO.getStiffness().getStiffnessID() > 0){
            reImportProduct.setStiffness(reImportProductDTO.getStiffness());
        }
        else{
            reImportProduct.setStiffness(null);
        }
        if(reImportProductDTO.getColour() != null && reImportProductDTO.getColour().getColourID() != null && reImportProductDTO.getColour().getColourID() > 0){
            reImportProduct.setColour(reImportProductDTO.getColour());
        }
        else{
            reImportProduct.setColour(null);
        }
        if(reImportProductDTO.getOrigin() != null && reImportProductDTO.getOrigin().getOriginID() != null && reImportProductDTO.getOrigin().getOriginID() > 0){
            reImportProduct.setOrigin(reImportProductDTO.getOrigin());
        }
        else{
            reImportProduct.setOrigin(null);
        }
        if(reImportProductDTO.getMarket() != null && reImportProductDTO.getMarket().getMarketID() != null && reImportProductDTO.getMarket().getMarketID() > 0){
            reImportProduct.setMarket(reImportProductDTO.getMarket());
        }
        else{
            reImportProduct.setMarket(null);
        }
        if(reImportProductDTO.getOverlaytype() != null && reImportProductDTO.getOverlaytype().getOverlayTypeID() != null && reImportProductDTO.getOverlaytype().getOverlayTypeID() > 0){
            reImportProduct.setOverlaytype(reImportProductDTO.getOverlaytype());
        }
        else{
            reImportProduct.setOverlaytype(null);
        }
        reImportProduct.setMainUsedMaterial(null);
        reImportProduct.setMainUsedMaterialCode(null);

        reImportProduct.setUnit1(unitM);
        reImportProduct.setUnit2(unitKg);

        reImportProduct.setQuantity1(reImportProductDTO.getQuantity1());
        reImportProduct.setQuantity2Pure(reImportProductDTO.getQuantity2Pure());

        reImportProduct.setCore(reImportProductDTO.getCore());
        reImportProduct.setNote(reImportProductDTO.getNote());
        reImportProduct.setProducedTeam(reImportProductDTO.getProducedTeam());
        this.importproductDAO.saveOrUpdate(reImportProduct);
    }

    @Override
    public Importproduct updateProductInfo(ItemInfoDTO productInfo, Long loginUserId) {
        Importproduct importproduct = this.importproductDAO.findByIdNoAutoCommit(productInfo.getItemID());
        Double oldMet = importproduct.getQuantity1();
        importproduct.setProductCode(productInfo.getCode().toUpperCase());
        if(productInfo.getProductName() != null && productInfo.getProductName().getProductNameID() != null && productInfo.getProductName().getProductNameID() > 0){
            importproduct.setProductname(productInfo.getProductName());
        }
        if(productInfo.getSize() != null && productInfo.getSize().getSizeID() != null && productInfo.getSize().getSizeID() > 0){
            importproduct.setSize(productInfo.getSize());
        }else {
            importproduct.setSize(null);
        }
        if(productInfo.getThickness() != null && productInfo.getThickness().getThicknessID() != null && productInfo.getThickness().getThicknessID() > 0){
            importproduct.setThickness(productInfo.getThickness());
        }else {
            importproduct.setThickness(null);
        }
        if(productInfo.getStiffness() != null && productInfo.getStiffness().getStiffnessID() != null && productInfo.getStiffness().getStiffnessID() > 0){
            importproduct.setStiffness(productInfo.getStiffness());
        }else {
            importproduct.setStiffness(null);
        }
        if(productInfo.getColour() != null && productInfo.getColour().getColourID() != null && productInfo.getColour().getColourID() > 0){
            importproduct.setColour(productInfo.getColour());
        }else {
            importproduct.setColour(null);
        }
        if(productInfo.getOrigin() != null && productInfo.getOrigin().getOriginID() != null && productInfo.getOrigin().getOriginID() > 0){
            importproduct.setOrigin(productInfo.getOrigin());
        }else {
            importproduct.setOrigin(null);
        }
        if(productInfo.getMarket() != null && productInfo.getMarket().getMarketID() != null && productInfo.getMarket().getMarketID() > 0){
            importproduct.setMarket(productInfo.getMarket());
        }else{
            importproduct.setMarket(null);
        }
        if(productInfo.getOverlayType() != null && productInfo.getOverlayType().getOverlayTypeID() != null && productInfo.getOverlayType().getOverlayTypeID() > 0){
            importproduct.setOverlaytype(productInfo.getOverlayType());
        }else {
            importproduct.setOverlaytype(null);
        }
        importproduct.setQuantity1(productInfo.getQuantity());
        importproduct.setQuantity2(productInfo.getQuantityOverall());
        importproduct.setQuantity2Pure(productInfo.getQuantityPure());
        importproduct.setQuantity2Actual(productInfo.getQuantityActual());
        importproduct.setCore(productInfo.getCore());
        importproduct.setNote(productInfo.getNote());
        importproduct = this.importproductDAO.saveOrUpdate(importproduct);

        saveOrUpDateProductQuality(importproduct, productInfo.getQualityQuantityMap(), importproduct.getUnit1(), oldMet);
        return importproduct;
    }

    @Override
    public List<Importproductbill> findAllByOrderAndDateLimit(String importDate, Boolean black, Long date) {
        return this.ImportproductbillDAO.findAllByOrderAndDateLimit(importDate, black, date);
    }

    @Override
    public List<Importproductbill> findByIds(List<Long> billIDs) {
        return this.ImportproductbillDAO.findByIds(billIDs);
    }

    @Override
    public void updateMergeBills(ImportproductbillBean bean) {
        List<Importproductbill> importproductbills = this.ImportproductbillDAO.findByIds(bean.getBillIDs());
        Importproductbill finalBill = importproductbills.get(0);
        if(bean.getMarketID() != null && bean.getMarketID() > 0){
            Market market = new Market();
            market.setMarketID(bean.getMarketID());
            finalBill.setMarket(market);
        }else{
            finalBill.setMarket(null);
        }
        finalBill.setDescription(bean.getDescription());
        finalBill.setImportDate(new Timestamp(bean.getImportDate().getTime()));
        finalBill.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        finalBill.setTempBill(false);
        this.ImportproductbillDAO.update(finalBill);
        List<Long> productIDs = new ArrayList<Long>();
        importproductbills.remove(0);
        for(int i = importproductbills.size(); i > 0; i--){
            for(Importproduct importproduct : importproductbills.get(i - 1).getImportproducts()){
                productIDs.add(importproduct.getImportProductID());
            }
        }
        this.importproductDAO.changeBillofProducts(productIDs, finalBill);
        this.ImportproductbillDAO.deleteAll(importproductbills);
    }
}