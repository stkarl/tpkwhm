package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.BuyContract;
import com.banvien.tpk.core.dto.BuyContractBean;
import com.banvien.tpk.core.dto.BuyContractDTO;
import com.banvien.tpk.core.dto.ReportByContractBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface BuyContractService extends GenericService<BuyContract,Long> {

    void updateItem(BuyContractBean buyContractBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(BuyContractBean buyContractBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(BuyContractBean bean);

    List<BuyContractDTO> reportImportByContract(ReportByContractBean bean);
}