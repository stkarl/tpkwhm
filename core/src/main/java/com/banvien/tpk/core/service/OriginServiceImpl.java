package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.OriginDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Origin;
import com.banvien.tpk.core.dto.OriginBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class OriginServiceImpl extends GenericServiceImpl<Origin,Long>
                                                    implements OriginService {

    protected final Log logger = LogFactory.getLog(getClass());

    private OriginDAO OriginDAO;

    public void setOriginDAO(OriginDAO OriginDAO) {
        this.OriginDAO = OriginDAO;
    }

    @Override
	protected GenericDAO<Origin, Long> getGenericDAO() {
		return OriginDAO;
	}

    @Override
    public void updateItem(OriginBean bean) throws ObjectNotFoundException, DuplicateException {
        Origin dbItem = this.OriginDAO.findByIdNoAutoCommit(bean.getPojo().getOriginID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Origin " + bean.getPojo().getOriginID());

        Origin pojo = bean.getPojo();

        this.OriginDAO.detach(dbItem);
        this.OriginDAO.update(pojo);
    }

    @Override
    public void addNew(OriginBean bean) throws DuplicateException {
        Origin pojo = bean.getPojo();
        pojo = this.OriginDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                OriginDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(OriginBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        return this.OriginDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}