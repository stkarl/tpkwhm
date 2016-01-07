package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Map;


/**
 * <p>Pojo mapping TABLE importproduct</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 *
 */
public class Importproduct implements Serializable {

    /**
     * Attribute importProductID.
     */
    private Long importProductID;

    /**
     * Attribute importproductbill
     */
    private Importproductbill importproductbill;

    /**
     * Attribute product
     */
    private Productname productname;

    /**
     * Attribute productCode.
     */
    private String productCode;

    /**
     * Attribute origin
     */
    private Origin origin;

    /**
     * Attribute produceDate.
     */
    private Timestamp produceDate;

    /**
     * Attribute mainUsedMaterialCode.
     */
    private String mainUsedMaterialCode;

    private Importproduct mainUsedMaterial;


    /**
     * Attribute note.
     */
    private String note;

    /**
     * Attribute unit
     */
    private Unit unit1;

    /**
     * Attribute quantity1.
     */
    private Double quantity1;

    /**
     * Attribute unit
     */
    private Unit unit2;

    /**
     * Attribute quantity2.
     */
    private Double quantity2; //TL gop
    private Double quantity2Pure;   //TL tinh
    private Double quantity2Actual;    // TL can thuc te

    /**
     * Attribute money.
     */
    private Double money;

    /**
     * Attribute market
     */
    private Market market;

    /**
     * List of Productquality
     */
    private List<Productquality> productqualitys = null;

    private Size size;

    private Thickness thickness;

    private Stiffness stiffness;

    private Colour colour;

    private Overlaytype overlaytype;

    private Timestamp importDate;

    private Integer status;

    private Warehouse warehouse;

    private String core;

    private String producedTeam;

    private Double cutOff;

    private Map<Long,Double> qualityQuantityMap;

    private WarehouseMap warehouseMap;

    private String detailInfo;

    private Double suggestedPrice;

    private User suggestedBy;

    private Timestamp suggestedDate;

    private Importproduct originalProduct;

    private Double importBack;

    private Double usedMet;

    private Timestamp soldDate;

    private String originalCode;

    private Double saleQuantity;

    private Double salePrice;

    private Customer soldFor;

    public Customer getSoldFor() {
        return soldFor;
    }

    public void setSoldFor(Customer soldFor) {
        this.soldFor = soldFor;
    }

    public Double getSaleQuantity() {
        return saleQuantity;
    }

    public void setSaleQuantity(Double saleQuantity) {
        this.saleQuantity = saleQuantity;
    }

    public Double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(Double salePrice) {
        this.salePrice = salePrice;
    }

    public String getOriginalCode() {
        return originalCode;
    }

    public void setOriginalCode(String originalCode) {
        this.originalCode = originalCode;
    }

    public Timestamp getSoldDate() {
        return soldDate;
    }

    public void setSoldDate(Timestamp soldDate) {
        this.soldDate = soldDate;
    }

    public Double getUsedMet() {
        return usedMet;
    }

    public void setUsedMet(Double usedMet) {
        this.usedMet = usedMet;
    }

    public Importproduct getOriginalProduct() {
        return originalProduct;
    }

    public void setOriginalProduct(Importproduct originalProduct) {
        this.originalProduct = originalProduct;
    }

    public Double getImportBack() {
        return importBack;
    }

    public void setImportBack(Double importBack) {
        this.importBack = importBack;
    }

    public Double getQuantity2Pure() {
        return quantity2Pure;
    }

    public void setQuantity2Pure(Double quantity2Pure) {
        this.quantity2Pure = quantity2Pure;
    }

    public Double getQuantity2Actual() {
        return quantity2Actual;
    }

    public void setQuantity2Actual(Double quantity2Actual) {
        this.quantity2Actual = quantity2Actual;
    }

    public User getSuggestedBy() {
        return suggestedBy;
    }

    public void setSuggestedBy(User suggestedBy) {
        this.suggestedBy = suggestedBy;
    }

    public Timestamp getSuggestedDate() {
        return suggestedDate;
    }

    public void setSuggestedDate(Timestamp suggestedDate) {
        this.suggestedDate = suggestedDate;
    }

    public Double getSuggestedPrice() {
        return suggestedPrice;
    }

    public void setSuggestedPrice(Double suggestedPrice) {
        this.suggestedPrice = suggestedPrice;
    }

    public String getDetailInfo() {
        return detailInfo;
    }

    public void setDetailInfo(String detailInfo) {
        this.detailInfo = detailInfo;
    }

    public WarehouseMap getWarehouseMap() {
        return warehouseMap;
    }

    public void setWarehouseMap(WarehouseMap warehouseMap) {
        this.warehouseMap = warehouseMap;
    }

    public Map<Long, Double> getQualityQuantityMap() {
        return qualityQuantityMap;
    }

    public void setQualityQuantityMap(Map<Long, Double> qualityQuantityMap) {
        this.qualityQuantityMap = qualityQuantityMap;
    }

    public Double getCutOff() {
        return cutOff;
    }

    public void setCutOff(Double cutOff) {
        this.cutOff = cutOff;
    }

    public String getCore() {
        return core;
    }

    public void setCore(String core) {
        this.core = core;
    }

    public String getProducedTeam() {
        return producedTeam;
    }

    public void setProducedTeam(String producedTeam) {
        this.producedTeam = producedTeam;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Timestamp getImportDate() {
        return importDate;
    }

    public void setImportDate(Timestamp importDate) {
        this.importDate = importDate;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public Thickness getThickness() {
        return thickness;
    }

    public void setThickness(Thickness thickness) {
        this.thickness = thickness;
    }

    public Stiffness getStiffness() {
        return stiffness;
    }

    public void setStiffness(Stiffness stiffness) {
        this.stiffness = stiffness;
    }

    public Colour getColour() {
        return colour;
    }

    public void setColour(Colour colour) {
        this.colour = colour;
    }

    public Overlaytype getOverlaytype() {
        return overlaytype;
    }

    public void setOverlaytype(Overlaytype overlaytype) {
        this.overlaytype = overlaytype;
    }

    /**
     * <p>
     * </p>
     * @return importProductID
     */
    public Long getImportProductID() {
        return importProductID;
    }

    /**
     * @param importProductID new value for importProductID
     */
    public void setImportProductID(Long importProductID) {
        this.importProductID = importProductID;
    }

    /**
     * get importproductbill
     */
    public Importproductbill getImportproductbill() {
        return this.importproductbill;
    }

    /**
     * set importproductbill
     */
    public void setImportproductbill(Importproductbill importproductbill) {
        this.importproductbill = importproductbill;
    }

    public Productname getProductname() {
        return productname;
    }

    public void setProductname(Productname productname) {
        this.productname = productname;
    }

    /**
     * <p>
     * </p>
     * @return productCode
     */
    public String getProductCode() {
        return productCode;
    }

    /**
     * @param productCode new value for productCode
     */
    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    /**
     * get origin
     */
    public Origin getOrigin() {
        return this.origin;
    }

    /**
     * set origin
     */
    public void setOrigin(Origin origin) {
        this.origin = origin;
    }

    /**
     * <p>
     * </p>
     * @return produceDate
     */
    public Timestamp getProduceDate() {
        return produceDate;
    }

    /**
     * @param produceDate new value for produceDate
     */
    public void setProduceDate(Timestamp produceDate) {
        this.produceDate = produceDate;
    }

    /**
     * <p>
     * </p>
     * @return mainUsedMaterialCode
     */
    public String getMainUsedMaterialCode() {
        return mainUsedMaterialCode;
    }

    /**
     * @param mainUsedMaterialCode new value for mainUsedMaterialCode
     */
    public void setMainUsedMaterialCode(String mainUsedMaterialCode) {
        this.mainUsedMaterialCode = mainUsedMaterialCode;
    }

    public Importproduct getMainUsedMaterial() {
        return mainUsedMaterial;
    }

    public void setMainUsedMaterial(Importproduct mainUsedMaterial) {
        this.mainUsedMaterial = mainUsedMaterial;
    }

    /**
     * <p>
     * </p>
     * @return note
     */
    public String getNote() {
        return note;
    }

    /**
     * @param note new value for note
     */
    public void setNote(String note) {
        this.note = note;
    }

    /**
     * get unit
     */
    public Unit getUnit1() {
        return this.unit1;
    }

    /**
     * set unit
     */
    public void setUnit1(Unit unit1) {
        this.unit1 = unit1;
    }

    /**
     * <p>
     * </p>
     * @return quantity1
     */
    public Double getQuantity1() {
        return quantity1;
    }

    /**
     * @param quantity1 new value for quantity1
     */
    public void setQuantity1(Double quantity1) {
        this.quantity1 = quantity1;
    }

    /**
     * get unit
     */
    public Unit getUnit2() {
        return this.unit2;
    }

    /**
     * set unit
     */
    public void setUnit2(Unit unit2) {
        this.unit2 = unit2;
    }

    /**
     * <p>
     * </p>
     * @return quantity2
     */
    public Double getQuantity2() {
        return quantity2;
    }

    /**
     * @param quantity2 new value for quantity2
     */
    public void setQuantity2(Double quantity2) {
        this.quantity2 = quantity2;
    }

    /**
     * <p>
     * </p>
     * @return money
     */
    public Double getMoney() {
        return money;
    }

    /**
     * @param money new value for money
     */
    public void setMoney(Double money) {
        this.money = money;
    }

    /**
     * get market
     */
    public Market getMarket() {
        return this.market;
    }

    /**
     * set market
     */
    public void setMarket(Market market) {
        this.market = market;
    }

    /**
     * Get the list of Productquality
     */
    public List<Productquality> getProductqualitys() {
        return this.productqualitys;
    }

    /**
     * Set the list of Productquality
     */
    public void setProductqualitys(List<Productquality> productqualitys) {
        this.productqualitys = productqualitys;
    }


}