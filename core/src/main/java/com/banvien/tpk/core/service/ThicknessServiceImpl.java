package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ThicknessDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Thickness;
import com.banvien.tpk.core.dto.ThicknessBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ThicknessServiceImpl extends GenericServiceImpl<Thickness,Long>
                                                    implements ThicknessService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ThicknessDAO ThicknessDAO;

    public void setThicknessDAO(ThicknessDAO ThicknessDAO) {
        this.ThicknessDAO = ThicknessDAO;
    }

    @Override
	protected GenericDAO<Thickness, Long> getGenericDAO() {
		return ThicknessDAO;
	}

    @Override
    public void updateItem(ThicknessBean bean) throws ObjectNotFoundException, DuplicateException {
        Thickness dbItem = this.ThicknessDAO.findByIdNoAutoCommit(bean.getPojo().getThicknessID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Thickness " + bean.getPojo().getThicknessID());

        Thickness pojo = bean.getPojo();

        this.ThicknessDAO.detach(dbItem);
        this.ThicknessDAO.update(pojo);
    }

    @Override
    public void addNew(ThicknessBean bean) throws DuplicateException {
        Thickness pojo = bean.getPojo();
        pojo = this.ThicknessDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                ThicknessDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ThicknessBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        return this.ThicknessDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Thickness> findAllByOrder(String order) {
        return this.ThicknessDAO.findAllByOrder(order);
    }
}