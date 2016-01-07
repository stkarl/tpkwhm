package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.UserModuleDAO;
import com.banvien.tpk.core.domain.Module;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.domain.UserModule;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserModuleServiceImpl extends GenericServiceImpl<UserModule,Long>
                                                    implements UserModuleService {

    protected final Log logger = LogFactory.getLog(getClass());

    private UserModuleDAO userModuleDAO;

    public void setUserModuleDAO(UserModuleDAO userModuleDAO) {
        this.userModuleDAO = userModuleDAO;
    }


    @Override
	protected GenericDAO<UserModule, Long> getGenericDAO() {
		return userModuleDAO;
	}
    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                userModuleDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public void deleteItem(Long userModuleID) throws ObjectNotFoundException {
        userModuleDAO.delete(userModuleID);
    }

    @Override
    public List<UserModule> findByUserID(Long userID) {
        return this.userModuleDAO.findByUserID(userID);
    }

    @Override
    public List<UserModule> updateAssignedModule(Long userID, List<Long> moduleIDs) {
        User user = new User();
        user.setUserID(userID);
        List<UserModule> userModules = new ArrayList<UserModule>();
        List<UserModule> dbUserModules = this.userModuleDAO.findByUserID(userID);
        Map<Long,UserModule> mapModuleUserModule = new HashMap<Long, UserModule>();
        if(dbUserModules != null && dbUserModules.size() > 0){
            for(UserModule dbUC : dbUserModules){
                mapModuleUserModule.put(dbUC.getModule().getModuleID(),dbUC);
            }
        }
        if(moduleIDs != null){
            for(Long customerID : moduleIDs){
                Module customer = new Module();
                customer.setModuleID(customerID);
                UserModule userModule;
                if(mapModuleUserModule.size() > 0){
                    if(!mapModuleUserModule.containsKey(customerID)){
                        userModule = saveUserModule(user,customer);
                        userModules.add(userModule);
                    }else{
                        userModules.add(mapModuleUserModule.get(customerID));
                        dbUserModules.remove(mapModuleUserModule.get(customerID));
                    }
                }else{
                    userModule = saveUserModule(user,customer);
                    userModules.add(userModule);
                }
            }
        }

        if(dbUserModules != null && !dbUserModules.isEmpty()){
            this.userModuleDAO.deleteAll(dbUserModules);
        }
        return userModules;
    }

    private UserModule saveUserModule(User user,Module customer){
        UserModule newUserModule = new UserModule();
        newUserModule.setUser(user);
        newUserModule.setModule(customer);
        return this.userModuleDAO.save(newUserModule);
    }
}