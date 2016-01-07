package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.OverlaytypeDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Overlaytype;
import com.banvien.tpk.core.dto.OverlaytypeBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class OverlaytypeServiceImpl extends GenericServiceImpl<Overlaytype,Long>
                                                    implements OverlaytypeService {

    protected final Log logger = LogFactory.getLog(getClass());

    private OverlaytypeDAO OverlaytypeDAO;

    public void setOverlaytypeDAO(OverlaytypeDAO OverlaytypeDAO) {
        this.OverlaytypeDAO = OverlaytypeDAO;
    }

    @Override
	protected GenericDAO<Overlaytype, Long> getGenericDAO() {
		return OverlaytypeDAO;
	}

    @Override
    public void updateItem(OverlaytypeBean bean) throws ObjectNotFoundException, DuplicateException {
        Overlaytype dbItem = this.OverlaytypeDAO.findByIdNoAutoCommit(bean.getPojo().getOverlayTypeID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Overlaytype " + bean.getPojo().getOverlayTypeID());

        Overlaytype pojo = bean.getPojo();

        this.OverlaytypeDAO.detach(dbItem);
        this.OverlaytypeDAO.update(pojo);
    }

    @Override
    public void addNew(OverlaytypeBean bean) throws DuplicateException {
        Overlaytype pojo = bean.getPojo();
        pojo = this.OverlaytypeDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                OverlaytypeDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(OverlaytypeBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("code", bean.getPojo().getCode());
        }

        return this.OverlaytypeDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}