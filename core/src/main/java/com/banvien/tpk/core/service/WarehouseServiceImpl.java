package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.WarehouseDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Warehouse;
import com.banvien.tpk.core.dto.WarehouseBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WarehouseServiceImpl extends GenericServiceImpl<Warehouse,Long>
                                                    implements WarehouseService {

    protected final Log logger = LogFactory.getLog(getClass());

    private WarehouseDAO WarehouseDAO;

    public void setWarehouseDAO(WarehouseDAO WarehouseDAO) {
        this.WarehouseDAO = WarehouseDAO;
    }

    @Override
	protected GenericDAO<Warehouse, Long> getGenericDAO() {
		return WarehouseDAO;
	}

    @Override
    public void updateItem(WarehouseBean bean) throws ObjectNotFoundException, DuplicateException {
        Warehouse dbItem = this.WarehouseDAO.findByIdNoAutoCommit(bean.getPojo().getWarehouseID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Warehouse " + bean.getPojo().getWarehouseID());

        Warehouse pojo = bean.getPojo();

        this.WarehouseDAO.detach(dbItem);
        this.WarehouseDAO.update(pojo);
    }

    @Override
    public void addNew(WarehouseBean bean) throws DuplicateException {
        Warehouse pojo = bean.getPojo();
        pojo = this.WarehouseDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                WarehouseDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(WarehouseBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }
        if (bean.getPojo().getStatus() != null && bean.getPojo().getStatus() >= 0) {
            properties.put("status", bean.getPojo().getStatus());
        }

        return this.WarehouseDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Warehouse> findAllActiveWarehouseExcludeID(Long excludeID) {
        return this.WarehouseDAO.findAllActiveWarehouseExcludeID(excludeID);
    }

    @Override
    public List<Warehouse> findByStatus(Integer status) {
        return this.WarehouseDAO.findByStatus(status);
    }
}