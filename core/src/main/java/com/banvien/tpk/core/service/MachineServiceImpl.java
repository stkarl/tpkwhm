package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.MachineDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.MachinecomponentDAO;
import com.banvien.tpk.core.domain.Machine;
import com.banvien.tpk.core.domain.Machinecomponent;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.MachineBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MachineServiceImpl extends GenericServiceImpl<Machine,Long>
                                                    implements MachineService {

    protected final Log logger = LogFactory.getLog(getClass());

    private MachineDAO MachineDAO;

    public void setMachineDAO(MachineDAO MachineDAO) {
        this.MachineDAO = MachineDAO;
    }

    private MachinecomponentDAO machinecomponentDAO;

    public void setMachinecomponentDAO(MachinecomponentDAO machinecomponentDAO) {
        this.machinecomponentDAO = machinecomponentDAO;
    }

    @Override
	protected GenericDAO<Machine, Long> getGenericDAO() {
		return MachineDAO;
	}

    @Override
    public void updateItem(MachineBean bean) throws ObjectNotFoundException, DuplicateException {
        Machine dbItem = this.MachineDAO.findByIdNoAutoCommit(bean.getPojo().getMachineID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Machine " + bean.getPojo().getMachineID());

        Machine pojo = bean.getPojo();
        dbItem.setName(pojo.getName());
        dbItem.setCode(pojo.getCode());
        dbItem.setDescription(pojo.getDescription());
        dbItem.setWarehouse(pojo.getWarehouse());
        dbItem.setBoughtDate(pojo.getBoughtDate());
        this.MachineDAO.update(dbItem);
    }

    @Override
    public void addNew(MachineBean bean) throws DuplicateException {
        Machine pojo = bean.getPojo();
        pojo.setStatus(Constants.MACHINE_NORMAL);
        User user = new User();
        user.setUserID(bean.getLoginID());
        pojo.setCreatedBy(user);
        pojo = this.MachineDAO.save(pojo);
        bean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                MachineDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(MachineBean bean) {
        Map<String, Object> properties;
        if(StringUtils.isBlank(bean.getComponentName()) && StringUtils.isBlank(bean.getComponentCode())){
            properties = new HashMap<String, Object>();
            if (StringUtils.isNotBlank(bean.getPojo().getName())) {
                properties.put("name", bean.getPojo().getName());
            }
            if (StringUtils.isNotBlank(bean.getPojo().getCode())) {
                properties.put("code", bean.getPojo().getCode());
            }
            return this.MachineDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
        }else{
            properties = new HashMap<String, Object>();
            if(StringUtils.isNotBlank(bean.getComponentCode())){
                properties.put("code", bean.getComponentCode());
            }
            if(StringUtils.isNotBlank(bean.getComponentName())){
                properties.put("name", bean.getComponentName());
            }
            Object[] objects = this.machinecomponentDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
            List<Machinecomponent> machinecomponents = (List<Machinecomponent>) objects[1];
            List<Machine> machines = new ArrayList<Machine>();
            if(machinecomponents != null && machinecomponents.size() > 0){
                Map<Long,Machine> resultMap = new HashMap<Long, Machine>();
                for(Machinecomponent machinecomponent : machinecomponents){
                    Machine machine = getMachineOfComponent(machinecomponent);
                    if(!resultMap.containsKey(machine.getMachineID())){
                        resultMap.put(machine.getMachineID(), machine);
                        machines.add(machine);
                    }
                }
                return new Object[]{resultMap.size(), machines};
            }else{
                return new Object[]{0, machines};
            }
        }
    }

    private Machine getMachineOfComponent(Machinecomponent machinecomponent) {
        if(machinecomponent.getMachine() != null){
            return machinecomponent.getMachine();
        }else{
            return getMachineOfComponent(machinecomponent.getParent());
        }
    }

    @Override
    public List<Machine> findAllActiveMachineByWarehouse(Long warehouseID) {
        return this.MachineDAO.findAllActiveMachineByWarehouse(warehouseID);

    }

    @Override
    public List<Machine> findWarningMachine(Long warehouseID) {
        return this.MachineDAO.findWarningMachine(warehouseID);
    }

    @Override
    public void updateSubmitMachineForConfirm(Long loginUserId, Long machineID, Integer status) {
        User user = new User();
        user.setUserID(loginUserId);
        Machine machine = MachineDAO.findByIdNoAutoCommit(machineID);
        if(status.equals(Constants.MACHINE_SUBMIT)){
            if(machine != null && (machine.getConfirmStatus() == null || machine.getConfirmStatus() < Constants.MACHINE_SUBMIT)){
                machine.setConfirmStatus(status);
            }
        }else if(status.equals(Constants.MACHINE_APPROVED_1)){
            if(machine != null && machine.getConfirmStatus() == Constants.MACHINE_SUBMIT){
                machine.setConfirmStatus(status);
                machine.setLeader(user);
            }
        }else if(status.equals(Constants.MACHINE_APPROVED_2)){
            if(machine != null && machine.getConfirmStatus() == Constants.MACHINE_APPROVED_1){
                machine.setConfirmStatus(status);
                machine.setChief(user);
            }
        }else if(status.equals(Constants.MACHINE_REJECTED)){
            machine.setConfirmStatus(status);
        }
        this.MachineDAO.update(machine);
    }
}