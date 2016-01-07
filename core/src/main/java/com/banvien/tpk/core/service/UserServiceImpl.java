package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.*;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.security.SecurityUtils;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.security.DesEncrypterUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.banvien.tpk.core.Constants;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl extends GenericServiceImpl<User,Long>
        implements UserService {

    protected final Log logger = LogFactory.getLog(getClass());

    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Override
    protected GenericDAO<User, Long> getGenericDAO() {
        return userDAO;
    }

    @Override
    public User findByEmail(String email) throws ObjectNotFoundException {
        User res = this.userDAO.findEqualUnique(User.FIELD_EMAIL, email);
        if (res == null) throw new ObjectNotFoundException("Not found user with email " + email);
        return res;
    }

    @Override
    public User findByUsername(String userName) throws ObjectNotFoundException {
        User res = this.userDAO.findEqualUnique(User.FIELD_USERNAME, userName);
        if (res == null) throw new ObjectNotFoundException("Not found user with username " + userName);
        return res;
    }

    @Override
    public User findByUserIDAndPassword(Long userID, String password) throws ObjectNotFoundException {
        return userDAO.findByUserIDAndPassword(userID,DesEncrypterUtils.getInstance().encrypt(password));
    }

    @Override
    public void updateItem(UserBean userBean) throws ObjectNotFoundException, DuplicateException {
        User dbItem = this.userDAO.findByIdNoAutoCommit(userBean.getPojo().getUserID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found user " + userBean.getPojo().getUserID());

        User pojo = userBean.getPojo();
        if (StringUtils.isNotEmpty(pojo.getPassword())) {
            pojo.setPassword(DesEncrypterUtils.getInstance().encrypt(pojo.getPassword()));
        }else{
            pojo.setPassword(dbItem.getPassword());
        }
        this.userDAO.detach(dbItem);
        this.userDAO.update(pojo);




        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1 ");
        //Object obj[] = distributorDAO.searchByProperties(properties, userBean.getDistributorBean().getFirstItem(), userBean.getDistributorBean().getMaxPageItems() , "distributorID","DESC" ,true, whereClause.toString());


    }

    @Override
    public void updateItemImport(UserDTO userDTO) throws ObjectNotFoundException, DuplicateException {
        User dbItem = this.userDAO.findByUsername(userDTO.getUserName());
        if (dbItem == null) throw new ObjectNotFoundException("Not found user " + userDTO.getUserName());

        String region = userDTO.getRegion();
        if (StringUtils.isNotEmpty(dbItem.getPassword())) {
            dbItem.setPassword(DesEncrypterUtils.getInstance().encrypt(userDTO.getPassword()));
        }else{
            dbItem.setPassword(dbItem.getPassword());
        }
        this.userDAO.detach(dbItem);
        this.userDAO.update(dbItem);


    }


    @Override
    public void addNew(UserBean userBean) throws DuplicateException {
        User pojo = userBean.getPojo();
        pojo.setPassword(DesEncrypterUtils.getInstance().encrypt(pojo.getPassword()));
        pojo = this.userDAO.save(pojo);
        userBean.setPojo(pojo);

    }

    @Override
    public void addNewDcdtUser(UserBean userBean) throws DuplicateException {
        User pojo = userBean.getPojo();
        if(StringUtils.isBlank(pojo.getPassword()) || pojo.getPassword() == null){
            pojo.setPassword("123456");
        }
        pojo.setPassword(DesEncrypterUtils.getInstance().encrypt(pojo.getPassword()));
        if(userBean.getPojo().getWarehouse() !=null && userBean.getPojo().getWarehouse().getWarehouseID() == null ){
            pojo.setWarehouse(null);
        }
        this.userDAO.save(pojo);
    }

    @Override
    public void updateDcdtUser(UserBean userBean) throws ObjectNotFoundException,DuplicateException {
        User dbItem = this.userDAO.findByIdNoAutoCommit(userBean.getPojo().getUserID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found user " + userBean.getPojo().getUserID());

        User pojo = userBean.getPojo();

        if (StringUtils.isNotEmpty(pojo.getPassword())) {
            pojo.setPassword(DesEncrypterUtils.getInstance().encrypt(pojo.getPassword()));
        }else{
            pojo.setPassword(dbItem.getPassword());
        }
        if(userBean.getPojo().getWarehouse() !=null && userBean.getPojo().getWarehouse().getWarehouseID() == null ){
            pojo.setWarehouse(null);
        }

        this.userDAO.detach(dbItem);
        this.userDAO.update(pojo);



    }

    @Override
    public Object[] searchDCDTUser(UserBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");

        if (StringUtils.isNotBlank(bean.getPojo().getUserName())) {
            properties.put(User.FIELD_USERNAME, bean.getPojo().getUserName());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getFullname())) {
            properties.put(User.FIELD_FULLNAME, bean.getPojo().getFullname());
        }
        if (bean.getPojo().getStatus() != null && bean.getPojo().getStatus() >= 0) {
            properties.put(User.FIELD_STATUS, bean.getPojo().getStatus());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getRole())) {
            whereClause.append(" AND A.role =  '").append(bean.getPojo().getRole()).append("'");
        }
        if(SecurityUtils.getPrincipal().getRole().equals(Constants.QLKD_ROLE)){
            whereClause.append(" AND A.role IN ('").append(Constants.QLKD_ROLE).append("', '").append(Constants.QLCN_ROLE).append("', '").append(Constants.NVKD_ROLE).append("')");
        }
        if(bean.getPojo().getWarehouse() != null && bean.getPojo().getWarehouse().getWarehouseID() != null && bean.getPojo().getWarehouse().getWarehouseID() > 0){
            properties.put("warehouse.warehouseID", bean.getPojo().getWarehouse().getWarehouseID());
        }
        return this.userDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true,whereClause.toString());

    }

    @Override
    public Object[] searchAllDCDTUser(UserBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getUserName())) {
            properties.put(User.FIELD_USERNAME, bean.getPojo().getUserName());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getFullname())) {
            properties.put(User.FIELD_FULLNAME, bean.getPojo().getFullname());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getEmail())) {
            properties.put(User.FIELD_EMAIL, bean.getPojo().getEmail());
        }
        if (bean.getPojo().getStatus() != null && bean.getPojo().getStatus() >= 0) {
            properties.put(User.FIELD_STATUS, bean.getPojo().getStatus());
        }

        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        whereClause.append(" AND A.role IN ('DISTRIBUTOR','SM','SE','ASM','RSM','AUDITOR')");
        if (StringUtils.isNotBlank(bean.getPojo().getRole())) {
            whereClause.append(" AND A.role =  '").append(bean.getPojo().getRole()).append("'");
        }

        if(bean.getRegionID() != null && bean.getRegionID() > 0){
            if(bean.getRegionID() != null && bean.getRegionID() > 0){
                whereClause.append(" AND A.userID IN (Select ur.user.userID From Userregion ur Where ur.region.regionID = ").append(bean.getRegionID().toString()).append(" ) ");
            }
        }

        return this.userDAO.searchByProperties(properties, bean.getFirstItem(), -1, bean.getSortExpression(), bean.getSortDirection(), true,whereClause.toString());

    }

    @Override
    public Long importUser(UserDTO userDTO)
    {
        User user = new User();

        user.setUserName(userDTO.getUserName());
        user.setPassword(DesEncrypterUtils.getInstance().encrypt(userDTO.getPassword()));
        user.setFullname(userDTO.getFullName());
        user.setEmail(userDTO.getEmail());
        user.setStatus(userDTO.getStatus());
        user.setRole(userDTO.getRole());

        this.userDAO.save(user);

        //Distributor distributor = distributorDAO.findBySapCodeAndName(userDTO.getDistributor(), StringUtil.removeDiacritic(userDTO.getDistributorName()));



        return user.getUserID();
    }

    @Override
    public Long updateUserDCDT(UserDTO userDTO) throws ObjectNotFoundException, DuplicateException
    {
        User dbItem = this.userDAO.findByUsername(userDTO.getUserName());
        if (dbItem == null) throw new ObjectNotFoundException("Not found user " + userDTO.getUserName());
        User user = new User();

        user.setUserName(userDTO.getUserName());
        user.setPassword(DesEncrypterUtils.getInstance().encrypt(userDTO.getPassword()));
        user.setFullname(userDTO.getFullName());
        user.setEmail(userDTO.getEmail());
        user.setStatus(userDTO.getStatus());
        user.setRole(userDTO.getRole());
        User userLiveManager = userDAO.findByUsername(userDTO.getLiveManager());
        user.setUserID(dbItem.getUserID());

        this.userDAO.detach(dbItem);
        this.userDAO.update(user);

        return user.getUserID();
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                userDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(UserBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer();
        if (StringUtils.isNotBlank(bean.getPojo().getUserName())) {
            properties.put(User.FIELD_USERNAME, bean.getPojo().getUserName());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getFullname())) {
            properties.put(User.FIELD_FULLNAME, bean.getPojo().getFullname());
        }
        if (StringUtils.isNotBlank(bean.getPojo().getEmail())) {
            properties.put(User.FIELD_EMAIL, bean.getPojo().getEmail());
        }

        if (bean.getPojo().getStatus() != null && bean.getPojo().getStatus() >= 0) {
            properties.put(User.FIELD_STATUS, bean.getPojo().getStatus());
        }
        if(bean.getRegionID() != null && bean.getRegionID() > 0){
            whereClause.append(" userID IN (Select ur.user.userID Form UserRegion ur Where ur.regionID = ").append(bean.getRegionID().toString()).append(" ) ");
        }
        return this.userDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }


    @Override
    public void updateProfile(UserBean userBean) throws ObjectNotFoundException, DuplicateException {
        User dbItem = this.userDAO.findByIdNoAutoCommit(userBean.getPojo().getUserID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found user " + userBean.getPojo().getUserID());


        if (StringUtils.isNotEmpty(userBean.getNewPassword())) {
            dbItem.setPassword(DesEncrypterUtils.getInstance().encrypt(userBean.getNewPassword()));
        }
        dbItem.setEmail(userBean.getPojo().getEmail());
        dbItem.setPhone(userBean.getPojo().getPhone());
        dbItem.setFullname(userBean.getPojo().getFullname());

        this.userDAO.update(dbItem);
    }

    @Override
    public List<User> findByRoles(List<String> roles) {
        return this.userDAO.findByRoles(roles);
    }

    @Override
    public List<User> findListUserByName(Long userID, String userName) {
        return this.userDAO.findListUserByName(userID, userName);
    }



    @Override
    public User findByUserCode(String userCode) throws ObjectNotFoundException {
        User res = this.userDAO.findEqualUnique(User.FIELD_USERCODE, userCode);
        return res;
    }



    @Override
    public List<User> findByRole(String role) {
        Map<String, Object> properties = new HashMap<String, Object>();
        properties.put("role", role);
        return userDAO.findByProperties(properties, "fullname", Constants.SORT_ASC, true, null);
    }

    @Override
    public List<User> findByIds(List<Long> userIDs) {
        return userDAO.findByIds(userIDs);
    }



    @Override
    public List<String> findAllRoles() {
        return this.userDAO.findAllRoles();
    }

}