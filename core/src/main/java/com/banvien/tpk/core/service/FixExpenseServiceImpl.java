package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.FixExpenseDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.FixExpense;
import com.banvien.tpk.core.dto.FixExpenseBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FixExpenseServiceImpl extends GenericServiceImpl<FixExpense,Long>
                                                    implements FixExpenseService {

    protected final Log logger = LogFactory.getLog(getClass());

    private FixExpenseDAO fixExpenseDAO;

    public void setFixExpenseDAO(FixExpenseDAO fixExpenseDAO) {
        this.fixExpenseDAO = fixExpenseDAO;
    }

    @Override
	protected GenericDAO<FixExpense, Long> getGenericDAO() {
		return fixExpenseDAO;
	}

    @Override
    public void updateItem(FixExpenseBean colourBean) throws ObjectNotFoundException, DuplicateException {
        FixExpense dbItem = this.fixExpenseDAO.findByIdNoAutoCommit(colourBean.getPojo().getFixExpenseID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found FixExpense " + colourBean.getPojo().getFixExpenseID());

        FixExpense pojo = colourBean.getPojo();

        this.fixExpenseDAO.detach(dbItem);
        this.fixExpenseDAO.update(pojo);
    }

    @Override
    public void addNew(FixExpenseBean colourBean) throws DuplicateException {
        FixExpense pojo = colourBean.getPojo();
        pojo = this.fixExpenseDAO.save(pojo);
        colourBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                fixExpenseDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(FixExpenseBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        return this.fixExpenseDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<FixExpense> findAllByOrder(String name) {
        return this.fixExpenseDAO.findAllByOrder(name);
    }
}