package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.*;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.dto.ImportMaterialDataDTO;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.util.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ImportmaterialServiceImpl extends GenericServiceImpl<Importmaterial,Long>
        implements ImportmaterialService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ImportmaterialDAO importmaterialDAO;
    private UserDAO userDAO;
    private MaterialDAO materialDAO;
    private OriginDAO originDAO;
    private MarketDAO marketDAO;
    private UnitDAO unitDAO;
    private ImportmaterialbillDAO importmaterialbillDAO;
    private LocationHistoryDAO locationHistoryDAO;

    public void setLocationHistoryDAO(LocationHistoryDAO locationHistoryDAO) {
        this.locationHistoryDAO = locationHistoryDAO;
    }

    public void setMaterialDAO(MaterialDAO materialDAO) {
        this.materialDAO = materialDAO;
    }

    public void setOriginDAO(OriginDAO originDAO) {
        this.originDAO = originDAO;
    }

    public void setMarketDAO(MarketDAO marketDAO) {
        this.marketDAO = marketDAO;
    }

    public void setUnitDAO(UnitDAO unitDAO) {
        this.unitDAO = unitDAO;
    }

    public void setImportmaterialbillDAO(ImportmaterialbillDAO importmaterialbillDAO) {
        this.importmaterialbillDAO = importmaterialbillDAO;
    }

    public UserDAO getUserDAO() {
        return userDAO;
    }

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public void setImportmaterialDAO(ImportmaterialDAO importmaterialDAO) {
        this.importmaterialDAO = importmaterialDAO;
    }

    @Override
    protected GenericDAO<Importmaterial, Long> getGenericDAO() {
        return importmaterialDAO;
    }

    @Override
    public void updateItem(ImportmaterialBean ImportmaterialBean) throws ObjectNotFoundException, DuplicateException {
        Importmaterial dbItem = this.importmaterialDAO.findByIdNoAutoCommit(ImportmaterialBean.getPojo().getImportMaterialID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importmaterial " + ImportmaterialBean.getPojo().getImportMaterialID());

        Importmaterial pojo = ImportmaterialBean.getPojo();

        this.importmaterialDAO.detach(dbItem);
        this.importmaterialDAO.update(pojo);
    }

    @Override
    public void addNew(ImportmaterialBean ImportmaterialBean) throws DuplicateException {
        Importmaterial pojo = ImportmaterialBean.getPojo();
        pojo = this.importmaterialDAO.save(pojo);
        ImportmaterialBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                importmaterialDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ImportmaterialBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        return this.importmaterialDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Importmaterial> findAvailableMaterialByWarehouse(Long warehouseID) {
        return this.importmaterialDAO.findAvailableMaterialByWarehouse(warehouseID);
    }

    @Override
    public Object[] searchMaterialsInStock(SearchMaterialBean bean) {
        return this.importmaterialDAO.searchMaterialsInStock(bean);
    }

    @Override
    public Object[] importMaterialData2DB(List<ImportMaterialDataDTO> importedDatas, Long userID) {
        Warehouse warehouse = importedDatas.get(0).getWarehouse();
        User loginUser = new User();
        loginUser.setUserID(userID);
        Map<String,Material> mapMaterial = new HashMap<String, Material>();
        List<Material> materials = this.materialDAO.findAll();
        Timestamp now = new Timestamp(System.currentTimeMillis());
        for(Material material : materials){
            mapMaterial.put(material.getName().toUpperCase(),material);
        }

        Map<String,Origin> mapOrigin = new HashMap<String, Origin>();
        List<Origin> origins = this.originDAO.findAll();
        for(Origin origin : origins){
            mapOrigin.put(origin.getName().toUpperCase(),origin);
        }

        Map<String,Market> mapMarket = new HashMap<String, Market>();
        List<Market> markets = this.marketDAO.findAll();
        for(Market market : markets){
            mapMarket.put(market.getName().toUpperCase(),market);
        }

        Map<String,Unit> mapUnit = new HashMap<String, Unit>();
        List<Unit> units = this.unitDAO.findAll();
        for(Unit unit : units){
            mapUnit.put(unit.getName().toUpperCase(),unit);
        }

        Importmaterialbill bill = new Importmaterialbill();
        bill.setImportDate(new Timestamp(System.currentTimeMillis()));
        bill.setWarehouse(warehouse);
        bill.setStatus(Constants.CONFIRMED);
        bill.setDescription(Constants.INITIAL_IMPORT_DATA);
        bill.setCode(Constants.INITIAL_IMPORT_CODE);
        bill.setBillGroup(Constants.MATERIAL_GROUP_IMPORTED);
        bill.setCreatedBy(loginUser);
        bill = this.importmaterialbillDAO.save(bill);
        Integer totalImported = 0;
        StringBuilder failCode = new StringBuilder();
        for(ImportMaterialDataDTO dataDTO : importedDatas){
            if(dataDTO.isValid()){
                Importmaterial importmaterial = new Importmaterial();
                importmaterial.setImportmaterialbill(bill);

                if(dataDTO.getOrigin() != null && StringUtils.isNotBlank(dataDTO.getOrigin())){
                    Origin origin = mapOrigin.get(dataDTO.getOrigin().toUpperCase());
                    if(origin == null){
                        origin = new Origin();
                        origin.setName(dataDTO.getOrigin());
                        origin = this.originDAO.save(origin);
                        mapOrigin.put(origin.getName().toUpperCase(),origin);
                    }
                    importmaterial.setOrigin(origin);
                }

                if(dataDTO.getMarket() != null && StringUtils.isNotBlank(dataDTO.getMarket())){
                    Market market = mapMarket.get(dataDTO.getMarket().toUpperCase());
                    if(market == null){
                        market = new Market();
                        market.setName(dataDTO.getMarket());
                        market = this.marketDAO.save(market);
                        mapMarket.put(market.getName().toUpperCase(),market);
                    }
                    importmaterial.setMarket(market);
                }

                if(dataDTO.getUnit() != null && StringUtils.isNotBlank(dataDTO.getUnit())){
                    Unit unit = mapUnit.get(dataDTO.getUnit().toUpperCase());
                    if(unit == null){
                        unit = new Unit();
                        unit.setName(dataDTO.getMarket());
                        unit = this.unitDAO.save(unit);
                        mapUnit.put(unit.getName().toUpperCase(),unit);
                    }
                }

                Material material = mapMaterial.get(dataDTO.getName().toUpperCase());
                if(material == null){
                    material = new Material();
                    material.setName(dataDTO.getName());
                    if(dataDTO.getUnit() != null && StringUtils.isNotBlank(dataDTO.getUnit())){
                        material.setUnit(mapUnit.get(dataDTO.getUnit().toUpperCase()));
                    }
                    material = this.materialDAO.save(material);
                    mapMaterial.put(material.getName().toUpperCase(),material);
                }
                importmaterial.setMaterial(material);

                importmaterial.setCode(dataDTO.getCode());
                if(dataDTO.getTotal() != null && StringUtils.isNotBlank(dataDTO.getTotal())){
                    importmaterial.setQuantity(Double.valueOf(dataDTO.getTotal()));
                    importmaterial.setRemainQuantity(Double.valueOf(dataDTO.getTotal()));
                }
                if(dataDTO.getMoney() != null && StringUtils.isNotBlank(dataDTO.getMoney())){
                    importmaterial.setMoney(Double.valueOf(dataDTO.getMoney()));
                }
                importmaterial.setWarehouse(warehouse);
                importmaterial.setStatus(Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
                if(importmaterial.getRemainQuantity() == null || importmaterial.getRemainQuantity() <= 0){
                    importmaterial.setStatus(Constants.ROOT_MATERIAL_STATUS_USED);
                }
                if(dataDTO.getDate() != null && StringUtils.isNotBlank(dataDTO.getDate())){
                    importmaterial.setImportDate(new Timestamp(DateUtils.string2Date(dataDTO.getDate(), "dd/MM/yyyy").getTime()) );
                }else{
                    importmaterial.setImportDate(now);
                }
                if(dataDTO.getExpiredDate() != null && StringUtils.isNotBlank(dataDTO.getExpiredDate())){
                    importmaterial.setExpiredDate(new Timestamp(DateUtils.string2Date(dataDTO.getExpiredDate(), "dd/MM/yyyy").getTime()) );
                }else{
                }
                this.importmaterialDAO.save(importmaterial);
                totalImported++;
            }else{
                if(StringUtils.isNotBlank(failCode.toString())){
                    failCode.append(", ").append(dataDTO.getName()).append("-").append(dataDTO.getCode());
                }else{
                    failCode.append(dataDTO.getName()).append("-").append(dataDTO.getCode());
                }
            }
        }
        return new Object[]{totalImported,failCode.toString()};
    }

    @Override
    public List<Importmaterial> findWarningMaterial(Long warehouseID) {
        return this.importmaterialDAO.findWarningMaterial(warehouseID);
    }

    @Override
    public void updateMaterialLocation(List<SelectedItemDTO> selectedItems,Long userID) {
        User user = new User();
        user.setUserID(userID);
        for(SelectedItemDTO selectedItemDTO : selectedItems){
            if(selectedItemDTO.getItemID() != null){
                Importmaterial importmaterial = this.importmaterialDAO.findByIdNoAutoCommit(selectedItemDTO.getItemID());
                LocationHistory locationHistory = new LocationHistory();
                locationHistory.setImportMaterial(importmaterial);
                locationHistory.setCreatedBy(user);
                locationHistory.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                locationHistory.setOldLocation(importmaterial.getWarehouseMap());
                locationHistory.setWarehouse(importmaterial.getWarehouse());
                if(selectedItemDTO.getWarehouseMap().getWarehouseMapID() > 0){
                    importmaterial.setWarehouseMap(selectedItemDTO.getWarehouseMap());
                    locationHistory.setNewLocation(selectedItemDTO.getWarehouseMap());
                }else{
                    importmaterial.setWarehouseMap(null);
                }
                if((locationHistory.getOldLocation() == null && locationHistory.getNewLocation() != null) ||
                  (locationHistory.getOldLocation() != null && locationHistory.getNewLocation() == null)  ||
                  (locationHistory.getOldLocation() != null && locationHistory.getNewLocation() != null
                       && locationHistory.getOldLocation().getWarehouseMapID() != locationHistory.getNewLocation().getWarehouseMapID())){
                    this.locationHistoryDAO.save(locationHistory);
                    this.importmaterialDAO.update(importmaterial);
                }
            }
        }
    }


    @Override
    public List<Importmaterial> findAllSortAsc() {
        StringBuffer whereClause = new StringBuffer();
        return this.importmaterialDAO.findByProperties(new HashMap<String, Object>(), "id", Constants.SORT_ASC, true, whereClause.toString());
    }
}