package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.ProvinceDAO;
import com.banvien.tpk.core.domain.Province;
import com.banvien.tpk.core.dto.ProvinceBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProvinceServiceImpl extends GenericServiceImpl<Province,Long>
                                                    implements ProvinceService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ProvinceDAO provinceDAO;

    public void setProvinceDAO(ProvinceDAO provinceDAO) {
        this.provinceDAO = provinceDAO;
    }

    @Override
	protected GenericDAO<Province, Long> getGenericDAO() {
		return provinceDAO;
	}

    @Override
    public void updateItem(ProvinceBean provinceBean) throws ObjectNotFoundException, DuplicateException {
        Province dbItem = this.provinceDAO.findByIdNoAutoCommit(provinceBean.getPojo().getProvinceID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found province " + provinceBean.getPojo().getProvinceID());

        Province pojo = provinceBean.getPojo();

        this.provinceDAO.detach(dbItem);
        this.provinceDAO.update(pojo);
    }

    @Override
    public void addNew(ProvinceBean provinceBean) throws DuplicateException {
        Province pojo = provinceBean.getPojo();
        pojo = this.provinceDAO.save(pojo);
        provinceBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                    provinceDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ProvinceBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        if (bean.getPojo().getRegion() != null && bean.getPojo().getRegion().getRegionID() != null && bean.getPojo().getRegion().getRegionID() > 0) {
            properties.put("region.regionID", bean.getPojo().getRegion().getRegionID());
        }

        return this.provinceDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public List<Province> findByRegionID(Long regionID) {
        Map<String, Object> properties = new HashMap<String, Object>();
        properties.put("region.regionID", regionID);
        return provinceDAO.findByProperties(properties, "name", Constants.SORT_ASC, true, true);
    }

    @Override
    public List<Province> findAllByOnlineAgent() {
        StringBuffer whereClause = new StringBuffer();
        if (!SecurityUtils.userHasAuthority(Constants.ADMIN_ROLE)) {
            whereClause.append("region.regionID IN (SELECT region.regionID FROM Userregion WHERE user.userID = ").append(SecurityUtils.getLoginUserId()).append(")");
        }

        return provinceDAO.findByProperties(new HashMap<String, Object>(), "name", Constants.SORT_ASC, true, whereClause.toString());
    }

}