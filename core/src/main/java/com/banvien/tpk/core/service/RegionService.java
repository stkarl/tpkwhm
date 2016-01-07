package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Region;
import com.banvien.tpk.core.dto.RegionBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface RegionService extends GenericService<Region,Long> {

    void updateItem(RegionBean regionBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(RegionBean regionBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);
    
    List<Region> findAllSortAsc();

    Object[] search(RegionBean bean);
}