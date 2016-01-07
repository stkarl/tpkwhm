package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.MaintenancehistoryDAO;
import com.banvien.tpk.core.domain.Maintenancehistory;
import com.banvien.tpk.core.domain.Maintenancehistory;
import com.banvien.tpk.core.dto.MaintenancehistoryBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MaintenanceHistoryServiceImpl extends GenericServiceImpl<Maintenancehistory,Long>
                                                    implements MaintenanceHistoryService {

    protected final Log logger = LogFactory.getLog(getClass());

    private MaintenancehistoryDAO maintenancehistoryDAO;

    public void setMaintenancehistoryDAO(MaintenancehistoryDAO maintenancehistoryDAO) {
        this.maintenancehistoryDAO = maintenancehistoryDAO;
    }

    @Override
	protected GenericDAO<Maintenancehistory, Long> getGenericDAO() {
		return maintenancehistoryDAO;
	}

    @Override
    public void updateItem(MaintenancehistoryBean bean) throws ObjectNotFoundException, DuplicateException {
        Maintenancehistory dbItem = this.maintenancehistoryDAO.findByIdNoAutoCommit(bean.getPojo().getMaintenanceHistoryID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Maintenancehistory " + bean.getPojo().getMaintenanceHistoryID());

        Maintenancehistory pojo = bean.getPojo();
        dbItem.setNoDay(pojo.getNoDay());
        dbItem.setNote(pojo.getNote());
        dbItem.setMaintenanceDate(pojo.getMaintenanceDate());
        this.maintenancehistoryDAO.update(dbItem);
    }

    @Override
    public void addNew(MaintenancehistoryBean bean) throws DuplicateException {
        Maintenancehistory pojo = bean.getPojo();
        pojo = this.maintenancehistoryDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                maintenancehistoryDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(MaintenancehistoryBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        if (bean.getPojo().getMachine() != null && bean.getPojo().getMachine().getMachineID() > 0 ) {
            properties.put("machine.machineID", bean.getPojo().getMachine().getMachineID() );
        }

        if (bean.getPojo().getMachinecomponent() != null && bean.getPojo().getMachinecomponent().getMachineComponentID() > 0 ) {
            properties.put("machinecomponent.machineComponentID", bean.getPojo().getMachinecomponent().getMachineComponentID());
        }

        if(bean.getFromDate() != null){
            whereClause.append(" AND maintenanceDate >= '").append(bean.getFromDate()).append("'");
        }
        if(bean.getToDate() != null){
            whereClause.append(" AND maintenanceDate <= '").append(bean.getToDate()).append("'");
        }
        return this.maintenancehistoryDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public Maintenancehistory findLastestMachine(Long machineID) {
        return maintenancehistoryDAO.findLatestMachine(machineID);
    }

    @Override
    public Maintenancehistory findLastestMachineComponent(Long machineComponentID) {
        return maintenancehistoryDAO.findLastestMachineComponent(machineComponentID);
    }

    @Override
    public List<Maintenancehistory> findByMachine(Long machineID) {
        return maintenancehistoryDAO.findByMachine(machineID);
    }

    @Override
    public List<Maintenancehistory> findByMachineComponent(Long machineComponentID) {
        return maintenancehistoryDAO.findByMachineComponent(machineComponentID);
    }
}