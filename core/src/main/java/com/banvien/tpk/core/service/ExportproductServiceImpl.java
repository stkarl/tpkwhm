package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.ExportproductDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.ImportproductDAO;
import com.banvien.tpk.core.domain.Exportproduct;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.dto.ExportproductBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExportproductServiceImpl extends GenericServiceImpl<Exportproduct,Long>
                                                    implements ExportproductService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ExportproductDAO exportproductDAO;

    public void setExportproductDAO(ExportproductDAO exportproductDAO) {
        this.exportproductDAO = exportproductDAO;
    }

    private ImportproductDAO importproductDAO;

    public void setImportproductDAO(ImportproductDAO importproductDAO) {
        this.importproductDAO = importproductDAO;
    }

    @Override
	protected GenericDAO<Exportproduct, Long> getGenericDAO() {
		return exportproductDAO;
	}

    @Override
    public void updateItem(ExportproductBean ExportproductBean) throws ObjectNotFoundException, DuplicateException {
        Exportproduct dbItem = this.exportproductDAO.findByIdNoAutoCommit(ExportproductBean.getPojo().getExportProductID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Exportproduct " + ExportproductBean.getPojo().getExportProductID());

        Exportproduct pojo = ExportproductBean.getPojo();

        this.exportproductDAO.detach(dbItem);
        this.exportproductDAO.update(pojo);
    }

    @Override
    public void addNew(ExportproductBean ExportproductBean) throws DuplicateException {
        Exportproduct pojo = ExportproductBean.getPojo();
        pojo = this.exportproductDAO.save(pojo);
        ExportproductBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                exportproductDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ExportproductBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        return this.exportproductDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Importproduct> findProductByProductionPlan(Long productionPlanID) {
        return this.exportproductDAO.findProductByProductionPlan(productionPlanID);
    }

    @Override
    public List<Importproduct> findExportByPlan(Long productionPlanID) {
        return this.exportproductDAO.findExportByPlan(productionPlanID);
    }

//    @Override
//    public List<Exportproduct> findAvailableBlackProductByWarehouse(Long warehouseID) {
//        return this.exportproductDAO.findAvailableBlackProductByWarehouse(warehouseID);
//    }
//
//    @Override
//    public List<Exportproduct> findTempSelectedBlackProductByWarehouseAndCodes(Long warehouseID, List<String> tempSelectedCodes) {
//        return this.exportproductDAO.findTempSelectedBlackProductByWarehouseAndCodes(warehouseID,tempSelectedCodes);
//    }
//
//    @Override
//    public Object[] searchProductsInStock(SearchProductBean bean) {
//        return this.exportproductDAO.searchProductsInStock(bean);
//    }

    @Override
	public List<Exportproduct> findAllSortAsc() {
        StringBuffer whereClause = new StringBuffer();
		return this.exportproductDAO.findByProperties(new HashMap<String, Object>(), "id", Constants.SORT_ASC, true, whereClause.toString());
	}


    @Override
    public Double findTotalExportBlackProduct4ProductionByDate(Date fromDate, Date toDate) {
        return this.exportproductDAO.findTotalExportBlackProduct4ProductionByDate(fromDate, toDate);
    }

    @Override
    public Boolean updateBringProductBack(Long productid, Long exportid) {
        Boolean checker = Boolean.FALSE;
        Importproduct importproduct = this.importproductDAO.findByIdNoAutoCommit(productid);
        if(importproduct.getStatus().equals(Constants.ROOT_MATERIAL_STATUS_WAIT_TO_USE)){
            importproduct.setStatus(Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
            this.importproductDAO.update(importproduct);
            exportproductDAO.delete(exportid);
            checker = Boolean.TRUE;
        }
        return checker;
    }


}