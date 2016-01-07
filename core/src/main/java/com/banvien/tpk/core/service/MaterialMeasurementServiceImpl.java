package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.MaterialMeasurementDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.domain.MaterialMeasurement;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.MaterialMeasurementBean;
import com.banvien.tpk.core.dto.MeasurementDTO;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MaterialMeasurementServiceImpl extends GenericServiceImpl<MaterialMeasurement,Long>
                                                    implements MaterialMeasurementService {

    protected final Log logger = LogFactory.getLog(getClass());

    private MaterialMeasurementDAO materialMeasurementDAO;

    public void setMaterialMeasurementDAO(MaterialMeasurementDAO materialMeasurementDAO) {
        this.materialMeasurementDAO = materialMeasurementDAO;
    }

    @Override
	protected GenericDAO<MaterialMeasurement, Long> getGenericDAO() {
		return materialMeasurementDAO;
	}

    @Override
    public void updateItem(MaterialMeasurementBean bean) throws ObjectNotFoundException, DuplicateException {
        MaterialMeasurement dbItem = this.materialMeasurementDAO.findByIdNoAutoCommit(bean.getPojo().getMaterialMeasurementID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found MaterialMeasurement " + bean.getPojo().getMaterialMeasurementID());
        Double value = bean.getPojo().getValue() != null && bean.getPojo().getValue() > 0 ? bean.getPojo().getValue() : 0d;
        if(value > 0){
            dbItem.setValue(value);
            dbItem.setNote(bean.getPojo().getNote());
            this.materialMeasurementDAO.update(dbItem);
        }
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                materialMeasurementDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public List<MaterialMeasurement> findPreviousMaterialValue(Long warehouseID) {
        List<MaterialMeasurement> materialMeasurements = this.materialMeasurementDAO.findLatestValue(warehouseID);
        return materialMeasurements;
    }

    @Override
    public Object[] search(MaterialMeasurementBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            properties.put("warehouse.warehouseID", SecurityUtils.getPrincipal().getWarehouseID());
        }

        if(bean.getPojo().getMaterial() != null && bean.getPojo().getMaterial().getMaterialID() != null && bean.getPojo().getMaterial().getMaterialID() > 0){
            properties.put("material.materialID", bean.getPojo().getMaterial().getMaterialID());
        }

        if(bean.getPojo().getWarehouse() != null && bean.getPojo().getWarehouse().getWarehouseID() != null && bean.getPojo().getWarehouse().getWarehouseID() > 0){
            properties.put("warehouse.warehouseID", bean.getPojo().getWarehouse().getWarehouseID());
        }

        if(bean.getFromDate() != null){
            whereClause.append(" AND date >= '").append(bean.getFromDate()).append("'");
        }
        if(bean.getToDate() != null){
            whereClause.append(" AND date <= '").append(bean.getToDate()).append("'");
        }
        if(bean.getSortExpression() == null){
            bean.setSortExpression("date");
        }
        if(bean.getSortDirection() == null){
            bean.setSortDirection("1");
        }
        return this.materialMeasurementDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }


    @Override
    public void addNew (MaterialMeasurementBean bean) throws DuplicateException{
        if(bean.getMeasurements() != null && bean.getMeasurements().size() > 0){
            for(MeasurementDTO measurementDTO : bean.getMeasurements()){
                Long materialID = measurementDTO.getMaterialID() != null ? measurementDTO.getMaterialID() : null;
                Double value = measurementDTO.getValue() != null && measurementDTO.getValue() > 0 ? measurementDTO.getValue() : null;
                Timestamp date = measurementDTO.getDate() != null ? measurementDTO.getDate()  : null;
                if(materialID != null && value != null && date != null){
                    MaterialMeasurement materialMeasurement = new MaterialMeasurement();
                    Material material = new Material();
                    material.setMaterialID(materialID);
                    Warehouse warehouse = new Warehouse();
                    warehouse.setWarehouseID(bean.getWarehouseID());
                    User user = new User();
                    user.setUserID(bean.getLoginID());
                    materialMeasurement.setValue(value);
                    materialMeasurement.setMaterial(material);
                    materialMeasurement.setWarehouse(warehouse);
                    materialMeasurement.setCreatedBy(user);
                    materialMeasurement.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                    materialMeasurement.setDate(date);
                    materialMeasurement.setNote(measurementDTO.getNote());
                    this.materialMeasurementDAO.save(materialMeasurement);
                }

            }
        }
    }
}