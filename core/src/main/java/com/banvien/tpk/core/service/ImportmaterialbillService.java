package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Importmaterialbill;
import com.banvien.tpk.core.dto.ImportmaterialbillBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface ImportmaterialbillService extends GenericService<Importmaterialbill,Long> {

    void updateItem(ImportmaterialbillBean ImportmaterialbillBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ImportmaterialbillBean ImportmaterialbillBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ImportmaterialbillBean bean);

    void updateReject(String note, Long billID, Long userID);

    void updateConfirm(ImportmaterialbillBean bean) throws ObjectNotFoundException;

    String getLatestPNKPL();

    void updateConfirmMoney(ImportmaterialbillBean bean) throws ObjectNotFoundException;

    List<Importmaterialbill> findAllByOrderAndDateLimit(String importDate, Long date);
}