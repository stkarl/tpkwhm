package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.ExportProductBillLog;
import com.banvien.tpk.core.dto.ExportProductBillLogBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface ExportProductBillLogService extends GenericService<ExportProductBillLog,Long> {

    void updateItem(ExportProductBillLogBean ExportProductBillLogBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ExportProductBillLogBean ExportProductBillLogBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ExportProductBillLogBean bean);
}