package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.LocationHistoryDAO;
import com.banvien.tpk.core.domain.LocationHistory;
import com.banvien.tpk.core.dto.LocationHistoryBean;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class LocationHistoryServiceImpl extends GenericServiceImpl<LocationHistory,Long>
                                                    implements LocationHistoryService {

    protected final Log logger = LogFactory.getLog(getClass());

    private LocationHistoryDAO locationHistoryDAO;

    public void setLocationHistoryDAO(LocationHistoryDAO locationHistoryDAO) {
        this.locationHistoryDAO = locationHistoryDAO;
    }

    @Override
	protected GenericDAO<LocationHistory, Long> getGenericDAO() {
		return locationHistoryDAO;
	}
    
    @Override
    public Object[] search(LocationHistoryBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        StringBuffer whereClause = new StringBuffer(" 1 = 1");

        if(bean.getFromDate() != null){
            whereClause.append(" AND DATE(createdDate) >= '").append(bean.getFromDate().toString()).append("'");

        }
        if(bean.getToDate() != null){
            whereClause.append(" AND DATE(createdDate) <= '").append(bean.getToDate().toString()).append("'");
        }

        if(bean.getLoginWarehouseID() != null){
            properties.put("warehouse.warehouseID", bean.getLoginWarehouseID() );
        }

        if (bean.getOldLocationID() != null && bean.getOldLocationID() > 0) {
            properties.put("oldLocation.warehouseMapID", bean.getOldLocationID() );
        }

        if (bean.getNewLocationID() != null && bean.getNewLocationID() > 0) {
            properties.put("newLocation.warehouseMapID", bean.getNewLocationID() );
        }

        if (bean.getMaterialID() != null && bean.getMaterialID() > 0) {
            properties.put("importMaterial.material.materialID", bean.getMaterialID() );
        }

        if (bean.getProductID() != null && bean.getProductID() > 0) {
            properties.put("importProduct.productname.productNameID", bean.getProductID() );
        }

        return this.locationHistoryDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true,whereClause.toString());
    }
}