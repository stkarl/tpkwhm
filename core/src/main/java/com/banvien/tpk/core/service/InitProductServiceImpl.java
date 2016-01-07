package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.ImportproductDAO;
import com.banvien.tpk.core.dao.InitProductDAO;
import com.banvien.tpk.core.dao.InitProductDetailDAO;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.ImportProductDataDTO;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InitProductServiceImpl extends GenericServiceImpl<InitProduct,Long>
                                                    implements InitProductService {

    protected final Log logger = LogFactory.getLog(getClass());

    private InitProductDAO initProductDAO;

    private ImportproductDAO importproductDAO;

    public void setImportproductDAO(ImportproductDAO importproductDAO) {
        this.importproductDAO = importproductDAO;
    }

    public void setInitProductDAO(InitProductDAO initProductDAO) {
        this.initProductDAO = initProductDAO;
    }
    private InitProductDetailDAO initProductDetailDAO;

    public void setInitProductDetailDAO(InitProductDetailDAO initProductDetailDAO) {
        this.initProductDetailDAO = initProductDetailDAO;
    }

    @Override
	protected GenericDAO<InitProduct, Long> getGenericDAO() {
		return initProductDAO;
	}


    @Override
    public Object[] importInitProductData2DB(List<ImportProductDataDTO> importedDatas,Long userID) throws Exception{
        Warehouse warehouse = importedDatas.get(0).getWarehouse();
        User loginUser = new User();
        loginUser.setUserID(userID);

        Map<String,Importproduct> mapCodeProduct = mappingCodeProductInDB();

        InitProduct bill = new InitProduct();
        bill.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        bill.setWarehouse(warehouse);
        bill.setCreatedBy(loginUser);
        bill.setInitDate(importedDatas.get(0).getInitDate());
        bill = this.initProductDAO.save(bill);

        Integer totalImported = 0;
        StringBuilder failCode = new StringBuilder("");
        StringBuilder wrongStatusCode = new StringBuilder("");
        StringBuilder unTouchCode = new StringBuilder("");
        StringBuilder inPM = new StringBuilder("");

        for(ImportProductDataDTO dataDTO : importedDatas){
            if(dataDTO.isValid()){
                Importproduct importproduct = mapCodeProduct.get(dataDTO.getCode().toUpperCase().trim());
                if(importproduct != null){
                    InitProductDetail initProductDetail = new InitProductDetail();
                    initProductDetail.setInitProduct(bill);
                    initProductDetail.setImportProduct(importproduct);
                    initProductDetailDAO.save(initProductDetail);
                    totalImported++;
                }else{
                    if(StringUtils.isNotBlank(unTouchCode.toString())){
                        unTouchCode.append(", ").append(dataDTO.getCode());
                    }else{
                        unTouchCode.append(dataDTO.getCode());
                    }
                }
            }else{
                if(StringUtils.isNotBlank(failCode.toString())){
                    failCode.append(", ").append(dataDTO.getCode());
                }else{
                    failCode.append(dataDTO.getCode());
                }
            }
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

    private Map<String, Importproduct> mappingCodeProductInDB() {
        Map<String,Importproduct> result = new HashMap<String, Importproduct>();
        List<Importproduct> importproducts = this.importproductDAO.findByWarehouse(null);
        for(Importproduct importproduct : importproducts){
            result.put(importproduct.getProductCode().toUpperCase().trim(),importproduct);
        }
        return result;
    }
}