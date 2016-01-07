package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.MachineDAO;
import com.banvien.tpk.core.dao.MachinecomponentDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.MaintenancehistoryDAO;
import com.banvien.tpk.core.domain.Machine;
import com.banvien.tpk.core.domain.Machinecomponent;
import com.banvien.tpk.core.domain.Maintenancehistory;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.MachinecomponentBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.util.DateUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MachinecomponentServiceImpl extends GenericServiceImpl<Machinecomponent,Long>
                                                    implements MachinecomponentService {

    protected final Log logger = LogFactory.getLog(getClass());

    private MachinecomponentDAO machinecomponentDAO;

    public void setMachinecomponentDAO(MachinecomponentDAO machinecomponentDAO) {
        this.machinecomponentDAO = machinecomponentDAO;
    }

    private MaintenancehistoryDAO maintenancehistoryDAO;

    public void setMaintenancehistoryDAO(MaintenancehistoryDAO maintenancehistoryDAO) {
        this.maintenancehistoryDAO = maintenancehistoryDAO;
    }

    private MachineDAO machineDAO;

    public void setMachineDAO(MachineDAO machineDAO) {
        this.machineDAO = machineDAO;
    }

    @Override
	protected GenericDAO<Machinecomponent, Long> getGenericDAO() {
		return machinecomponentDAO;
	}

    @Override
    public void updateItem(MachinecomponentBean bean) throws ObjectNotFoundException, DuplicateException {
        Machinecomponent pojo = bean.getPojo();
        Machinecomponent machinecomponent = machinecomponentDAO.findByIdNoAutoCommit(bean.getPojo().getMachineComponentID());
        machinecomponent.setName(pojo.getName());
        machinecomponent.setCode(pojo.getCode());
        machinecomponent.setDescription(pojo.getDescription());
        machinecomponent.setStatus(pojo.getStatus());
        this.machinecomponentDAO.update(machinecomponent);
    }

    @Override
    public void addNew(MachinecomponentBean bean) throws DuplicateException {
        Machinecomponent pojo = bean.getPojo();
        User user = new User();
        user.setUserID(bean.getLoginID());
        pojo.setCreatedBy(user);
        pojo = this.machinecomponentDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                machinecomponentDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(MachinecomponentBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }

        if (StringUtils.isNotBlank(bean.getPojo().getCode())) {
            properties.put("code", bean.getPojo().getCode());
        }

        if (bean.getPojo().getMachine() != null && bean.getPojo().getMachine().getMachineID() > 0 ) {
            properties.put("machine.machineID", bean.getPojo().getMachine().getMachineID() );
        }

        return this.machinecomponentDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }

    @Override
    public List<Machinecomponent> findByMachineAndWarehouse(Long machineID, Long warehouseID) {
        List<Machinecomponent> machinecomponents = this.machinecomponentDAO.findByMachineAndWarehouse(machineID, warehouseID);
        List<Maintenancehistory> maintenancehistories = this.maintenancehistoryDAO.findLatestForComponentsOfMachine(machineID);
        Map<Long,Maintenancehistory> mapComponentDate = new HashMap<Long, Maintenancehistory>();
        if(maintenancehistories != null && maintenancehistories.size() > 0){
            for(Maintenancehistory maintenancehistory : maintenancehistories){
                mapComponentDate.put(maintenancehistory.getMachinecomponent().getMachineComponentID(),maintenancehistory);
            }
        }
        for(Machinecomponent machinecomponent : machinecomponents){
            machinecomponent.setLatestMaintenance(mapComponentDate.get(machinecomponent.getMachineComponentID()));
            setLatestMaintenanceForChildComponent(machinecomponent, machinecomponent.getChildComponents());
        }
        return machinecomponents;
    }

    private void setLatestMaintenanceForChildComponent(Machinecomponent parent, List<Machinecomponent> childComponents) {
        if(childComponents != null && childComponents.size() > 0){
            List<Maintenancehistory> maintenancehistories = this.maintenancehistoryDAO.findLatestForComponentsOfParentComponent(parent.getMachineComponentID());
            Map<Long,Maintenancehistory> mapComponentDate = new HashMap<Long, Maintenancehistory>();
            if(maintenancehistories != null && maintenancehistories.size() > 0){
                for(Maintenancehistory maintenancehistory : maintenancehistories){
                    mapComponentDate.put(maintenancehistory.getMachinecomponent().getMachineComponentID(),maintenancehistory);
                }
            }
            for(Machinecomponent machinecomponent : childComponents){
                machinecomponent.setLatestMaintenance(mapComponentDate.get(machinecomponent.getMachineComponentID()));
                setLatestMaintenanceForChildComponent(machinecomponent, machinecomponent.getChildComponents());
            }
        }
    }

    @Override
    public List<Machinecomponent> findWarningComponent(Long warehouseID) {
        return this.machinecomponentDAO.findWarningComponent(warehouseID);
    }

    @Override
    public Machinecomponent updateItemAjax(Long componentID, String componentName, String componentCode, String componentDescription) throws Exception{
        Machinecomponent machinecomponent = machinecomponentDAO.findByIdNoAutoCommit(componentID);
        machinecomponent.setName(componentName);
        machinecomponent.setCode(componentCode);
        machinecomponent.setDescription(componentDescription);
        machinecomponent = this.machinecomponentDAO.update(machinecomponent);
        return machinecomponent;
    }

    @Override
    public void addDuplicateComponent(Long componentID, Integer numberOfComponent) {
        Machinecomponent machinecomponent = this.machinecomponentDAO.findByIdNoAutoCommit(componentID);
        Integer noNeed = numberOfComponent - 1;
        Machinecomponent dupComp;
        String groupCode = machinecomponent.getCode() + Constants.POSTFIX_COMPONENT;
        Integer index;
        for(int i = 0; i < noNeed; i++ ){
            index = i + 2;
            dupComp = new Machinecomponent(machinecomponent.getName(),machinecomponent.getCode() + "-" + index, machinecomponent.getDescription(),machinecomponent.getMachine(), Constants.MACHINE_NORMAL);
            dupComp.setGroupCode(groupCode);
            dupComp.setParent(machinecomponent.getParent());
            dupComp.setCreatedBy(machinecomponent.getCreatedBy());
            this.machinecomponentDAO.save(dupComp);
        }
        machinecomponent.setGroupCode(groupCode);
        machinecomponent.setCode(machinecomponent.getCode() + "-1");
        this.machinecomponentDAO.update(machinecomponent);
    }

    @Override
    public void addMaintainDetail(Long loginUserId, Long componentID, String componentDate, Integer componentNoDay, String maintainDes, Integer status) {
        Machinecomponent machinecomponent = this.machinecomponentDAO.findByIdNoAutoCommit(componentID);
        User user = new User();
        user.setUserID(loginUserId);
        saveCompLog(machinecomponent,user,componentDate,componentNoDay,maintainDes);
        if(status != null){
            machinecomponent.setStatus(status);
            this.machinecomponentDAO.update(machinecomponent);
        }
        recursiveSaveCompLog(machinecomponent.getChildComponents(),user,componentDate,componentNoDay,status);
    }

    private void saveCompLog(Machinecomponent machinecomponent, User user, String componentDate, Integer componentNoDay, String maintainDes){
        Maintenancehistory maintenancehistory = new Maintenancehistory();
        maintenancehistory.setMachinecomponent(machinecomponent);
        maintenancehistory.setNote(maintainDes);
        maintenancehistory.setNoDay(componentNoDay);
        maintenancehistory.setCreatedBy(user);
        maintenancehistory.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        maintenancehistory.setMaintenanceDate(new Timestamp(DateUtils.string2Date(componentDate,"dd/MM/yyyy").getTime()));
        this.maintenancehistoryDAO.save(maintenancehistory);

    }

    @Override
    public void addMaintainMachineDetail(Long loginUserId, Long machineID, String machineDate, Integer machineNoDay, String maintainDes, Integer status) {
        Maintenancehistory maintenancehistory = new Maintenancehistory();

        Machine machine = this.machineDAO.findByIdNoAutoCommit(machineID);
        List<Machinecomponent> machinecomponents = machine.getMachinecomponents();
        User user = new User();
        user.setUserID(loginUserId);

        maintenancehistory.setMachine(machine);
        maintenancehistory.setNote(maintainDes);
        maintenancehistory.setNoDay(machineNoDay);
        maintenancehistory.setCreatedBy(user);
        maintenancehistory.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        maintenancehistory.setMaintenanceDate(new Timestamp(DateUtils.string2Date(machineDate,"dd/MM/yyyy").getTime()));
        this.maintenancehistoryDAO.save(maintenancehistory);
        if(status != null){
            machine.setStatus(status);
            this.machineDAO.update(machine);
        }


        if(machinecomponents != null && machinecomponents.size() > 0){
            for(Machinecomponent comp : machinecomponents){
                if(comp.getStatus() != Constants.MACHINE_STOP){
                    saveCompLog(comp,user,machineDate,machineNoDay,"Bảo dưỡng theo máy");
                    comp.setStatus(status);
                    this.machinecomponentDAO.update(comp);
                    recursiveSaveCompLog(comp.getChildComponents(),user,machineDate,machineNoDay,status);
                }
            }
        }
    }

    @Override
    public List<Machinecomponent> findAllActiveComponentByWarehouse(Long warehouseID) {
        return this.machinecomponentDAO.findAllActiveComponentByWarehouse(warehouseID);
    }

    private void recursiveSaveCompLog(List<Machinecomponent> machinecomponents, User user, String machineDate, Integer machineNoDay, Integer status) {
        if(machinecomponents != null && machinecomponents.size() > 0){
            for(Machinecomponent comp : machinecomponents){
                if(comp.getStatus() != Constants.MACHINE_STOP){
                    saveCompLog(comp,user,machineDate,machineNoDay,"Bảo dưỡng theo linh kiện cha");
                    comp.setStatus(status);
                    this.machinecomponentDAO.update(comp);
                }
                recursiveSaveCompLog(comp.getChildComponents(),user,machineDate,machineNoDay,status);
            }
        }
    }
}