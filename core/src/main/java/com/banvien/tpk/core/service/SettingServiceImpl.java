package com.banvien.tpk.core.service;
import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.SettingDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Setting;
import com.banvien.tpk.core.dto.SettingBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SettingServiceImpl extends GenericServiceImpl<Setting,Long>
                                                    implements SettingService {

    protected final Log logger = LogFactory.getLog(getClass());

    private SettingDAO settingDAO;

    public void setSettingDAO(SettingDAO settingDAO) {
        this.settingDAO = settingDAO;
    }

    @Override
	protected GenericDAO<Setting, Long> getGenericDAO() {
		return settingDAO;
	}
    
    @Override
    public void updateItem(SettingBean settingBean) throws ObjectNotFoundException, DuplicateException {
        Setting dbItem = this.settingDAO.findByIdNoAutoCommit(settingBean.getPojo().getSettingID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found setting " + settingBean.getPojo().getSettingID());

        Setting pojo = settingBean.getPojo();

        this.settingDAO.detach(dbItem);
        this.settingDAO.update(pojo);
    }

    @Override
    public void addNew(SettingBean settingBean) throws DuplicateException {
        Setting pojo = settingBean.getPojo();
        pojo = this.settingDAO.save(pojo);
        settingBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                settingDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(SettingBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getFieldName())) {
            properties.put("fieldName", bean.getPojo().getFieldName());
        }

        return this.settingDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public void saveOrUpdateAll(List<Setting> settings) throws ObjectNotFoundException, DuplicateException {
        for (Setting setting : settings) {
            this.saveOrUpdate(setting);
        }
    }

    @Override
    public List<Setting> findSetting4WithPrefix(String prefix) {
        return this.settingDAO.findItemsWithPrefix(prefix);
    }

    @Override
    public Setting findByFieldName(String fieldName) throws ObjectNotFoundException{
        Map<String, Object> properties = new HashMap<String, Object>();
        properties.put("fieldName", fieldName);
        List<Setting> settingList = settingDAO.findByProperties(properties, "id", Constants.SORT_ASC, true, null);
        if(settingList.isEmpty()) {
            throw new ObjectNotFoundException("NOT FOUND Setting " + fieldName);
        }
        return settingList.get(0);
    }
}