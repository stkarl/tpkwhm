package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.ModuleDAO;
import com.banvien.tpk.core.domain.Module;
import com.banvien.tpk.core.dto.ModuleBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ModuleServiceImpl extends GenericServiceImpl<Module,Long>
                                                    implements ModuleService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ModuleDAO moduleDAO;

    public void setModuleDAO(ModuleDAO moduleDAO) {
        this.moduleDAO = moduleDAO;
    }

    @Override
	protected GenericDAO<Module, Long> getGenericDAO() {
		return moduleDAO;
	}
    
    @Override
    public void updateItem(ModuleBean moduleBean) throws ObjectNotFoundException, DuplicateException {
        Module dbItem = this.moduleDAO.findByIdNoAutoCommit(moduleBean.getPojo().getModuleID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found module " + moduleBean.getPojo().getModuleID());

        Module pojo = moduleBean.getPojo();

        this.moduleDAO.detach(dbItem);
        this.moduleDAO.update(pojo);
    }

    @Override
    public void addNew(ModuleBean moduleBean) throws DuplicateException {
        Module pojo = moduleBean.getPojo();
        pojo = this.moduleDAO.save(pojo);
        moduleBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                moduleDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ModuleBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        return this.moduleDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public void saveOrUpdateAll(List<Module> modules) throws ObjectNotFoundException, DuplicateException {
        for (Module module : modules) {
            this.saveOrUpdate(module);
        }
    }

    @Override
    public List<Module> findModule4WithPrefix(String prefix) {
        return this.moduleDAO.findItemsWithPrefix(prefix);
    }

    @Override
    public Module findByFieldName(String name) throws ObjectNotFoundException{
        Map<String, Object> properties = new HashMap<String, Object>();
        properties.put("name", name);
        List<Module> moduleList = moduleDAO.findByProperties(properties, "id", Constants.SORT_ASC, true, null);
        if(moduleList.isEmpty()) {
            throw new ObjectNotFoundException("NOT FOUND Module " + name);
        }
        return moduleList.get(0);
    }
}