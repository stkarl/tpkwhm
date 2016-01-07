package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.*;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.util.DateUtils;
import com.banvien.tpk.core.util.HTMLGeneratorUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.text.Normalizer;
import java.util.*;

public class ImportproductServiceImpl extends GenericServiceImpl<Importproduct,Long>
                                                    implements ImportproductService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ImportproductDAO importproductDAO;
    private InitProductDAO initProductDAO;
    private UserDAO userDAO;
    private ProductnameDAO productnameDAO;
    private SizeDAO sizeDAO;
    private ThicknessDAO thicknessDAO;
    private StiffnessDAO stiffnessDAO;
    private ColourDAO colourDAO;
    private OverlaytypeDAO overlaytypeDAO;
    private OriginDAO originDAO;
    private MarketDAO marketDAO;
    private UnitDAO unitDAO;
    private ImportproductbillDAO importproductbillDAO;
    private ProductqualityDAO productqualityDAO;
    private QualityDAO qualityDAO;
    private LocationHistoryDAO locationHistoryDAO;
    private ExportproductDAO exportproductDAO;
    private CustomerDAO customerDAO;
    private OweLogDAO oweLogDAO;
    private ExportproductbillDAO exportproductbillDAO;

    public void setInitProductDAO(InitProductDAO initProductDAO) {
        this.initProductDAO = initProductDAO;
    }

    public void setExportproductbillDAO(ExportproductbillDAO exportproductbillDAO) {
        this.exportproductbillDAO = exportproductbillDAO;
    }

    public void setOweLogDAO(OweLogDAO oweLogDAO) {
        this.oweLogDAO = oweLogDAO;
    }

    public void setCustomerDAO(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    public void setExportproductDAO(ExportproductDAO exportproductDAO) {
        this.exportproductDAO = exportproductDAO;
    }

    public void setLocationHistoryDAO(LocationHistoryDAO locationHistoryDAO) {
        this.locationHistoryDAO = locationHistoryDAO;
    }

    public void setProductqualityDAO(ProductqualityDAO productqualityDAO) {
        this.productqualityDAO = productqualityDAO;
    }

    public void setQualityDAO(QualityDAO qualityDAO) {
        this.qualityDAO = qualityDAO;
    }

    public void setImportproductbillDAO(ImportproductbillDAO importproductbillDAO) {
        this.importproductbillDAO = importproductbillDAO;
    }

    public void setUnitDAO(UnitDAO unitDAO) {
        this.unitDAO = unitDAO;
    }

    public void setProductnameDAO(ProductnameDAO productnameDAO) {
        this.productnameDAO = productnameDAO;
    }

    public void setSizeDAO(SizeDAO sizeDAO) {
        this.sizeDAO = sizeDAO;
    }

    public void setThicknessDAO(ThicknessDAO thicknessDAO) {
        this.thicknessDAO = thicknessDAO;
    }

    public void setStiffnessDAO(StiffnessDAO stiffnessDAO) {
        this.stiffnessDAO = stiffnessDAO;
    }

    public void setColourDAO(ColourDAO colourDAO) {
        this.colourDAO = colourDAO;
    }

    public void setOverlaytypeDAO(OverlaytypeDAO overlaytypeDAO) {
        this.overlaytypeDAO = overlaytypeDAO;
    }

    public void setOriginDAO(OriginDAO originDAO) {
        this.originDAO = originDAO;
    }

    public void setMarketDAO(MarketDAO marketDAO) {
        this.marketDAO = marketDAO;
    }

    public UserDAO getUserDAO() {
        return userDAO;
    }

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public void setImportproductDAO(ImportproductDAO importproductDAO) {
        this.importproductDAO = importproductDAO;
    }

    @Override
	protected GenericDAO<Importproduct, Long> getGenericDAO() {
		return importproductDAO;
	}

    @Override
    public void updateItem(ImportproductBean ImportproductBean) throws ObjectNotFoundException, DuplicateException {
        Importproduct dbItem = this.importproductDAO.findByIdNoAutoCommit(ImportproductBean.getPojo().getImportProductID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Importproduct " + ImportproductBean.getPojo().getImportProductID());

        Importproduct pojo = ImportproductBean.getPojo();

        this.importproductDAO.detach(dbItem);
        this.importproductDAO.update(pojo);
    }

    @Override
    public void addNew(ImportproductBean ImportproductBean) throws DuplicateException {
        Importproduct pojo = ImportproductBean.getPojo();
        pojo = this.importproductDAO.save(pojo);
        ImportproductBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                importproductDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ImportproductBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        return this.importproductDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Importproduct> findAvailableBlackProductByWarehouse(Long warehouseID) {
        return this.importproductDAO.findAvailableBlackProductByWarehouse(warehouseID);
    }

    @Override
    public List<Importproduct> findTempSelectedBlackProductByWarehouseAndCodes(Long warehouseID, List<String> tempSelectedCodes) {
        return this.importproductDAO.findTempSelectedBlackProductByWarehouseAndCodes(warehouseID,tempSelectedCodes);
    }

    @Override
    public Object[] searchProductsInStock(SearchProductBean bean) {
        return this.importproductDAO.searchProductsInStock(bean);
    }

    @Override
    public List<ProducedProductDTO> reportProducedProduct(ProducedProductBean bean) {
        List<ProducedProductDTO> producedProductDTOs = new LinkedList<ProducedProductDTO>();
        Map<String,List<Importproduct>> tempMap = new LinkedHashMap<String, List<Importproduct>>();
        List<Importproduct> importproductList = this.importproductDAO.findImportProduct(bean);
        for (Importproduct importproduct : importproductList){
            Map<Long,Double> qualityQuantityMap = new HashMap<Long, Double>();
            for(Productquality prdQuality : importproduct.getProductqualitys()){
                qualityQuantityMap.put(prdQuality.getQuality().getQualityID(),prdQuality.getQuantity1());
            }
            importproduct.setQualityQuantityMap(qualityQuantityMap);
            if(importproduct.getMainUsedMaterialCode() != null){
                if(tempMap.get(importproduct.getMainUsedMaterialCode()) != null){
                    tempMap.get(importproduct.getMainUsedMaterialCode()).add(importproduct);
                }else{
                    List<Importproduct> tempList = new ArrayList<Importproduct>();
                    tempList.add(importproduct);
                    tempMap.put(importproduct.getMainUsedMaterialCode(),tempList);
                }
            }else{
                List<Importproduct> tempList = new ArrayList<Importproduct>();
                tempList.add(importproduct);
                tempMap.put(importproduct.getProductCode()+"_" +importproduct.getImportProductID(),tempList);
            }
        }
        for(List<Importproduct> prds : tempMap.values()){
            ProducedProductDTO producedProductDTO = new ProducedProductDTO();
            producedProductDTO.setProducedProducts(prds);
            if(prds != null && prds.size() > 0 && prds.get(0).getMainUsedMaterial() != null){
                producedProductDTO.setMainMaterial(prds.get(0).getMainUsedMaterial());
            }
            producedProductDTOs.add(producedProductDTO);
        }
        return producedProductDTOs;
    }

    @Override
    public List<Importproduct> findAvailableNoneBlackProductByWarehouse(Long warehouseID) {
        return this.importproductDAO.findAvailableNoneBlackProductByWarehouse(warehouseID);
    }

    private String normalizeFilename(String input) {
        String result = Normalizer.normalize(input, Normalizer.Form.NFD);
        result = result.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        result = result.replace('đ', 'd');
        result = result.replace('Đ', 'D');
        result = result.replaceAll("[^a-z A-Z0-9-\\.]", "");
        result = result.replaceAll(" ", "-");
        return result;
    }

    @Override
    public Object[] importProductData2DB(List<ImportProductDataDTO> importedDatas,Long userID) throws Exception{
        Warehouse warehouse = importedDatas.get(0).getWarehouse();
        User loginUser = new User();
        loginUser.setUserID(userID);
        Unit unitM = this.unitDAO.findByName(Constants.UNIT_MET).get(0);
        Unit unitKg = this.unitDAO.findByName(Constants.UNIT_KG).get(0);
        Timestamp now = new Timestamp(System.currentTimeMillis());

        Map<String,Productname> mapProductName = new HashMap<String, Productname>();
        List<Productname> productnames = this.productnameDAO.findAll();
        for(Productname productname : productnames){
            mapProductName.put(productname.getName().toUpperCase(),productname);
        }

        Map<String,Size> mapSize = new HashMap<String, Size>();
        List<Size> sizes = this.sizeDAO.findAll();
        for(Size size : sizes){
            mapSize.put(size.getName().toUpperCase(),size);
        }

        Map<String,Thickness> mapThickness = new HashMap<String, Thickness>();
        List<Thickness> thicknesses = this.thicknessDAO.findAll();
        for(Thickness thickness : thicknesses){
            mapThickness.put(thickness.getName().toUpperCase(),thickness);
        }

        Map<String,Stiffness> mapStiffness = new HashMap<String, Stiffness>();
        List<Stiffness> stiffnesses = this.stiffnessDAO.findAll();
        for(Stiffness stiffness : stiffnesses){
            mapStiffness.put(stiffness.getName().toUpperCase(),stiffness);
        }

        Map<String,Colour> mapColour = new HashMap<String, Colour>();
        List<Colour> colours = this.colourDAO.findAll();
        for(Colour colour : colours){
            mapColour.put(normalizeFilename(colour.getName()).toUpperCase().trim(),colour);
        }

        Map<String,Overlaytype> mapOverlay = new HashMap<String, Overlaytype>();
        List<Overlaytype> overlaytypes = this.overlaytypeDAO.findAll();
        for(Overlaytype overlaytype : overlaytypes){
            mapOverlay.put(overlaytype.getName().toUpperCase(),overlaytype);
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

        Map<String,Quality> mapQuality = new HashMap<String, Quality>();
        List<Quality> qualities = this.qualityDAO.findAll();
        for(Quality quality : qualities){
            mapQuality.put(quality.getName().toUpperCase(),quality);
        }

        Map<String,Importproduct> mapCodeProduct = mappingCodeProductInDB(warehouse.getWarehouseID());
        Map<String,Importproduct> mapCodeProductOfOthers = mappingCodeProductOfOthers(warehouse.getWarehouseID());


        Importproductbill bill = new Importproductbill();
        bill.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        bill.setWarehouse(warehouse);
        bill.setStatus(Constants.CONFIRMED);
        bill.setDescription(Constants.INITIAL_IMPORT_DATA);
        bill.setCode(Constants.INITIAL_IMPORT_CODE);
        bill.setProduceGroup(Constants.PRODUCT_GROUP_IMPORTED);
        bill.setCreatedBy(loginUser);
        bill = this.importproductbillDAO.save(bill);
        Integer totalImported = 0;
        StringBuilder failCode = new StringBuilder("");
        StringBuilder wrongStatusCode = new StringBuilder("");
        StringBuilder unTouchCode = new StringBuilder("");
        StringBuilder inPM = new StringBuilder("");

        for(ImportProductDataDTO dataDTO : importedDatas){
            if(dataDTO.isValid()){
                Importproduct importproduct = mapCodeProduct.get(dataDTO.getCode().toUpperCase().trim());
                if(importproduct == null){
                    importproduct = mapCodeProductOfOthers.get(dataDTO.getCode().toUpperCase().trim());
                    if(importproduct != null){
                        saveOrUpdateProductInfo(importproduct, dataDTO, bill, mapProductName, mapSize, mapThickness, mapStiffness, mapColour, mapOverlay,
                                mapOrigin, mapMarket, mapQuality, unitM, unitKg, warehouse, now);
                        totalImported++;
                    }else{
                        importproduct = new Importproduct();
                        saveOrUpdateProductInfo(importproduct,dataDTO,bill,mapProductName,mapSize,mapThickness,mapStiffness,mapColour,mapOverlay,
                                mapOrigin,mapMarket,mapQuality,unitM,unitKg,warehouse,now);                         
                        totalImported++;
                    }
                }else{
                    mapCodeProduct.remove(dataDTO.getCode());
                    saveOrUpdateProductInfo(importproduct,dataDTO,bill,mapProductName,mapSize,mapThickness,mapStiffness,mapColour,mapOverlay,
                            mapOrigin,mapMarket,mapQuality,unitM,unitKg,warehouse,now);
                    totalImported++;
                }
            }else{
                if(StringUtils.isNotBlank(failCode.toString())){
                    failCode.append(", ").append(dataDTO.getCode());
                }else{
                    failCode.append(dataDTO.getCode());
                }
            }
        }

        if(mapCodeProduct != null && !mapCodeProduct.isEmpty()){
            List<String> codes = new ArrayList<String>(mapCodeProduct.keySet());
            this.importproductDAO.updateStatusByCodes(codes, Constants.ROOT_MATERIAL_STATUS_USED);
        }

        String msg = failCode.toString();
        if(StringUtils.isNotBlank(wrongStatusCode.toString())){
            msg += "<br>Wrong Status: " + wrongStatusCode.toString();
        }
        if(StringUtils.isNotBlank(unTouchCode.toString())){
            msg += "<br>Untouched codes: " + unTouchCode.toString();
        }
        if(StringUtils.isNotBlank(inPM.toString())){
            msg += "<br>In Phu My codes: " + inPM.toString();
        }
        return new Object[]{totalImported, msg};
    }

    private void saveOrUpdateProductInfo(Importproduct importproduct, ImportProductDataDTO dataDTO, Importproductbill bill, Map<String,Productname> mapProductName,
                                   Map<String,Size> mapSize, Map<String,Thickness> mapThickness, Map<String,Stiffness> mapStiffness, Map<String,Colour> mapColour,
                                   Map<String,Overlaytype> mapOverlay, Map<String,Origin> mapOrigin, Map<String,Market> mapMarket, Map<String,Quality> mapQuality,
                                   Unit unitM, Unit unitKg, Warehouse warehouse, Timestamp now) throws DuplicateException {
        importproduct.setProductCode(dataDTO.getCode());
        importproduct.setImportproductbill(bill);
        importproduct.setImportBack(null);
        importproduct.setUsedMet(null);
        importproduct.setCutOff(null);
        Productname productname = mapProductName.get(dataDTO.getName().toUpperCase());
        if(productname == null){
            productname = new Productname();
            productname.setName(dataDTO.getName());
            productname = this.productnameDAO.save(productname);
            mapProductName.put(productname.getName().toUpperCase(),productname);
        }
        importproduct.setProductname(productname);
        if(dataDTO.getSize() != null && StringUtils.isNotBlank(dataDTO.getSize())){
            Size size = mapSize.get(dataDTO.getSize().toUpperCase());
            if(size == null){
                size = new Size();
                size.setName(dataDTO.getSize());
                size = this.sizeDAO.save(size);
                mapSize.put(size.getName().toUpperCase(),size);
            }
            importproduct.setSize(size);
        }

        if(dataDTO.getThickness() != null && StringUtils.isNotBlank(dataDTO.getThickness())){
            Thickness thickness = mapThickness.get(dataDTO.getThickness().toUpperCase());
            if(thickness == null){
                thickness = new Thickness();
                thickness.setName(dataDTO.getThickness());
                thickness = this.thicknessDAO.save(thickness);
                mapThickness.put(thickness.getName().toUpperCase(),thickness);
            }
            importproduct.setThickness(thickness);
        }


        if(dataDTO.getStiffness() != null && StringUtils.isNotBlank(dataDTO.getStiffness())){
            Stiffness stiffness = mapStiffness.get(dataDTO.getStiffness().toUpperCase());
            if(stiffness == null){
                stiffness = new Stiffness();
                stiffness.setName(dataDTO.getStiffness());
                stiffness = this.stiffnessDAO.save(stiffness);
                mapStiffness.put(stiffness.getName().toUpperCase(),stiffness);
            }
            importproduct.setStiffness(stiffness);
        }

        if(dataDTO.getColour() != null && StringUtils.isNotBlank(dataDTO.getColour())){
            Colour colour = mapColour.get(normalizeFilename(dataDTO.getColour()).toUpperCase());
            if(colour == null){
                colour = new Colour();
                colour.setName(dataDTO.getColour());
                colour = this.colourDAO.save(colour);
                mapColour.put(normalizeFilename(colour.getName()).toUpperCase(),colour);
            }
            importproduct.setColour(colour);
        }
        if(dataDTO.getOverlay() != null && StringUtils.isNotBlank(dataDTO.getOverlay())){
            Overlaytype overlaytype = mapOverlay.get(dataDTO.getOverlay().toUpperCase());
            if(overlaytype == null){
                overlaytype = new Overlaytype();
                overlaytype.setName(dataDTO.getOverlay());
                overlaytype = this.overlaytypeDAO.save(overlaytype);
                mapOverlay.put(overlaytype.getName().toUpperCase(),overlaytype);
            }
            importproduct.setOverlaytype(overlaytype);
        }

        if(dataDTO.getOrigin() != null && StringUtils.isNotBlank(dataDTO.getOrigin())){
            Origin origin = mapOrigin.get(dataDTO.getOrigin().toUpperCase());
            if(origin == null){
                origin = new Origin();
                origin.setName(dataDTO.getOrigin());
                origin = this.originDAO.save(origin);
                mapOrigin.put(origin.getName().toUpperCase(),origin);
            }
            importproduct.setOrigin(origin);
        }

        if(dataDTO.getMarket() != null && StringUtils.isNotBlank(dataDTO.getMarket())){
            Market market = mapMarket.get(dataDTO.getMarket().toUpperCase());
            if(market == null){
                market = new Market();
                market.setName(dataDTO.getMarket());
                market = this.marketDAO.save(market);
                mapMarket.put(market.getName().toUpperCase(),market);
            }
            importproduct.setMarket(market);
        }

        if(dataDTO.getTotalM() != null && StringUtils.isNotBlank(dataDTO.getTotalM())){
            importproduct.setQuantity1(Double.valueOf(dataDTO.getTotalM()));
            importproduct.setUnit1(unitM);
        }

        importproduct.setQuantity2Pure(Double.valueOf(dataDTO.getTotalKg()));
        importproduct.setUnit2(unitKg);
        if(dataDTO.getMoney() != null && StringUtils.isNotBlank(dataDTO.getMoney())){
            importproduct.setMoney(Double.valueOf(dataDTO.getMoney()));
        }
        importproduct.setWarehouse(warehouse);
        importproduct.setStatus(Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
        if(dataDTO.getDate() != null && StringUtils.isNotBlank(dataDTO.getDate())){
            importproduct.setImportDate(new Timestamp(DateUtils.string2Date(dataDTO.getDate(), "dd/MM/yyyy").getTime()) );
        }else {
            importproduct.setImportDate(now);
        }
        importproduct.setCore(dataDTO.getLoi());
        importproduct.setNote(dataDTO.getNote());
        importproduct = this.importproductDAO.saveOrUpdate(importproduct);
        List<Productquality> productqualities = importproduct.getProductqualitys();
        if(productqualities != null){
            if(dataDTO.getA() != null && StringUtils.isNotBlank(dataDTO.getA())){
                updateOrSaveProductQuality(productqualities, importproduct, dataDTO.getA(), unitM, mapQuality, Constants.QUALITY_A);
            }
            if(dataDTO.getB() != null && StringUtils.isNotBlank(dataDTO.getB())){
                updateOrSaveProductQuality(productqualities, importproduct, dataDTO.getB(), unitM, mapQuality, Constants.QUALITY_B);
            }
            if(dataDTO.getC() != null && StringUtils.isNotBlank(dataDTO.getC())){
                updateOrSaveProductQuality(productqualities, importproduct, dataDTO.getC(), unitM, mapQuality, Constants.QUALITY_C);
            }
            if(dataDTO.getPp() != null && StringUtils.isNotBlank(dataDTO.getPp())){
                updateOrSaveProductQuality(productqualities, importproduct, dataDTO.getPp(), unitM, mapQuality, Constants.QUALITY_PP);
            }
            if(productqualities != null && !productqualities.isEmpty()){
                this.productqualityDAO.deleteAll(productqualities);
            }
        }else{
            if(dataDTO.getA() != null && StringUtils.isNotBlank(dataDTO.getA())){
                saveOrUpdateProductQuality(new Productquality(),importproduct,Double.valueOf(dataDTO.getA()),unitM,mapQuality.get(Constants.QUALITY_A));
            }
            if(dataDTO.getB() != null && StringUtils.isNotBlank(dataDTO.getB())){
                saveOrUpdateProductQuality(new Productquality(),importproduct,Double.valueOf(dataDTO.getB()),unitM,mapQuality.get(Constants.QUALITY_B) );
            }
            if(dataDTO.getC() != null && StringUtils.isNotBlank(dataDTO.getC())){
                saveOrUpdateProductQuality(new Productquality(),importproduct,Double.valueOf(dataDTO.getC()),unitM,mapQuality.get(Constants.QUALITY_C));
            }
            if(dataDTO.getPp() != null && StringUtils.isNotBlank(dataDTO.getPp())){
                saveOrUpdateProductQuality(new Productquality(),importproduct,Double.valueOf(dataDTO.getPp()),unitM,mapQuality.get(Constants.QUALITY_PP));
            }
        }
    }

    private void updateOrSaveProductQuality(List<Productquality> productqualities,Importproduct importproduct, String value,
                                 Unit unitM,Map<String,Quality> mapQuality, String qualityName){
        boolean marker = false;
        if(productqualities.size() > 0){
            for(int i = productqualities.size() - 1; i >=0; i-- ){
                Productquality productquality = productqualities.get(i);
                if(productquality.getQuality().getName().toUpperCase().equals(qualityName)){
                    saveOrUpdateProductQuality(productquality,importproduct,Double.valueOf(value),unitM,mapQuality.get(qualityName));
                    productqualities.remove(i);
                    marker = true;
                    break;
                }
            }
        }
        if(!marker){
            saveOrUpdateProductQuality(new Productquality(),importproduct,Double.valueOf(value),unitM,mapQuality.get(qualityName));
        }
    }

    private Map<String, Importproduct> mappingCodeProductOfOthers(Long warehouseID) {
        Map<String,Importproduct> result = new HashMap<String, Importproduct>();
        List<Importproduct> importproducts = this.importproductDAO.findNotInWarehouse(warehouseID);
        for(Importproduct importproduct : importproducts){
            result.put(importproduct.getProductCode().toUpperCase().trim(),importproduct);
        }
        return result;
    }

    private Map<String, Importproduct> mappingCodeProductInDB(Long warehouseID) {
        Map<String,Importproduct> result = new HashMap<String, Importproduct>();
        List<Importproduct> importproducts = this.importproductDAO.findByWarehouse(warehouseID);
        for(Importproduct importproduct : importproducts){
            result.put(importproduct.getProductCode().toUpperCase().trim(),importproduct);
        }
        return result;
    }

    @Override
    public void updateSuggestPrice(List<SuggestPriceDTO> suggestedItems, Long suggester) {
        User suggestUser = new User();
        suggestUser.setUserID(suggester);
        Timestamp now = new Timestamp(System.currentTimeMillis());
        Map<Long,Double> itemPrice = new HashMap<Long, Double>();
        List<Long> productIDs = new ArrayList<Long>();
        for(SuggestPriceDTO suggestItem : suggestedItems){
            if(suggestItem.getPrice() != null && suggestItem.getPrice() > 0){
                itemPrice.put(suggestItem.getItemID(),suggestItem.getPrice());
                productIDs.add(suggestItem.getItemID());
            }
        }
        if(productIDs.size() > 0){
            List<Importproduct> dbProducts = this.importproductDAO.findByIDs(productIDs);
            for(Importproduct dbProduct : dbProducts){
                dbProduct.setSuggestedBy(suggestUser);
                dbProduct.setSuggestedDate(now);
                dbProduct.setSuggestedPrice(itemPrice.get(dbProduct.getImportProductID()));
                this.importproductDAO.update(dbProduct);
            }
        }

    }

    @Override
    public List<Importproduct> findWarningProduct(Long warehouseID) {
        return this.importproductDAO.findWarningProduct(warehouseID);
    }

    @Override
    public void updateProductLocation(List<SuggestPriceDTO> changingProducts,Long userID) {
        User user = new User();
        user.setUserID(userID);
        for(SuggestPriceDTO selectedProduct : changingProducts){
            if(selectedProduct.getItemID() != null){
                Importproduct importproduct = this.importproductDAO.findByIdNoAutoCommit(selectedProduct.getItemID());
                LocationHistory locationHistory = new LocationHistory();
                locationHistory.setImportProduct(importproduct);
                locationHistory.setCreatedBy(user);
                locationHistory.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                locationHistory.setOldLocation(importproduct.getWarehouseMap());
                locationHistory.setWarehouse(importproduct.getWarehouse());
                if(selectedProduct.getWarehouseMap().getWarehouseMapID() > 0){
                    importproduct.setWarehouseMap(selectedProduct.getWarehouseMap());
                    locationHistory.setNewLocation(selectedProduct.getWarehouseMap());
                }else{
                    importproduct.setWarehouseMap(null);
                }
                if((locationHistory.getOldLocation() == null && locationHistory.getNewLocation() != null) ||
                        (locationHistory.getOldLocation() != null && locationHistory.getNewLocation() == null)  ||
                        (locationHistory.getOldLocation() != null && locationHistory.getNewLocation() != null
                                && locationHistory.getOldLocation().getWarehouseMapID() != locationHistory.getNewLocation().getWarehouseMapID())){
                    this.locationHistoryDAO.save(locationHistory);
                    this.importproductDAO.update(importproduct);
                }
            }
        }
    }


    private void saveOrUpdateProductQuality(Productquality productquality, Importproduct importproduct,Double value,Unit unit,Quality quality){
        productquality.setImportproduct(importproduct);
        productquality.setQuality(quality);
        productquality.setQuantity1(value);
        productquality.setUnit1(unit);
        productqualityDAO.saveOrUpdate(productquality);
    }

    @Override
	public List<Importproduct> findAllSortAsc() {
        StringBuffer whereClause = new StringBuffer();
		return this.importproductDAO.findByProperties(new HashMap<String, Object>(), "id", Constants.SORT_ASC, true, whereClause.toString());
	}


    @Override
    public List<Importproduct> summarySoldProducts(ReportBean bean) {
        List<Importproduct> soldProducts = this.importproductDAO.summarySoldProducts(bean);
        if(soldProducts != null && soldProducts.size() > 0){
            List<Long> ids = new ArrayList<Long>();
            Map<Long,Timestamp> mapProductDate = new HashMap<Long, Timestamp>();
            Map<Long,Customer> mapProductCustomer = new HashMap<Long, Customer>();
            for(Importproduct sp : soldProducts){
                ids.add(sp.getImportProductID());
            }
            List<Exportproduct> exportproducts = this.exportproductDAO.findByProductIds(ids);
            for(Exportproduct exportproduct : exportproducts){
                mapProductDate.put(exportproduct.getImportproduct().getImportProductID(),exportproduct.getExportproductbill().getExportDate());
                mapProductCustomer.put(exportproduct.getImportproduct().getImportProductID(),exportproduct.getExportproductbill().getCustomer());
            }
            for(Importproduct sp : soldProducts){
                sp.setSoldDate(mapProductDate.get(sp.getImportProductID()));
                sp.setSoldFor(mapProductCustomer.get(sp.getImportProductID()));
            }
        }
        return soldProducts;
    }

    @Override
    public List<Importproduct> findImportByPlan(Long productionPlanID,String importType) {
        return this.importproductDAO.findImportByPlan(productionPlanID,importType);
    }

    @Override
    public List<SummaryByOverlayDTO> summaryByOverlay(ProducedProductBean bean) throws Exception {
        List<SummaryByOverlayDTO> results = new ArrayList<SummaryByOverlayDTO>();
        List<Importproduct> importproducts = this.importproductDAO.findImportProduct(bean);
        Map<String,List<Importproduct>> mapProducts = new HashMap<String, List<Importproduct>>();
        for(Importproduct importproduct : importproducts){
            String key = importproduct.getProductname().getProductNameID() + "_" + importproduct.getMainUsedMaterial().getProductname().getProductNameID();
            List<Importproduct> products = mapProducts.get(key);
            if(products == null){
                products = new ArrayList<Importproduct>();
                products.add(importproduct);
                mapProducts.put(key,products);
            }else {
                products.add(importproduct);
            }
        }
        Map<Long,String> mapOrigin = buildMapOriginName(this.originDAO.findAll());
        for(List<Importproduct> listImportProduct : mapProducts.values()){
            SummaryByOverlayDTO summaryByOverlayDTO = summaryOverlayInDetail(listImportProduct, mapOrigin);
            summaryByOverlayDTO.setProductName(listImportProduct.get(0).getProductname().getName());
            summaryByOverlayDTO.setMaterialName(listImportProduct.get(0).getMainUsedMaterial().getProductname().getName());
            results.add(summaryByOverlayDTO);
        }
        return results;
    }

    private Map<Long, String> buildMapOriginName(List<Origin> origins) {
        Map<Long,String> result = new HashMap<Long, String>();
        for(Origin origin : origins){
            result.put(origin.getOriginID(),origin.getName());
        }
        return result;
    }

    private SummaryByOverlayDTO summaryOverlayInDetail(List<Importproduct> importproducts, Map<Long,String> mapOrigin) throws Exception {
        SummaryByOverlayDTO result = new SummaryByOverlayDTO();
        Map<Long,Size> mapSize = new HashMap<Long, Size>();
        Map<Long,Overlaytype> mapOverlay = new HashMap<Long, Overlaytype>();
        Map<Long,Map<Long,SummaryDetailByOverlayDTO>> mapSizeOverlayDetail = new HashMap<Long, Map<Long, SummaryDetailByOverlayDTO>>();
        Map<Long,Map<Long,List<Importproduct>>> mapSizeOverlayProduct = new HashMap<Long, Map<Long, List<Importproduct>>>();

        for(Importproduct importproduct : importproducts){
            Importproduct mainUsedMaterial =  importproduct.getMainUsedMaterial();
            if(mainUsedMaterial != null && mainUsedMaterial.getSize() != null && importproduct.getOverlaytype() != null){
                Long sizeID = mainUsedMaterial.getSize().getSizeID();
                Long overlayID = importproduct.getOverlaytype().getOverlayTypeID();
                if(!mapSize.containsKey(sizeID)){
                    mapSize.put(sizeID,mainUsedMaterial.getSize());
                }
                if(!mapOverlay.containsKey(overlayID)){
                    mapOverlay.put(overlayID,importproduct.getOverlaytype());
                }

                Map<Long,List<Importproduct>> mapOverlayProduct =  mapSizeOverlayProduct.get(sizeID);
                if(mapOverlayProduct == null){
                    mapOverlayProduct = new HashMap<Long, List<Importproduct>>();
                    List<Importproduct> tempImportproducts = new ArrayList<Importproduct>();
                    tempImportproducts.add(importproduct);
                    mapOverlayProduct.put(overlayID,tempImportproducts);
                    mapSizeOverlayProduct.put(sizeID,mapOverlayProduct);
                }else{
                    List<Importproduct> tempImportproducts = mapOverlayProduct.get(overlayID);
                    if(tempImportproducts == null){
                        tempImportproducts = new ArrayList<Importproduct>();
                        tempImportproducts.add(importproduct);
                        mapOverlayProduct.put(overlayID,tempImportproducts);
                    }else{
                        tempImportproducts.add(importproduct);
                    }
                }
            }
        }
        Map<Long,List<SummaryDetailByOverlayDTO>> mapOverlayDetails = new HashMap<Long, List<SummaryDetailByOverlayDTO>>();
        Map<Long,Map<Long,Double>> mapOverlayOriginQuantity = new HashMap<Long, Map<Long, Double>>();
        Map<Long,List<Long>> mapOverlayOrigins = new HashMap<Long, List<Long>>();
        for(Long sizeID : mapSizeOverlayProduct.keySet()){
            for(Long overlayID : mapSizeOverlayProduct.get(sizeID).keySet()){
                List<Long> originIDs = mapOverlayOrigins.get(overlayID);
                Map<Long,Double> mapOriginOverallQuantity = mapOverlayOriginQuantity.get(overlayID);
                List<Importproduct> tempProducts = mapSizeOverlayProduct.get(sizeID).get(overlayID);
                SummaryDetailByOverlayDTO detaiByOverlayDTO = new SummaryDetailByOverlayDTO();
                Double materialKg = 0d;
                Double productKg = 0d;
                Double productMet = 0d;
                Map<Long,Double> mapQualityMet = new HashMap<Long, Double>();
                List<Long> mainMaterials = new ArrayList<Long>();
                Map<Long,Double> mapOriginQuantity = new HashMap<Long, Double>();
                for(Importproduct importproduct : tempProducts){
                    try{
                        if(!mainMaterials.contains(importproduct.getMainUsedMaterial().getImportProductID())){
                            Long mainOriginID = getMainOrigin(importproduct.getMainUsedMaterial());
                            if(originIDs == null){
                                originIDs = new ArrayList<Long>();
                                originIDs.add(mainOriginID);
                                mapOverlayOrigins.put(overlayID,originIDs);
                            }else if(!originIDs.contains(mainOriginID)){
                                originIDs.add(mainOriginID);
                            }
                            Double materialQuantity = importproduct.getMainUsedMaterial().getImportBack() != null ? importproduct.getMainUsedMaterial().getQuantity2Pure() - importproduct.getMainUsedMaterial().getImportBack() : importproduct.getMainUsedMaterial().getQuantity2Pure();
                            if(importproduct.getMainUsedMaterial().getCutOff() != null){
                                materialQuantity -= importproduct.getMainUsedMaterial().getCutOff();
                            }
                            materialKg += materialQuantity;
                            mainMaterials.add(importproduct.getMainUsedMaterial().getImportProductID());
                            if(!mapOriginQuantity.containsKey(mainOriginID)){
                                mapOriginQuantity.put(mainOriginID,materialQuantity);
                            }else {
                                mapOriginQuantity.put(mainOriginID,mapOriginQuantity.get(mainOriginID) + materialQuantity);
                            }
                            if(mapOriginOverallQuantity != null){
                                if(!mapOriginOverallQuantity.containsKey(mainOriginID)){
                                    mapOriginOverallQuantity.put(mainOriginID,materialQuantity);
                                }else {
                                    mapOriginOverallQuantity.put(mainOriginID,mapOriginOverallQuantity.get(mainOriginID) + materialQuantity);
                                }
                            }else {
                                mapOriginOverallQuantity = new HashMap<Long, Double>();
                                mapOriginOverallQuantity.put(mainOriginID,materialQuantity);
                                mapOverlayOriginQuantity.put(overlayID,mapOriginOverallQuantity);
                            }
                        }
                        productKg +=  importproduct.getQuantity2Pure();
                        productMet += importproduct.getQuantity1() != null ? importproduct.getQuantity1() : 0d;
                        for(Productquality productquality : importproduct.getProductqualitys()){
                            Long qualityID = productquality.getQuality().getQualityID();
                            Double current = mapQualityMet.get(qualityID) != null ? mapQualityMet.get(qualityID) : 0d;
                            mapQualityMet.put(qualityID,current +  productquality.getQuantity1());
                        }
                    }catch (Exception e){
                        logger.error(e.getMessage(),e);
                    }
                }

                detaiByOverlayDTO.setMaterialKg(materialKg);
                detaiByOverlayDTO.setProductKg(productKg);
                detaiByOverlayDTO.setProductMet(productMet);
                detaiByOverlayDTO.setMapQualityMet(mapQualityMet);
                detaiByOverlayDTO.setMapOriginQuantity(mapOriginQuantity);
                detaiByOverlayDTO.setOriginQuantityHTML(HTMLGeneratorUtil.createSimpleOriginQuantityInfo(mapOriginQuantity, mapOrigin));

                List<SummaryDetailByOverlayDTO> summaryDetailByOverlayDTOList = mapOverlayDetails.get(overlayID);
                if(summaryDetailByOverlayDTOList == null){
                    summaryDetailByOverlayDTOList = new ArrayList<SummaryDetailByOverlayDTO>();
                    summaryDetailByOverlayDTOList.add(detaiByOverlayDTO);
                    mapOverlayDetails.put(overlayID,summaryDetailByOverlayDTOList);
                }else{
                    summaryDetailByOverlayDTOList.add(detaiByOverlayDTO);
                }

                Map<Long,SummaryDetailByOverlayDTO> mapOverlayDetail = mapSizeOverlayDetail.get(sizeID);
                if(mapOverlayDetail == null){
                    mapOverlayDetail = new HashMap<Long, SummaryDetailByOverlayDTO>();
                    mapOverlayDetail.put(overlayID,detaiByOverlayDTO);
                    mapSizeOverlayDetail.put(sizeID,mapOverlayDetail);
                }else{
                    mapOverlayDetail.put(overlayID,detaiByOverlayDTO);
                }
            }
        }

        List<Size> sizes = new ArrayList<Size>(mapSize.values());
        List<Overlaytype> overLayTypes = new ArrayList<Overlaytype>(mapOverlay.values());
        result.setSizes(sizes);
        result.setOverlayTypes(overLayTypes);
        result.setMapSizeOverlayDetail(mapSizeOverlayDetail);
        result.setMapTotalSummary(calTotalSummaryByOverlay(mapOverlayDetails));
        result.setMapOverlaySummaryOriginQuantity(HTMLGeneratorUtil.createMapOverlaySimpleOriginQuantityInfo(mapOverlayOriginQuantity, mapOrigin));
        result.setMapOverlayOrigins(mapOverlayOrigins);
        result.setMapOverlayOriginQuantity(mapOverlayOriginQuantity);
        return result;
    }

    private Long getMainOrigin(Importproduct mainUsedMaterial) {
        Long originID = null;
        if(mainUsedMaterial != null){
            if(mainUsedMaterial.getOrigin() != null){
                originID = mainUsedMaterial.getOrigin().getOriginID();
                return originID;
            }else if(mainUsedMaterial.getMainUsedMaterial() != null){
                originID = getMainOrigin(mainUsedMaterial.getMainUsedMaterial());
            }
        }
        return originID;
    }

    private Map<Long,SummaryDetailByOverlayDTO> calTotalSummaryByOverlay(Map<Long,List<SummaryDetailByOverlayDTO>> mapOverlayDetails) {
        Map<Long,SummaryDetailByOverlayDTO> mapOverall = new HashMap<Long, SummaryDetailByOverlayDTO>();
        for(Long overlayID : mapOverlayDetails.keySet()){
            SummaryDetailByOverlayDTO overall = new SummaryDetailByOverlayDTO();
            Double materialKg = 0d;
            Double productKg = 0d;
            Double productMet = 0d;
            Map<Long,Double> mapQualityMet = new HashMap<Long, Double>();
            for(SummaryDetailByOverlayDTO summaryDetailByOverlayDTO : mapOverlayDetails.get(overlayID)){
                materialKg += summaryDetailByOverlayDTO.getMaterialKg();
                productKg +=  summaryDetailByOverlayDTO.getProductKg();
                productMet += summaryDetailByOverlayDTO.getProductMet();
                for(Long qualityID : summaryDetailByOverlayDTO.getMapQualityMet().keySet()){
                    Double current = mapQualityMet.get(qualityID) != null ? mapQualityMet.get(qualityID) : 0d;
                    mapQualityMet.put(qualityID,current +  summaryDetailByOverlayDTO.getMapQualityMet().get(qualityID));
                }
            }
            overall.setMaterialKg(materialKg);
            overall.setProductKg(productKg);
            overall.setProductMet(productMet);
            overall.setMapQualityMet(mapQualityMet);
            mapOverall.put(overlayID,overall);
        }
        return mapOverall;
    }


    @Override
    public List<SummaryProductionDTO> summaryProducttion(ProducedProductBean bean) {
        List<SummaryProductionDTO> results = new ArrayList<SummaryProductionDTO>();
        List<Importproduct> importproducts = this.importproductDAO.findImportProduct(bean);
        Map<String,List<Importproduct>> mapProducts = new HashMap<String, List<Importproduct>>();
        for(Importproduct importproduct : importproducts){
            String key = importproduct.getProductname().getProductNameID() + "_" + importproduct.getMainUsedMaterial().getProductname().getProductNameID();
            List<Importproduct> products = mapProducts.get(key);
            if(products == null){
                products = new ArrayList<Importproduct>();
                products.add(importproduct);
                mapProducts.put(key,products);
            }else {
                products.add(importproduct);
            }
        }
        Map<Long,String> mapOrigin = buildMapOriginName(this.originDAO.findAll());
        for(List<Importproduct> listImportProduct : mapProducts.values()){
            SummaryProductionDTO summaryProductionDTO = summaryProductionInDetail(listImportProduct, mapOrigin);
            summaryProductionDTO.setProductName(listImportProduct.get(0).getProductname().getName());
            summaryProductionDTO.setMaterialName(listImportProduct.get(0).getMainUsedMaterial().getProductname().getName());
            results.add(summaryProductionDTO);
        }
        return results;
    }


    private SummaryProductionDTO summaryProductionInDetail(List<Importproduct> importproducts, Map<Long,String> mapOrigin) {
        SummaryProductionDTO result = new SummaryProductionDTO();
        Map<Long,List<Importproduct>> mapSizeProduct =  new HashMap<Long, List<Importproduct>>();
        for(Importproduct importproduct : importproducts){
            Importproduct mainUsedMaterial =  importproduct.getMainUsedMaterial();
            if(mainUsedMaterial != null && mainUsedMaterial.getSize() != null){
                Long sizeID = mainUsedMaterial.getSize().getSizeID();
                if(!mapSizeProduct.containsKey(sizeID)){
                    List<Importproduct> tempImportproducts = new ArrayList<Importproduct>();
                    tempImportproducts.add(importproduct);
                    mapSizeProduct.put(sizeID,tempImportproducts);
                }else{
                    List<Importproduct> tempImportproducts = mapSizeProduct.get(sizeID);
                    if(tempImportproducts == null){
                        tempImportproducts = new ArrayList<Importproduct>();
                        tempImportproducts.add(importproduct);
                        mapSizeProduct.put(sizeID, tempImportproducts);
                    }else{
                        tempImportproducts.add(importproduct);
                    }
                }
            }
        }
        List<SummaryProductionDetailDTO> detailDTOs = new ArrayList<SummaryProductionDetailDTO>();
        SummaryProductionDetailDTO overallDetail = new SummaryProductionDetailDTO();
        Double overallMaterialKg = 0d;
        Double overallProductKg = 0d;
        Double overallTotalMet = 0d;
        Double overallTotalMet2 = 0d;
        Integer overallNoMaterialRoll = 0;
        Integer overallNoProductRoll = 0;
        Map<Long,Double> mapOverallQualityMet = new HashMap<Long, Double>();
        Map<Long,Double> mapOriginOverallQuantity = new HashMap<Long, Double>();
        for(Long sizeID : mapSizeProduct.keySet()){
            List<Importproduct> tempProducts = mapSizeProduct.get(sizeID);
            SummaryProductionDetailDTO detailDTO = new SummaryProductionDetailDTO();
            Double materialKg = 0d;
            Double productKg = 0d;
            Double totalMet = 0d;
            Map<Long,Double> mapQualityMet = new HashMap<Long, Double>();
            Map<Long,Double> mapOriginQuantity = new HashMap<Long, Double>();
            List<Long> mainMaterialIds = new ArrayList<Long>();
            for(Importproduct importproduct : tempProducts){
                if(!mainMaterialIds.contains(importproduct.getMainUsedMaterial().getImportProductID())){
                    Long mainOriginID = getMainOrigin(importproduct.getMainUsedMaterial());
                    if(!result.getOriginIDs().contains(mainOriginID)){
                        result.getOriginIDs().add(mainOriginID);
                    }
                    Double materialQuantity = importproduct.getMainUsedMaterial().getImportBack() != null ? importproduct.getMainUsedMaterial().getQuantity2Pure() - importproduct.getMainUsedMaterial().getImportBack() : importproduct.getMainUsedMaterial().getQuantity2Pure();
                    if(importproduct.getMainUsedMaterial().getCutOff() != null){
                        materialQuantity -= importproduct.getMainUsedMaterial().getCutOff();
                    }
                    materialKg += materialQuantity;
                    overallMaterialKg += materialQuantity;
                    if(!mapOriginQuantity.containsKey(mainOriginID)){
                        mapOriginQuantity.put(mainOriginID,materialQuantity);
                    }else {
                        mapOriginQuantity.put(mainOriginID,mapOriginQuantity.get(mainOriginID) + materialQuantity);
                    }

                    if(!mapOriginOverallQuantity.containsKey(mainOriginID)){
                        mapOriginOverallQuantity.put(mainOriginID,materialQuantity);
                    }else {
                        mapOriginOverallQuantity.put(mainOriginID,mapOriginOverallQuantity.get(mainOriginID) + materialQuantity);
                    }
                    mainMaterialIds.add(importproduct.getMainUsedMaterial().getImportProductID());
                }
                productKg +=  importproduct.getQuantity2Pure();
                overallProductKg +=  importproduct.getQuantity2Pure();

                for(Productquality productquality : importproduct.getProductqualitys()){
                    Long qualityID = productquality.getQuality().getQualityID();
                    Double current = mapQualityMet.get(qualityID) != null ? mapQualityMet.get(qualityID) : 0d;
                    Double overallCurrent = mapOverallQualityMet.get(qualityID) != null ? mapOverallQualityMet.get(qualityID) : 0d;

                    mapQualityMet.put(qualityID,current +  productquality.getQuantity1());
                    mapOverallQualityMet.put(qualityID,overallCurrent +  productquality.getQuantity1());

                    totalMet +=  productquality.getQuantity1();
                    overallTotalMet +=  productquality.getQuantity1();
                }
            }
            String size = tempProducts.get(0).getMainUsedMaterial().getSize().getName();
            String width = StringUtils.split(size,"x")[1];
            Double dWidth = Double.valueOf(width);
            Double totalMet2 = totalMet * dWidth / 1000;

            String specific =  tempProducts.get(0).getMainUsedMaterial().getThickness() != null ? tempProducts.get(0).getMainUsedMaterial().getThickness().getName() : "-";
            detailDTO.setSpecific(specific);
            detailDTO.setSize(size);
            detailDTO.setMaterialKg(materialKg);
            detailDTO.setProductKg(productKg);
            detailDTO.setTotalMet(totalMet);
            detailDTO.setTotalMet2(totalMet2);
            detailDTO.setMapQualityMet(mapQualityMet);
            detailDTO.setNoMaterialRoll(mainMaterialIds.size());
            detailDTO.setNoProductRoll(tempProducts.size());
            detailDTO.setMapOriginQuantity(mapOriginQuantity);;
            detailDTO.setOriginQuantityHTML(HTMLGeneratorUtil.createSimpleOriginQuantityInfo(mapOriginQuantity, mapOrigin));
            detailDTOs.add(detailDTO);

            overallTotalMet2 +=  totalMet2;
            overallNoMaterialRoll += mainMaterialIds.size();
            overallNoProductRoll += tempProducts.size();
        }
        overallDetail.setMaterialKg(overallMaterialKg);
        overallDetail.setNoMaterialRoll(overallNoMaterialRoll);
        overallDetail.setProductKg(overallProductKg);
        overallDetail.setNoProductRoll(overallNoProductRoll);
        overallDetail.setMapQualityMet(mapOverallQualityMet);
        overallDetail.setTotalMet(overallTotalMet);
        overallDetail.setTotalMet2(overallTotalMet2);
        overallDetail.setMapOriginQuantity(mapOriginOverallQuantity);
        overallDetail.setOriginQuantityHTML(HTMLGeneratorUtil.createSimpleOriginQuantityInfo(mapOriginOverallQuantity, mapOrigin));
        result.setOverallDetail(overallDetail);
        result.setSummaryProductionDetails(detailDTOs);
        return result;
    }


    @Override
    public List<SellSummaryDTO> sellReport(ReportBean bean) {
        List<SellSummaryDTO> results = new ArrayList<SellSummaryDTO>();
        try {
            List<Customer> customers = this.customerDAO.find4Report(bean);
            if(customers != null && customers.size() > 0){
                List<Long> customerIds = new ArrayList<Long>();
                for(Customer customer : customers){
                    customerIds.add(customer.getCustomerID());
                }
                Object[] objArr = getCustomerProductsQuantityAndMoney(bean, customerIds);
                Map<Long,Map<String,Double>> mapCustomerTypeQuantity = (Map<Long, Map<String, Double>>) objArr[0];
                Map<Long,Double> mapCustomerMoney = (Map<Long,Double>) objArr[1];
                Map<Long,Timestamp> mapCustomerTime = getCustomerTime(customerIds, bean.getFromDate());
                Map<Long,Double> mapCustomerOwe = getCustomerInitialOwe(customerIds, bean.getFromDate());
                Map<Long,Double> mapCustomerPaid = getCustomerPaid(customerIds, bean.getFromDate(), bean.getToDate());
                for(Customer customer : customers){
                    SellSummaryDTO sellSummaryDTO = new SellSummaryDTO();
                    sellSummaryDTO.setCustomerName(customer.getName());
                    sellSummaryDTO.setProvince(customer.getProvince() != null ? customer.getProvince().getName() : "");
                    sellSummaryDTO.setToDate(mapCustomerTime.get(customer.getCustomerID()));
                    sellSummaryDTO.setInitialOwe(mapCustomerOwe.get(customer.getCustomerID()));
                    sellSummaryDTO.setKem(mapCustomerTypeQuantity.get(customer.getCustomerID()) != null ? mapCustomerTypeQuantity.get(customer.getCustomerID()).get(Constants.PRODUCT_KEM) : null);
                    sellSummaryDTO.setLanh(mapCustomerTypeQuantity.get(customer.getCustomerID()) != null ? mapCustomerTypeQuantity.get(customer.getCustomerID()).get(Constants.PRODUCT_LANH) : null);
                    sellSummaryDTO.setMau(mapCustomerTypeQuantity.get(customer.getCustomerID()) != null ? mapCustomerTypeQuantity.get(customer.getCustomerID()).get(Constants.PRODUCT_MAU) : null);
                    sellSummaryDTO.setTotalMoney(mapCustomerMoney.get(customer.getCustomerID()));
                    sellSummaryDTO.setPaid(mapCustomerPaid.get(customer.getCustomerID()));
                    results.add(sellSummaryDTO);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }
        return results;
    }


    private Map<Long, Double> getCustomerPaid(List<Long> customerIds, Date fromDate, Date toDate) {
        Map<Long,Double> customerPaidMap = new HashMap<Long, Double>();
        List<OweLog> customersPaid = this.oweLogDAO.findCustomerPaid(customerIds, fromDate, toDate);
        for(OweLog oweLog : customersPaid){
            Long customerId = oweLog.getCustomer().getCustomerID();
            if(!customerPaidMap.containsKey(customerId)){
                customerPaidMap.put(customerId, oweLog.getPay());
            }else {
                customerPaidMap.put(customerId, customerPaidMap.get(customerId) + oweLog.getPay());
            }
        }
        return customerPaidMap;
    }

    private Map<Long, Double> getCustomerInitialOwe(List<Long> customerIds, Date beforeDate) {
        List<Object> customersInitialOwe = this.oweLogDAO.findCustomerInitialOwe(customerIds, beforeDate);
        Map<Long,Double> mapCustomerInitialOwe = new HashMap<Long, Double>();
        for(Object customerInitialOwe : customersInitialOwe){
            Object[] tempArr = (Object[]) customerInitialOwe;
            Long customerID = ((BigInteger)tempArr[0]).longValue();
            Double owe = (Double) tempArr[1];
            String type = (String) tempArr[2];
            Double current = mapCustomerInitialOwe.get(customerID) != null ? mapCustomerInitialOwe.get(customerID) : 0d;
            if(type.equals(Constants.OWE_PLUS)){
                mapCustomerInitialOwe.put(customerID, current + owe);
            }else if (type.equals(Constants.OWE_MINUS)){
                mapCustomerInitialOwe.put(customerID, current - owe);
            }
        }
        return mapCustomerInitialOwe;
    }

    private Map<Long, Timestamp> getCustomerTime(List<Long> customerIds,Date beforeDate) {
        List<Object> customersLatestActivity = this.exportproductbillDAO.findCustomerLatestBoughtDate(customerIds, beforeDate);
        Map<Long,Timestamp> mapCustomerTime = new HashMap<Long, Timestamp>();
        for(Object customerLatestActivity : customersLatestActivity){
            Object[] tempArr = (Object[]) customerLatestActivity;
            Customer customer = (Customer) tempArr[0];
            Long customerID = customer.getCustomerID();
            Timestamp time = (Timestamp) tempArr[1];
            if(!mapCustomerTime.containsKey(customerID)){
                mapCustomerTime.put(customerID,time);
            }
        }
        return mapCustomerTime;
    }

    private Object[] getCustomerProductsQuantityAndMoney(ReportBean bean, List<Long> customerIds) {
        List<Object> soldProducts = this.importproductDAO.summarySellReport(bean, customerIds);
        Map<Long,Map<String,Double>> mapCustomerTypeQuantity = new HashMap<Long, Map<String, Double>>();
        Map<Long,Double> mapCustomerTotalMoney = new HashMap<Long, Double>();
        for(Object soldProduct : soldProducts){
            Object[] tempArr = (Object[]) soldProduct;
            Importproduct importproduct = (Importproduct) tempArr[0];
            Customer customer = (Customer) tempArr[1];
            Long customerID = customer.getCustomerID();
            Double quantity = importproduct.getQuantity2Pure();
            String code = importproduct.getProductname().getCode();
            Map<String,Double> mapTypeQuantity = mapCustomerTypeQuantity.get(customerID);
            if(mapTypeQuantity != null){
                if(code.endsWith(Constants.PRODUCT_MAU)){
                    Double currentQuantity = mapTypeQuantity.get(Constants.PRODUCT_MAU) != null ? mapTypeQuantity.get(Constants.PRODUCT_MAU) : 0d;
                    mapTypeQuantity.put(Constants.PRODUCT_MAU, currentQuantity + quantity);
                }else{
                    Double currentQuantity = mapTypeQuantity.get(code) != null ? mapTypeQuantity.get(code) : 0d;
                    mapTypeQuantity.put(code, currentQuantity + quantity);
                }
            }else{
                mapTypeQuantity = new HashMap<String, Double>();
                if(code.endsWith(Constants.PRODUCT_MAU)){
                    mapTypeQuantity.put(Constants.PRODUCT_MAU, quantity);
                }else{
                    mapTypeQuantity.put(code, quantity);
                }
            }
            mapCustomerTypeQuantity.put(customerID,mapTypeQuantity);
        }
        mapCustomerTotalMoney = getCustomerTotalBought(bean , customerIds);
        return new Object[]{mapCustomerTypeQuantity, mapCustomerTotalMoney};
    }

    private void getCustomerTotalMoney(Map<Long, Double> mapCustomerTotalMoney,Map<String,Double> mapProductPrice, Importproduct importproduct, Long customerID) {
        Double price;
        Double money;
        if(importproduct.getProductqualitys() != null){
            for(Productquality productquality : importproduct.getProductqualitys()){
                price = mapProductPrice.get(buildProductKey(importproduct, productquality.getQuality().getName())) != null ? mapProductPrice.get(buildProductKey(importproduct, productquality.getQuality().getName())) : 0d;
                money = productquality.getQuantity1() != null ? productquality.getQuantity1() * price : 0d;
                if(!mapCustomerTotalMoney.containsKey(customerID)){
                    mapCustomerTotalMoney.put(customerID, money);
                }else {
                    mapCustomerTotalMoney.put(customerID, mapCustomerTotalMoney.get(customerID) + money);
                }
            }
        }else {
            price = mapProductPrice.get(buildProductKey(importproduct, Constants.QUALITY_A)) != null ? mapProductPrice.get(buildProductKey(importproduct, Constants.QUALITY_A)) : 0d;
            money = importproduct.getQuantity1() != null ? importproduct.getQuantity1() * price : 0d;
            if(!mapCustomerTotalMoney.containsKey(customerID)){
                mapCustomerTotalMoney.put(customerID, money);
            }else {
                mapCustomerTotalMoney.put(customerID, mapCustomerTotalMoney.get(customerID) + money);
            }
        }
    }

    private String buildProductKey(Importproduct importproduct, String quality){
        StringBuffer keyBuffer = new StringBuffer();
        keyBuffer.append(importproduct.getProductname().getCode());
        keyBuffer.append("_").append(importproduct.getSize() != null ? importproduct.getSize().getName() : "");
        keyBuffer.append("_").append(importproduct.getThickness() != null ? importproduct.getThickness().getName() : "");
        keyBuffer.append("_").append(importproduct.getColour() != null ? importproduct.getColour().getName() : "");
        keyBuffer.append("_").append(quality);
        return keyBuffer.toString();
    }


    @Override
    public List<SummaryLiabilityDTO> summaryLiability(ReportBean bean) {
        List<SummaryLiabilityDTO> results = new ArrayList<SummaryLiabilityDTO>();
        try {
            List<Customer> customers = this.customerDAO.find4Report(bean);
            if(customers != null && customers.size() > 0){
                List<Long> customerIds = new ArrayList<Long>();
                for(Customer customer : customers){
                    customerIds.add(customer.getCustomerID());
                }
                initBean4LiabilityReport(bean);
                Map<Long,Double> customerBoughtMap = getCustomerTotalBought(bean, customerIds);
                Map<Long,Timestamp> mapCustomerTime = getCustomerTime(customerIds, bean.getToDate());
                Map<Long,Timestamp> mapCustomerDueDate = getCustomerDueDate(customerIds, bean.getToDate());
                Map<Long,Double> mapCustomerOwe = getCustomerInitialOwe(customerIds, bean.getFromDate());
                Map<Long,Double> mapCustomerPaid = getCustomerPaid(customerIds, bean.getFromDate(), bean.getToDate());
                for(Customer customer : customers){
                    SummaryLiabilityDTO summaryLiabilityDTO = new SummaryLiabilityDTO();
                    summaryLiabilityDTO.setCustomerName(customer.getName());
                    summaryLiabilityDTO.setProvince(customer.getProvince() != null ? customer.getProvince().getName() : "");
                    summaryLiabilityDTO.setArisingDate(mapCustomerTime.get(customer.getCustomerID()));
                    summaryLiabilityDTO.setDueDate(mapCustomerDueDate.get(customer.getCustomerID())); // @TODO what is this? it is book date
                    summaryLiabilityDTO.setInitialOwe(mapCustomerOwe.get(customer.getCustomerID()));
                    summaryLiabilityDTO.setBought(customerBoughtMap.get(customer.getCustomerID()));
                    summaryLiabilityDTO.setPaid(mapCustomerPaid.get(customer.getCustomerID()));
                    results.add(summaryLiabilityDTO);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }
        return results;
    }

    @Override
    public List<Importproduct> findByCodes(List<String> productCodes) {
        return this.importproductDAO.findByCodes(productCodes);
    }


    private Map<Long, Timestamp> getCustomerDueDate(List<Long> customerIds, Date toDate) {
        Map<Long, Timestamp> mapCustomerDueDate = new HashMap<Long, Timestamp>();
        List<Object> customersDueDate = this.oweLogDAO.findCustomerDueDate(customerIds, toDate);
        for(Object customerDueDate : customersDueDate){
            Object[] tempArr = (Object[]) customerDueDate;
            Long customerId = ((BigInteger)tempArr[0]).longValue();
            Timestamp dueDate = (Timestamp) tempArr[1];
            if(dueDate != null){
                if(!mapCustomerDueDate.containsKey(customerId)){
                    mapCustomerDueDate.put(customerId, dueDate);
                }else if(mapCustomerDueDate.get(customerId).before(dueDate)){
                    mapCustomerDueDate.put(customerId,dueDate);
                }
            }
        }
        return mapCustomerDueDate;
    }

    private void initBean4LiabilityReport(ReportBean bean) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(bean.getToDate());
        bean.setYear(calendar.get(Calendar.YEAR));
        calendar.set(Calendar.MONTH, Calendar.JANUARY);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        bean.setFromDate(calendar.getTime());
        bean.setLastYear(new Date(bean.getFromDate().getTime() - Constants.A_DAY));
    }

    private Map<Long, Double> getCustomerTotalBought(ReportBean bean, List<Long> customerIds) {
        Map<Long,Double> mapCustomerBought = new HashMap<Long, Double>();
        List<OweLog> customersMoneyBought = this.oweLogDAO.findCustomerMoneyBought(customerIds, bean.getFromDate(), bean.getToDate());
        for(OweLog customerBought : customersMoneyBought){
            Long customerId = customerBought.getCustomer().getCustomerID();
            if(!mapCustomerBought.containsKey(customerId)){
                mapCustomerBought.put(customerId, customerBought.getPay());
            }else {
                mapCustomerBought.put(customerId, mapCustomerBought.get(customerId) + customerBought.getPay());
            }
        }
        return mapCustomerBought;
    }


    @Override
    public List<ProductInOutDTO> summaryProductInOut(ProductGeneralBean bean) {
        List<ProductInOutDTO> results = new ArrayList<ProductInOutDTO>();
        Date fromDate = bean.getFromDate();
        Date toDate = bean.getToDate();
        InitProduct initProduct = this.initProductDAO.findByDateAndWarehouse(fromDate,bean.getWarehouseID());
        Importproduct sampleProduct;
        String specificName = "";
        if(initProduct != null){
            List<Importproduct> tempInitProducts = this.initProductDAO.findByBillAndName(initProduct.getInitProductID(), bean.getProductNameID());
            List<Importproduct> tempInProducts = importproductDAO.findImportedProduct(initProduct.getInitDate(), fromDate, bean.getProductNameID(), bean.getWarehouseID());
            List<Importproduct> tempOutProducts = importproductDAO.findExportedProduct(initProduct.getInitDate(), fromDate, bean.getProductNameID(), bean.getWarehouseID());

            List<Importproduct> initProducts = calcInitProducts(tempInitProducts, tempInProducts,tempOutProducts );
            List<Importproduct> inProducts = importproductDAO.findImportedProduct(fromDate, toDate, bean.getProductNameID(), bean.getWarehouseID());
            List<Importproduct> inInternalProducts = importproductDAO.findInternalImportedProduct(fromDate, toDate, bean.getProductNameID(), bean.getWarehouseID());
            inProducts.addAll(inInternalProducts);
            for(Importproduct importproduct : inInternalProducts){
                if(!inProducts.contains(importproduct)){
                    inProducts.add(importproduct);
                }
            }
            List<Importproduct> outProducts = importproductDAO.findExportedProduct(fromDate, toDate, bean.getProductNameID(), bean.getWarehouseID());

            sampleProduct = tempInitProducts.size() > 0 ? tempInitProducts.get(0) : tempInProducts.size() > 0 ? tempInProducts.get(0) : tempOutProducts.size() > 0 ? tempOutProducts.get(0) : null;
            if(sampleProduct != null){
                if(sampleProduct.getColour() == null && sampleProduct.getStiffness() == null && sampleProduct.getThickness() == null){
                    List<Long> sizeIds = new ArrayList<Long>();
                    Map<Long,ProductInOutDetailDTO> mapInitSizeProducts = mappingSizeProduct(initProducts, sizeIds);
                    Map<Long,ProductInOutDetailDTO> mapInSizeProducts = mappingSizeProduct(inProducts, sizeIds);
                    Map<Long,ProductInOutDetailDTO> mapOutSizeProducts = mappingSizeProduct(outProducts, sizeIds);
                    List<Size> sizes = sizeDAO.findByIds(sizeIds);

                    ProductInOutDTO productInOutDTO = new ProductInOutDTO();

                    productInOutDTO.setMapInitSizeProducts(mapInitSizeProducts);
                    productInOutDTO.setMapInSizeProducts(mapInSizeProducts);
                    productInOutDTO.setMapOutSizeProducts(mapOutSizeProducts);
                    productInOutDTO.setSizes(sizes);
                    productInOutDTO.setSpecificName(sampleProduct.getProductname().getName());

                    results.add(productInOutDTO);
                }else{
                    Boolean isColor = sampleProduct.getColour() != null;
                    List<Long> specificIds = new ArrayList<Long>();
                    Map<Long,List<Importproduct>> mapInitSpecificProducts = mappingSpecificProduct(initProducts, specificIds, isColor);
                    Map<Long,List<Importproduct>> mapInSpecificProducts = mappingSpecificProduct(inProducts, specificIds, isColor);
                    Map<Long,List<Importproduct>> mapOutSpecificProducts = mappingSpecificProduct(outProducts, specificIds, isColor);
                    Importproduct sampleSpecificProduct = null;
                    for(Long specificKey : specificIds){
                        if(mapInitSpecificProducts.get(specificKey) != null && mapInitSpecificProducts.get(specificKey).size() > 0){
                            sampleSpecificProduct = mapInitSpecificProducts.get(specificKey).get(0);
                        }else if(mapInSpecificProducts.get(specificKey) != null && mapInSpecificProducts.get(specificKey).size() > 0){
                            sampleSpecificProduct = mapInSpecificProducts.get(specificKey).get(0);
                        }else if(mapOutSpecificProducts.get(specificKey) != null && mapOutSpecificProducts.get(specificKey).size() > 0){
                            sampleSpecificProduct = mapOutSpecificProducts.get(specificKey).get(0);
                        }
                        List<Long> sizeIds = new ArrayList<Long>();
                        Map<Long,ProductInOutDetailDTO> mapInitSizeProducts = mappingSizeProduct(mapInitSpecificProducts.get(specificKey), sizeIds);
                        Map<Long,ProductInOutDetailDTO> mapInSizeProducts = mappingSizeProduct(mapInSpecificProducts.get(specificKey), sizeIds);
                        Map<Long,ProductInOutDetailDTO> mapOutSizeProducts = mappingSizeProduct(mapOutSpecificProducts.get(specificKey), sizeIds);
                        List<Size> sizes = sizeDAO.findByIds(sizeIds);

                        ProductInOutDTO productInOutDTO = new ProductInOutDTO();
                        productInOutDTO.setMapInitSizeProducts(mapInitSizeProducts);
                        productInOutDTO.setMapInSizeProducts(mapInSizeProducts);
                        productInOutDTO.setMapOutSizeProducts(mapOutSizeProducts);
                        productInOutDTO.setSizes(sizes);
                        specificName = sampleSpecificProduct.getProductname().getName() + " - ";
                        if(isColor){
                            specificName += sampleSpecificProduct.getColour() != null ? sampleSpecificProduct.getColour().getName() + "(" + sampleSpecificProduct.getColour().getCode() + ")" : "Chưa phân loại";
                        }else{
                            specificName += sampleSpecificProduct.getMarket() != null ? sampleSpecificProduct.getMarket().getName() : "Chưa phân loại";
                        }
                        productInOutDTO.setSpecificName(specificName);

                        results.add(productInOutDTO);
                    }
                }
            }
        }
        return results;
    }

    private Map<Long, List<Importproduct>> mappingSpecificProduct(List<Importproduct> initProducts, List<Long> specificIds, Boolean isColor) {
        Map<Long,List<Importproduct>> mapSizeProductInOutDetailDTO = new HashMap<Long, List<Importproduct>>();
        Long key;
        for(Importproduct importproduct : initProducts){
            if(isColor){
                key = importproduct.getColour() != null ? importproduct.getColour().getColourID() : -1l;
            }else{
                key = importproduct.getMarket() != null ? importproduct.getMarket().getMarketID() : -1l;
            }
            List<Importproduct> importproducts = mapSizeProductInOutDetailDTO.get(key);
            if(importproducts != null){
                importproducts.add(importproduct);
            }else{
                importproducts = new ArrayList<Importproduct>();
                importproducts.add(importproduct);
                mapSizeProductInOutDetailDTO.put(key, importproducts);
            }
            if(!specificIds.contains(key)){
                specificIds.add(key);
            }
        }
        return mapSizeProductInOutDetailDTO;
    }

    private List<Importproduct> calcInitProducts(List<Importproduct> tempInitProducts, List<Importproduct> tempInProducts, List<Importproduct> tempOutProducts) {
        List<Importproduct> results = new ArrayList<Importproduct>();
        results.addAll(tempInitProducts);

        for(Importproduct importproduct : tempInProducts){
            if(!results.contains(importproduct)){
                results.add(importproduct);
            }
        }
        for(Importproduct importproduct : tempOutProducts){
            if(results.contains(importproduct)){
                results.remove(importproduct);
            }
        }
        return results;
    }

    private Map<Long, ProductInOutDetailDTO> mappingSizeProduct(List<Importproduct> initProducts, List<Long> sizeIds) {
        Map<Long,ProductInOutDetailDTO> mapSizeProductInOutDetailDTO = new HashMap<Long, ProductInOutDetailDTO>();
        Long key;
        Double met, kg;
        if(initProducts != null){
            for(Importproduct importproduct : initProducts){
                key = importproduct.getSize().getSizeID();
                met = importproduct.getQuantity1() != null ? importproduct.getQuantity1() : 0d;
                kg = importproduct.getQuantity2Pure() != null ? importproduct.getQuantity2Pure() : 0d;
                ProductInOutDetailDTO productInOutDetailDTO = mapSizeProductInOutDetailDTO.get(key);
                if(productInOutDetailDTO != null){
                    productInOutDetailDTO.setNoRoll(productInOutDetailDTO.getNoRoll() + 1);
                    productInOutDetailDTO.setMet(productInOutDetailDTO.getMet() + met);
                    productInOutDetailDTO.setKg(productInOutDetailDTO.getKg() + kg);
                    productInOutDetailDTO.getImportProducts().add(importproduct);
                }else{
                    productInOutDetailDTO = new ProductInOutDetailDTO();
                    productInOutDetailDTO.setNoRoll(1);
                    productInOutDetailDTO.setKg(kg);
                    productInOutDetailDTO.setMet(met);
                    productInOutDetailDTO.setSizeID(key);
                    List<Importproduct> importproducts = new ArrayList<Importproduct>();
                    importproducts.add(importproduct);
                    productInOutDetailDTO.setImportProducts(importproducts);
                    mapSizeProductInOutDetailDTO.put(key, productInOutDetailDTO);
                }
                if(!sizeIds.contains(key)){
                    sizeIds.add(key);
                }
            }
        }
        return mapSizeProductInOutDetailDTO;
    }
}