package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.InitProduct;
import com.banvien.tpk.core.dto.ImportProductDataDTO;

import java.util.List;


public interface InitProductService extends GenericService<InitProduct,Long> {
    Object[] importInitProductData2DB(List<ImportProductDataDTO> importedDatas, Long userID) throws Exception;

}