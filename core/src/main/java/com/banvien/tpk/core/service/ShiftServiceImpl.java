package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ShiftDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Shift;
import com.banvien.tpk.core.dto.ShiftBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class ShiftServiceImpl extends GenericServiceImpl<Shift,Long>
                                                    implements ShiftService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ShiftDAO ShiftDAO;

    public void setShiftDAO(ShiftDAO ShiftDAO) {
        this.ShiftDAO = ShiftDAO;
    }

    @Override
	protected GenericDAO<Shift, Long> getGenericDAO() {
		return ShiftDAO;
	}

    @Override
    public void updateItem(ShiftBean colourBean) throws ObjectNotFoundException, DuplicateException {
        Shift dbItem = this.ShiftDAO.findByIdNoAutoCommit(colourBean.getPojo().getShiftID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Shift " + colourBean.getPojo().getShiftID());

        Shift pojo = colourBean.getPojo();

        this.ShiftDAO.detach(dbItem);
        this.ShiftDAO.update(pojo);
    }

    @Override
    public void addNew(ShiftBean colourBean) throws DuplicateException {
        Shift pojo = colourBean.getPojo();
        pojo = this.ShiftDAO.save(pojo);
        colourBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                ShiftDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ShiftBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }
        return this.ShiftDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}