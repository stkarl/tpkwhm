package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.UnitDAO;
import com.banvien.tpk.core.domain.Unit;
import com.banvien.tpk.core.dto.UnitBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class UnitServiceImpl extends GenericServiceImpl<Unit,Long> 
                                                    implements UnitService {

    protected final Log logger = LogFactory.getLog(getClass());

    private UnitDAO unitDAO;

    public void setUnitDAO(UnitDAO unitDAO) {
        this.unitDAO = unitDAO;
    }

    @Override
	protected GenericDAO<Unit, Long> getGenericDAO() {
		return unitDAO;
	}

    @Override
    public void updateItem(UnitBean unitBean) throws ObjectNotFoundException, DuplicateException {
        Unit dbItem = this.unitDAO.findByIdNoAutoCommit(unitBean.getPojo().getUnitID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found unit " + unitBean.getPojo().getUnitID());

        Unit pojo = unitBean.getPojo();

        this.unitDAO.detach(dbItem);
        this.unitDAO.update(pojo);
    }

    @Override
    public void addNew(UnitBean unitBean) throws DuplicateException {
        Unit pojo = unitBean.getPojo();
        pojo = this.unitDAO.save(pojo);
        unitBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                unitDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(UnitBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        return this.unitDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}