package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Setting;
import com.banvien.tpk.core.dto.SettingBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface SettingService extends GenericService<Setting,Long> {
    void updateItem(SettingBean regionBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(SettingBean regionBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(SettingBean bean);

    void saveOrUpdateAll(List<Setting> settings) throws ObjectNotFoundException, DuplicateException;

    List<Setting> findSetting4WithPrefix(String prefix);

    public Setting findByFieldName(String fieldName) throws ObjectNotFoundException;
}