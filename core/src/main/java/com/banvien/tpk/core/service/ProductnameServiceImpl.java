package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ProductnameDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Productname;
import com.banvien.tpk.core.dto.ProductnameBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class ProductnameServiceImpl extends GenericServiceImpl<Productname,Long>
                                                    implements ProductnameService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ProductnameDAO ProductnameDAO;

    public void setProductnameDAO(ProductnameDAO ProductnameDAO) {
        this.ProductnameDAO = ProductnameDAO;
    }

    @Override
	protected GenericDAO<Productname, Long> getGenericDAO() {
		return ProductnameDAO;
	}

    @Override
    public void updateItem(ProductnameBean bean) throws ObjectNotFoundException, DuplicateException {
        Productname dbItem = this.ProductnameDAO.findByIdNoAutoCommit(bean.getPojo().getProductNameID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Productname " + bean.getPojo().getProductNameID());

        Productname pojo = bean.getPojo();

        this.ProductnameDAO.detach(dbItem);
        this.ProductnameDAO.update(pojo);
    }

    @Override
    public void addNew(ProductnameBean bean) throws DuplicateException {
        Productname pojo = bean.getPojo();
        pojo = this.ProductnameDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                ProductnameDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ProductnameBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("code", bean.getPojo().getCode());
        }

        return this.ProductnameDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}