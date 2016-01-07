package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ColourDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Colour;
import com.banvien.tpk.core.dto.ColourBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ColourServiceImpl extends GenericServiceImpl<Colour,Long>
                                                    implements ColourService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ColourDAO ColourDAO;

    public void setColourDAO(ColourDAO ColourDAO) {
        this.ColourDAO = ColourDAO;
    }

    @Override
	protected GenericDAO<Colour, Long> getGenericDAO() {
		return ColourDAO;
	}

    @Override
    public void updateItem(ColourBean colourBean) throws ObjectNotFoundException, DuplicateException {
        Colour dbItem = this.ColourDAO.findByIdNoAutoCommit(colourBean.getPojo().getColourID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Colour " + colourBean.getPojo().getColourID());

        Colour pojo = colourBean.getPojo();

        this.ColourDAO.detach(dbItem);
        this.ColourDAO.update(pojo);
    }

    @Override
    public void addNew(ColourBean colourBean) throws DuplicateException {
        Colour pojo = colourBean.getPojo();
        pojo = this.ColourDAO.save(pojo);
        colourBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                ColourDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ColourBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("code", bean.getPojo().getCode());
        }

        return this.ColourDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Colour> findAllByOrder(String name) {
        return this.ColourDAO.findAllByOrder(name);
    }
}