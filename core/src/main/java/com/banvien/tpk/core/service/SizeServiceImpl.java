package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.SizeDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Size;
import com.banvien.tpk.core.dto.SizeBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SizeServiceImpl extends GenericServiceImpl<Size,Long>
                                                    implements SizeService {

    protected final Log logger = LogFactory.getLog(getClass());

    private SizeDAO SizeDAO;

    public void setSizeDAO(SizeDAO SizeDAO) {
        this.SizeDAO = SizeDAO;
    }

    @Override
	protected GenericDAO<Size, Long> getGenericDAO() {
		return SizeDAO;
	}

    @Override
    public void updateItem(SizeBean bean) throws ObjectNotFoundException, DuplicateException {
        Size dbItem = this.SizeDAO.findByIdNoAutoCommit(bean.getPojo().getSizeID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Size " + bean.getPojo().getSizeID());

        Size pojo = bean.getPojo();

        this.SizeDAO.detach(dbItem);
        this.SizeDAO.update(pojo);
    }

    @Override
    public void addNew(SizeBean bean) throws DuplicateException {
        Size pojo = bean.getPojo();
        pojo = this.SizeDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                SizeDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(SizeBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        return this.SizeDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Size> findAllByOrder(String order) {
        Map<String, Object> properties = new HashMap<String, Object>();
        return this.SizeDAO.findAllByOrder(order);
    }
}