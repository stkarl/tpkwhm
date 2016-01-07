package com.banvien.tpk.webapp.util;

import com.banvien.tpk.core.context.AppContext;
import com.banvien.tpk.core.dao.WarehouseDAO;
import com.banvien.tpk.core.domain.Productname;
import com.banvien.tpk.core.domain.Setting;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.service.WarehouseService;
import com.banvien.tpk.core.util.CacheUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: viennh
 * Date: 8/29/13
 * Time: 12:44 AM
 * To change this template use File | Settings | File Templates.
 */
public class GlobalDataUtil {
    private static GlobalDataUtil instance = new GlobalDataUtil();
    private static Map<String, String> settingsMap = new HashMap<String, String>();
    public static GlobalDataUtil getInstance() {
        return instance;
    }

//    private static final String ALL_WAREHOUSES_CACHE_KEY = "ALL_WAREHOUSES_CACHE_KEY";

    private GlobalDataUtil() {

    }
    public String getSetting(String key) {
        String value = (String)settingsMap.get(key);
        return value;
    }

    public void addSettings(List<Setting> settings) {
        for (Setting setting : settings) {
            settingsMap.put(setting.getFieldName(), setting.getFieldValue());
        }
    }

//    public List<Warehouse> getAllWarehouse() throws ObjectNotFoundException {
//        List<Warehouse> allWarehouses = (List<Warehouse>) CacheUtil.getInstance().getValue(ALL_WAREHOUSES_CACHE_KEY);
//        if (allWarehouses == null) {
//            WarehouseService warehouseService = AppContext.getApplicationContext().getBean(WarehouseService.class);
//            allWarehouses = warehouseService.findAllActiveWarehouseExcludeID(null);
//            CacheUtil.getInstance().putValue(ALL_WAREHOUSES_CACHE_KEY, allWarehouses);
//        }
//        return allWarehouses;
//    }
}
