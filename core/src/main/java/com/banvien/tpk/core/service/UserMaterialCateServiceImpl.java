package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.UserMaterialCateDAO;
import com.banvien.tpk.core.domain.Materialcategory;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.domain.UserMaterialCate;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserMaterialCateServiceImpl extends GenericServiceImpl<UserMaterialCate,Long>
                                                    implements UserMaterialCateService {

    protected final Log logger = LogFactory.getLog(getClass());

    private UserMaterialCateDAO userMaterialCateDAO;

    public void setUserMaterialCateDAO(UserMaterialCateDAO userMaterialCateDAO) {
        this.userMaterialCateDAO = userMaterialCateDAO;
    }


    @Override
	protected GenericDAO<UserMaterialCate, Long> getGenericDAO() {
		return userMaterialCateDAO;
	}
    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                userMaterialCateDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public void deleteItem(Long userMaterialCateID) throws ObjectNotFoundException {
        userMaterialCateDAO.delete(userMaterialCateID);
    }

    @Override
    public List<UserMaterialCate> findByUserID(Long userID) {
        return this.userMaterialCateDAO.findByUserID(userID);
    }

    @Override
    public List<UserMaterialCate> updateAssignedMaterialCate(Long userID, List<Long> materialCateIDs) {
        User user = new User();
        user.setUserID(userID);
        List<UserMaterialCate> userMaterialCates = new ArrayList<UserMaterialCate>();
        List<UserMaterialCate> dbUserMaterialCates = this.userMaterialCateDAO.findByUserID(userID);
        Map<Long,UserMaterialCate> mapMaterialCateUserMaterialCate = new HashMap<Long, UserMaterialCate>();
        if(dbUserMaterialCates != null && dbUserMaterialCates.size() > 0){
            for(UserMaterialCate dbUC : dbUserMaterialCates){
                mapMaterialCateUserMaterialCate.put(dbUC.getMaterialCategory().getMaterialCategoryID(),dbUC);
            }
        }
        for(Long materialCateID : materialCateIDs){
            Materialcategory materialCategory = new Materialcategory();
            materialCategory.setMaterialCategoryID(materialCateID);
            UserMaterialCate userMaterialCate;
            if(mapMaterialCateUserMaterialCate.size() > 0){
                  if(!mapMaterialCateUserMaterialCate.containsKey(materialCateID)){
                      userMaterialCate = saveUserMaterialCate(user,materialCategory);
                      userMaterialCates.add(userMaterialCate);
                  }else{
                      userMaterialCates.add(mapMaterialCateUserMaterialCate.get(materialCateID));
                      dbUserMaterialCates.remove(mapMaterialCateUserMaterialCate.get(materialCateID));
                  }
            }else{
                userMaterialCate = saveUserMaterialCate(user,materialCategory);
                userMaterialCates.add(userMaterialCate);
            }
        }

        if(dbUserMaterialCates != null && !dbUserMaterialCates.isEmpty()){
            this.userMaterialCateDAO.deleteAll(dbUserMaterialCates);
        }
        return userMaterialCates;
    }

    private UserMaterialCate saveUserMaterialCate(User user,Materialcategory materialCategory){
        UserMaterialCate newUserMaterialCate = new UserMaterialCate();
        newUserMaterialCate.setUser(user);
        newUserMaterialCate.setMaterialCategory(materialCategory);
        return this.userMaterialCateDAO.save(newUserMaterialCate);
    }
}