package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Province;
import com.banvien.tpk.core.dto.ProvinceBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface ProvinceService extends GenericService<Province,Long> {

    void updateItem(ProvinceBean districtBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ProvinceBean districtBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ProvinceBean bean);

    List<Province> findByRegionID(Long regionID);

    List<Province> findAllByOnlineAgent();


}