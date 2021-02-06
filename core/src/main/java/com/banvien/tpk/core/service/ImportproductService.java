package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.Date;
import java.util.List;
import java.util.Map;


public interface ImportproductService extends GenericService<Importproduct,Long> {

    void updateItem(ImportproductBean ImportproductBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ImportproductBean ImportproductBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);
    
    List<Importproduct> findAllSortAsc();

    Object[] search(ImportproductBean bean);

    List<Importproduct> findAvailableBlackProductByWarehouse(Long warehouseID);

    List<Importproduct> findTempSelectedBlackProductByWarehouseAndCodes(Long warehouseID, List<String> tempSelectedCodes);

    Object[] searchProductsInStock(SearchProductBean bean);

    List<ProducedProductDTO> reportProducedProduct(ProducedProductBean bean);

    List<Importproduct> findAvailableNoneBlackProductByWarehouse(Long warehouseID);

    Object[] importProductData2DB(List<ImportProductDataDTO> importedDatas,Long userID) throws Exception;

    void updateSuggestPrice(List<SuggestPriceDTO> suggestedItems, Long suggester);

    List<Importproduct> findWarningProduct(Long warehouseID);

    void updateProductLocation(List<SuggestPriceDTO> changingProducts,Long userID);

    List<Importproduct> summarySoldProducts(ReportBean bean);

    List<Importproduct> findImportByPlan(Long productionPlanID,String importType);

    List<SummaryByOverlayDTO> summaryByOverlay(ProducedProductBean bean) throws Exception;

    List<SummaryProductionDTO> summaryProducttion(ProducedProductBean bean);

    List<SellSummaryDTO> sellReport(ReportBean bean);

    List<SummaryLiabilityDTO> summaryLiability(ReportBean bean);

    List<Importproduct> findByCodes(List<String> productCodes);

    List<ProductInOutDTO> summaryProductInOut(ProductGeneralBean bean);

    List<CustomerActivityDTO> summaryCustomerActivity(ReportBean bean);

    Map<Long, Double> getCustomerInitialOwe(List<Long> customerIds, Date beforeDate);
}