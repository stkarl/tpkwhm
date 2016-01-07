package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.SaleReason;

import java.util.List;

public interface SaleReasonDAO extends GenericDAO<SaleReason,Long> {

    List<SaleReason> findAllByOrder();
}