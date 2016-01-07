package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.RegionDAO;
import com.banvien.tpk.core.dao.UserDAO;
import com.banvien.tpk.core.domain.Region;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.RegionBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RegionServiceImpl extends GenericServiceImpl<Region,Long> 
                                                    implements RegionService {

    protected final Log logger = LogFactory.getLog(getClass());

    private RegionDAO regionDAO;

    private UserDAO userDAO;

    public UserDAO getUserDAO() {
        return userDAO;
    }

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public void setRegionDAO(RegionDAO regionDAO) {
        this.regionDAO = regionDAO;
    }

    @Override
	protected GenericDAO<Region, Long> getGenericDAO() {
		return regionDAO;
	}

    @Override
    public void updateItem(RegionBean regionBean) throws ObjectNotFoundException, DuplicateException {
        Region dbItem = this.regionDAO.findByIdNoAutoCommit(regionBean.getPojo().getRegionID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found region " + regionBean.getPojo().getRegionID());

        Region pojo = regionBean.getPojo();

        this.regionDAO.detach(dbItem);
        this.regionDAO.update(pojo);
    }

    @Override
    public void addNew(RegionBean regionBean) throws DuplicateException {
        Region pojo = regionBean.getPojo();
        pojo = this.regionDAO.save(pojo);
        regionBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                regionDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(RegionBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        return this.regionDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

	@Override
	public List<Region> findAllSortAsc() {
        StringBuffer whereClause = new StringBuffer();
		return this.regionDAO.findByProperties(new HashMap<String, Object>(), "id", Constants.SORT_ASC, true, whereClause.toString());
	}


}