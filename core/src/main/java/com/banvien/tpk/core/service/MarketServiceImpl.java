package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.MarketDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Market;
import com.banvien.tpk.core.dto.MarketBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class MarketServiceImpl extends GenericServiceImpl<Market,Long>
                                                    implements MarketService {

    protected final Log logger = LogFactory.getLog(getClass());

    private MarketDAO MarketDAO;

    public void setMarketDAO(MarketDAO MarketDAO) {
        this.MarketDAO = MarketDAO;
    }

    @Override
	protected GenericDAO<Market, Long> getGenericDAO() {
		return MarketDAO;
	}

    @Override
    public void updateItem(MarketBean bean) throws ObjectNotFoundException, DuplicateException {
        Market dbItem = this.MarketDAO.findByIdNoAutoCommit(bean.getPojo().getMarketID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Market " + bean.getPojo().getMarketID());

        Market pojo = bean.getPojo();

        this.MarketDAO.detach(dbItem);
        this.MarketDAO.update(pojo);
    }

    @Override
    public void addNew(MarketBean bean) throws DuplicateException {
        Market pojo = bean.getPojo();
        pojo = this.MarketDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                MarketDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(MarketBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("code", bean.getPojo().getCode());
        }

        return this.MarketDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}