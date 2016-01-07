package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Exportmaterialbill;
import com.banvien.tpk.core.dto.ExportMaterialReportBean;
import com.banvien.tpk.core.dto.ExportMaterialReportDTO;
import com.banvien.tpk.core.dto.ExportmaterialbillBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface ExportmaterialbillService extends GenericService<Exportmaterialbill,Long> {

    void updateItem(ExportmaterialbillBean ExportmaterialbillBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ExportmaterialbillBean ExportmaterialbillBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ExportmaterialbillBean bean);

    void updateReject(String note, Long exportMaterialBillID, Long loginUserId);

    void updateConfirm(ExportmaterialbillBean bean) throws ObjectNotFoundException;

    String getLatestPXKPL();

    ExportMaterialReportDTO reportExportMaterial(ExportMaterialReportBean bean);

    List<Exportmaterialbill> findAllByOrderAndDateLimit(String orderBy, Long date);
}