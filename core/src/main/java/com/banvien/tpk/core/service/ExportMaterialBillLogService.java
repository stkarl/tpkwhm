package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.ExportMaterialBillLog;
import com.banvien.tpk.core.dto.ExportMaterialBillLogBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface ExportMaterialBillLogService extends GenericService<ExportMaterialBillLog,Long> {

    void updateItem(ExportMaterialBillLogBean ExportMaterialBillLogBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ExportMaterialBillLogBean ExportMaterialBillLogBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ExportMaterialBillLogBean bean);
}