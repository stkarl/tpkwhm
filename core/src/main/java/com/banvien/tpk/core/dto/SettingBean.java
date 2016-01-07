package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Setting;
import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

import java.util.ArrayList;
import java.util.List;

public class SettingBean extends AbstractBean<Setting>{

    private List<Setting> settings = LazyList.decorate(
            new ArrayList(),
            FactoryUtils.instantiateFactory(Setting.class));;
    public SettingBean() {
        this.pojo = new Setting();
    }

    public List<Setting> getSettings() {
        return settings;
    }

    public void setSettings(List<Setting> settings) {
        this.settings = settings;
    }
}
