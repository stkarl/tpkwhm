package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.QualityDAO;
import com.banvien.tpk.core.domain.Quality;
import com.banvien.tpk.core.dto.QualityBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QualityServiceImpl extends GenericServiceImpl<Quality,Long>
                                                    implements QualityService {

    protected final Log logger = LogFactory.getLog(getClass());

    private QualityDAO QualityDAO;

    public void setQualityDAO(QualityDAO QualityDAO) {
        this.QualityDAO = QualityDAO;
    }

    @Override
	protected GenericDAO<Quality, Long> getGenericDAO() {
		return QualityDAO;
	}

    @Override
    public void updateItem(QualityBean bean) throws ObjectNotFoundException, DuplicateException {
        Quality dbItem = this.QualityDAO.findByIdNoAutoCommit(bean.getPojo().getQualityID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Quality " + bean.getPojo().getQualityID());

        Quality pojo = bean.getPojo();

        this.QualityDAO.detach(dbItem);
        this.QualityDAO.update(pojo);
    }

    @Override
    public void addNew(QualityBean bean) throws DuplicateException {
        Quality pojo = bean.getPojo();
        pojo = this.QualityDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                QualityDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(QualityBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("code", bean.getPojo().getCode());
        }

        return this.QualityDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Quality> findNonePPByOrder(String order) {
        return this.QualityDAO.findNonePPByOrder(order);
    }
}