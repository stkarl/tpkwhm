package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.ProductionPlanDAO;
import com.banvien.tpk.core.domain.ProductionPlan;
import com.banvien.tpk.core.dto.ProductionPlanBean;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductionPlanServiceImpl extends GenericServiceImpl<ProductionPlan,Long>
                                                    implements ProductionPlanService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ProductionPlanDAO productionPlanDAO;

    public void setProductionPlanDAO(ProductionPlanDAO productionPlanDAO) {
        this.productionPlanDAO = productionPlanDAO;
    }

    @Override
	protected GenericDAO<ProductionPlan, Long> getGenericDAO() {
		return productionPlanDAO;
	}

    @Override
    public void updateItem(ProductionPlanBean productionPlanBean) throws Exception {
        ProductionPlan dbItem = this.productionPlanDAO.findByIdNoAutoCommit(productionPlanBean.getPojo().getProductionPlanID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found productionPlan " + productionPlanBean.getPojo().getProductionPlanID());

        ProductionPlan pojo = productionPlanBean.getPojo();

        this.productionPlanDAO.detach(dbItem);
        this.productionPlanDAO.update(pojo);
    }

    @Override
    public void addNew(ProductionPlanBean productionPlanBean) throws Exception {
        ProductionPlan pojo = productionPlanBean.getPojo();
        pojo = this.productionPlanDAO.save(pojo);
        productionPlanBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                    productionPlanDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ProductionPlanBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        if(bean.getProduce()){
            whereClause.append(" AND production > 0 ");
        }
        if(bean.getFromDate() != null){
            whereClause.append(" AND DATE(date) >= '").append(bean.getFromDate().toString()).append("'");

        }
        if(bean.getToDate() != null){
            whereClause.append(" AND DATE(date) <= '").append(bean.getToDate().toString()).append("'");
        }

        if(bean.getLoginWarehouseID() != null){
            properties.put("warehouse.warehouseID", bean.getLoginWarehouseID());
        }

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        if (bean.getPojo().getWarehouse() != null && bean.getPojo().getWarehouse().getWarehouseID() != null && bean.getPojo().getWarehouse().getWarehouseID() > 0) {
            properties.put("warehouse.warehouseID", bean.getPojo().getWarehouse().getWarehouseID());
        }
        if(bean.getSortExpression() == null){
            bean.setSortExpression("date");
        }
        if(bean.getSortDirection() == null){
            bean.setSortDirection("1");
        }

        return this.productionPlanDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public List<ProductionPlan> findByWarehouseID(Long warehouseID) {
        Map<String, Object> properties = new HashMap<String, Object>();
        properties.put("warehouse.warehouseID", warehouseID);
        properties.put("status", Constants.TPK_USER_ACTIVE);
        return productionPlanDAO.findByProperties(properties, "name", Constants.SORT_ASC, true, true);
    }

    @Override
    public Object[] searchActivePlan(ProductionPlanBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1 ");
        properties.put("status", Constants.TPK_USER_ACTIVE);
        if(bean.getProduce()){
            whereClause.append(" AND production > 0 ");
        }else{
            properties.put("production", 0);
        }

        if(bean.getLoginWarehouseID() != null){
            properties.put("warehouse.warehouseID", bean.getLoginWarehouseID());
        }

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        if (bean.getPojo().getWarehouse() != null && bean.getPojo().getWarehouse().getWarehouseID() != null && bean.getPojo().getWarehouse().getWarehouseID() > 0) {
            properties.put("warehouse.warehouseID", bean.getPojo().getWarehouse().getWarehouseID());
        }

        if(bean.getSortExpression() == null &&  bean.getSortDirection() == null){
            bean.setSortExpression("date");
            bean.setSortDirection("1");
        }

        return this.productionPlanDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public List<ProductionPlan> findActivePlanByWarehouseAndType(Long warehouseID, String exportTypeCode) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1 ");
        if(warehouseID != null){
            properties.put("warehouse.warehouseID", warehouseID);
        }
        properties.put("status", Constants.TPK_USER_ACTIVE);
        if(exportTypeCode.equals(Constants.EXPORT_TYPE_SAN_XUAT)){
            whereClause.append(" AND production > 0 ");
        }else if(exportTypeCode.equals(Constants.EXPORT_TYPE_BTSC)){
            properties.put("production", 0);
        }
        return productionPlanDAO.findByProperties(properties, "name", Constants.SORT_ASC, true, whereClause.toString());
    }

    @Override
    public Map<Long, String> getProductionDetail(List<Long> planIds) {
        Map<Long, String> mapPlanNote = new HashMap<Long, String>();
        List<Object[]> objects = productionPlanDAO.getProductionDetail(planIds);
        for(Object[] objectArr : objects){
            Long totalProduced = (Long) objectArr[0];
            Long planId = (Long) objectArr[1];
            Integer status = (Integer) objectArr[2];
            String sStatus = status == Constants.CONFIRMED ? "Đã duyệt" : status == Constants.WAIT_CONFIRM ? "Chờ duyệt" : "Bị từ chối";
            mapPlanNote.put(planId, totalProduced + " - Tình trạng: " + sStatus);
        }
        return mapPlanNote;
    }
}