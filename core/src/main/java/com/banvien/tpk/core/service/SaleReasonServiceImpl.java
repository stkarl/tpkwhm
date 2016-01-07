package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.SaleReasonDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.SaleReason;
import com.banvien.tpk.core.dto.SaleReasonBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SaleReasonServiceImpl extends GenericServiceImpl<SaleReason,Long>
                                                    implements SaleReasonService {

    protected final Log logger = LogFactory.getLog(getClass());

    private SaleReasonDAO SaleReasonDAO;

    public void setSaleReasonDAO(SaleReasonDAO SaleReasonDAO) {
        this.SaleReasonDAO = SaleReasonDAO;
    }

    @Override
	protected GenericDAO<SaleReason, Long> getGenericDAO() {
		return SaleReasonDAO;
	}

    @Override
    public void updateItem(SaleReasonBean SaleReasonBean) throws ObjectNotFoundException, DuplicateException {
        SaleReason dbItem = this.SaleReasonDAO.findByIdNoAutoCommit(SaleReasonBean.getPojo().getSaleReasonID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found SaleReason " + SaleReasonBean.getPojo().getSaleReasonID());

        SaleReason pojo = SaleReasonBean.getPojo();

        this.SaleReasonDAO.detach(dbItem);
        this.SaleReasonDAO.update(pojo);
    }

    @Override
    public void addNew(SaleReasonBean SaleReasonBean) throws DuplicateException {
        SaleReason pojo = SaleReasonBean.getPojo();
        pojo = this.SaleReasonDAO.save(pojo);
        SaleReasonBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                SaleReasonDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(SaleReasonBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getReason())) {
            properties.put("reason", bean.getPojo().getReason());
        }
        return this.SaleReasonDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<SaleReason> findAllByOrder() {
        return this.SaleReasonDAO.findAllByOrder();
    }
}