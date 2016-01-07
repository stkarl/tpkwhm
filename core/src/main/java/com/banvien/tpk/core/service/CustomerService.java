package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Customer;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface CustomerService extends GenericService<Customer,Long> {

    Customer updateItem(CustomerBean CustomerBean) throws ObjectNotFoundException, DuplicateException;

    Customer addNew(CustomerBean CustomerBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(CustomerBean bean);

    List<Customer> findByUser(Long loginUserId);

    SummaryLiabilityDTO summaryLiability(ReportBean bean);

    void updateLiability(Long loginUserId, List<UpdateLiabilityDTO> updateLiabilities);

    void updateReceiveOwe(Long loginUserId, List<UpdateLiabilityDTO> updateLiabilities);

    Object[] importCustomerData2DB(List<ImportCustomerDataDTO> importedDatas) throws Exception;

    Object[] importCustomerOwe2DB(List<ImportCustomerOweDTO> importedDatas, Long loginUserId);
}