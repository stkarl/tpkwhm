package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.MaterialcategoryDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Materialcategory;
import com.banvien.tpk.core.dto.MaterialcategoryBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MaterialcategoryServiceImpl extends GenericServiceImpl<Materialcategory,Long>
                                                    implements MaterialcategoryService {

    protected final Log logger = LogFactory.getLog(getClass());

    private MaterialcategoryDAO MaterialcategoryDAO;

    public void setMaterialcategoryDAO(MaterialcategoryDAO MaterialcategoryDAO) {
        this.MaterialcategoryDAO = MaterialcategoryDAO;
    }

    @Override
	protected GenericDAO<Materialcategory, Long> getGenericDAO() {
		return MaterialcategoryDAO;
	}

    @Override
    public void updateItem(MaterialcategoryBean bean) throws ObjectNotFoundException, DuplicateException {
        Materialcategory dbItem = this.MaterialcategoryDAO.findByIdNoAutoCommit(bean.getPojo().getMaterialCategoryID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Materialcategory " + bean.getPojo().getMaterialCategoryID());

        Materialcategory pojo = bean.getPojo();

        this.MaterialcategoryDAO.detach(dbItem);
        this.MaterialcategoryDAO.update(pojo);
    }

    @Override
    public void addNew(MaterialcategoryBean bean) throws DuplicateException {
        Materialcategory pojo = bean.getPojo();
        pojo = this.MaterialcategoryDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                MaterialcategoryDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(MaterialcategoryBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("code", bean.getPojo().getName());
        }

        return this.MaterialcategoryDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Materialcategory> findAssignedCate(Long loginUserId) {
        return this.MaterialcategoryDAO.findAssignedCate(loginUserId);
    }
}