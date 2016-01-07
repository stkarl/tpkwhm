package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.ImportProductBillLog;
import com.banvien.tpk.core.dto.ImportProductBillLogBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface ImportProductBillLogService extends GenericService<ImportProductBillLog,Long> {

    void updateItem(ImportProductBillLogBean ImportProductBillLogBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ImportProductBillLogBean ImportProductBillLogBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ImportProductBillLogBean bean);
}