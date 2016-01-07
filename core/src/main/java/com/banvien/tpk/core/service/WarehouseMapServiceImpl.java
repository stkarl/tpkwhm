package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.WarehouseMapDAO;
import com.banvien.tpk.core.domain.WarehouseMap;
import com.banvien.tpk.core.dto.WarehouseMapBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WarehouseMapServiceImpl extends GenericServiceImpl<WarehouseMap,Long>
                                                    implements WarehouseMapService {

    protected final Log logger = LogFactory.getLog(getClass());

    private WarehouseMapDAO warehouseMapDAO;

    public void setWarehouseMapDAO(WarehouseMapDAO warehouseMapDAO) {
        this.warehouseMapDAO = warehouseMapDAO;
    }

    @Override
	protected GenericDAO<WarehouseMap, Long> getGenericDAO() {
		return warehouseMapDAO;
	}

    @Override
    public void updateItem(WarehouseMapBean warehouseMapBean) throws ObjectNotFoundException, DuplicateException {
        WarehouseMap dbItem = this.warehouseMapDAO.findByIdNoAutoCommit(warehouseMapBean.getPojo().getWarehouseMapID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found warehouseMap " + warehouseMapBean.getPojo().getWarehouseMapID());

        WarehouseMap pojo = warehouseMapBean.getPojo();

        this.warehouseMapDAO.detach(dbItem);
        this.warehouseMapDAO.update(pojo);
    }

    @Override
    public void addNew(WarehouseMapBean warehouseMapBean) throws DuplicateException {
        WarehouseMap pojo = warehouseMapBean.getPojo();
        pojo = this.warehouseMapDAO.save(pojo);
        warehouseMapBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                    warehouseMapDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(WarehouseMapBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer();

        if(bean.getLoginWarehouseID() != null){
            properties.put("warehouse.warehouseID", bean.getLoginWarehouseID());
        }

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        if (StringUtils.isNotBlank(bean.getPojo().getCode())) {
            properties.put("code", bean.getPojo().getCode());
        }

        if (bean.getPojo().getWarehouse() != null && bean.getPojo().getWarehouse().getWarehouseID() != null && bean.getPojo().getWarehouse().getWarehouseID() > 0) {
            properties.put("warehouse.warehouseID", bean.getPojo().getWarehouse().getWarehouseID());
        }

        return this.warehouseMapDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public List<WarehouseMap> findByWarehouseID(Long warehouseID) {
        Map<String, Object> properties = new HashMap<String, Object>();
        properties.put("warehouse.warehouseID", warehouseID);
        return warehouseMapDAO.findByProperties(properties, "name", Constants.SORT_ASC, true, true);
    }

}