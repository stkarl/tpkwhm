package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.LocationHistory;
import com.banvien.tpk.core.dto.LocationHistoryBean;


public interface LocationHistoryService extends GenericService<LocationHistory,Long> {
    Object[] search(LocationHistoryBean bean);
}