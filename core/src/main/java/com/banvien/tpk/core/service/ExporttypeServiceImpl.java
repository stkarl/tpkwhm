package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ExporttypeDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Exporttype;
import com.banvien.tpk.core.dto.ExporttypeBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExporttypeServiceImpl extends GenericServiceImpl<Exporttype,Long>
                                                    implements ExporttypeService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ExporttypeDAO ExporttypeDAO;

    public void setExporttypeDAO(ExporttypeDAO ExporttypeDAO) {
        this.ExporttypeDAO = ExporttypeDAO;
    }

    @Override
	protected GenericDAO<Exporttype, Long> getGenericDAO() {
		return ExporttypeDAO;
	}

    @Override
    public void updateItem(ExporttypeBean bean) throws ObjectNotFoundException, DuplicateException {
        Exporttype dbItem = this.ExporttypeDAO.findByIdNoAutoCommit(bean.getPojo().getExportTypeID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Exporttype " + bean.getPojo().getExportTypeID());

        Exporttype pojo = bean.getPojo();

        this.ExporttypeDAO.detach(dbItem);
        this.ExporttypeDAO.update(pojo);
    }

    @Override
    public void addNew(ExporttypeBean bean) throws DuplicateException {
        Exporttype pojo = bean.getPojo();
        pojo = this.ExporttypeDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                ExporttypeDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ExporttypeBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        return this.ExporttypeDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public Exporttype findByCode(String code) {
        return this.ExporttypeDAO.findEqualUnique("code",code);
    }

    @Override
    public List<Exporttype> findExcludeCode(String code) {
        return this.ExporttypeDAO.findExcludeCode(code);
    }
}