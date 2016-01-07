package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.dto.MaterialBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface MaterialService extends GenericService<Material,Long> {

    void updateItem(MaterialBean MaterialBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(MaterialBean MaterialBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] searchByBean(MaterialBean bean);

    List<Material> findByCateCode(String cateCode);

    List<Material> findNoneMeasurement();

    List<Material> findAssigned(Long userID);

}