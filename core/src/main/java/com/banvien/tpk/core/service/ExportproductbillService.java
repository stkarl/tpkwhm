package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Exportproductbill;
import com.banvien.tpk.core.dto.ExportproductbillBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface ExportproductbillService extends GenericService<Exportproductbill,Long> {

    void updateExportRootMaterialBill(ExportproductbillBean ExportproductbillBean) throws ObjectNotFoundException, DuplicateException;

    void addExportRootMaterialBill(ExportproductbillBean ExportproductbillBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ExportproductbillBean bean);

    void updateReject(String note, Long exportProductBillID, Long loginUserId);

    void updateRejectTransfer(String note, Long exportProductBillID, Long loginUserId);

    void updateConfirm(ExportproductbillBean bean) throws ObjectNotFoundException;

    void updateConfirmTransfer(ExportproductbillBean bean) throws ObjectNotFoundException;

    String getLatestPXKTON();

    List<Exportproductbill> findAllByOrderAndDateLimit(String importDate, Boolean black, Long date);
}