package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.ImportMaterialBillLog;
import com.banvien.tpk.core.dto.ImportMaterialBillLogBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface ImportMaterialBillLogService extends GenericService<ImportMaterialBillLog,Long> {

    void updateItem(ImportMaterialBillLogBean ImportMaterialBillLogBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ImportMaterialBillLogBean ImportMaterialBillLogBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ImportMaterialBillLogBean bean);
}