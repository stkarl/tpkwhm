package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ProductDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Product;
import com.banvien.tpk.core.dto.ProductBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class ProductServiceImpl extends GenericServiceImpl<Product,Long>
                                                    implements ProductService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ProductDAO ProductDAO;

    public void setProductDAO(ProductDAO ProductDAO) {
        this.ProductDAO = ProductDAO;
    }

    @Override
	protected GenericDAO<Product, Long> getGenericDAO() {
		return ProductDAO;
	}

    @Override
    public void updateItem(ProductBean bean) throws ObjectNotFoundException, DuplicateException {
        Product dbItem = this.ProductDAO.findByIdNoAutoCommit(bean.getPojo().getProductID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Product " + bean.getPojo().getProductID());

        Product pojo = bean.getPojo();

        this.ProductDAO.detach(dbItem);
        this.ProductDAO.update(pojo);
    }

    @Override
    public void addNew(ProductBean bean) throws DuplicateException {
        Product pojo = bean.getPojo();
        pojo = this.ProductDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                ProductDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ProductBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        return this.ProductDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}