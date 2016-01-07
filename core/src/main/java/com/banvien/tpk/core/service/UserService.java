package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.UserBean;
import com.banvien.tpk.core.dto.UserDTO;
import com.banvien.tpk.core.dto.UserImportDcdtDTO;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.sql.Timestamp;
import java.util.List;

public interface UserService extends GenericService<User,Long> {

    User findByEmail(String email) throws ObjectNotFoundException;

    User findByUsername(String userName) throws ObjectNotFoundException;

    User findByUserIDAndPassword(Long userID, String password) throws ObjectNotFoundException;

    void updateItem(UserBean userBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(UserBean userBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(UserBean bean);

    Long importUser(UserDTO userDTO);

    Long updateUserDCDT(UserDTO userDTO) throws ObjectNotFoundException, DuplicateException;

    void updateItemImport(UserDTO userDTO) throws ObjectNotFoundException, DuplicateException;

    void updateProfile(UserBean userBean) throws ObjectNotFoundException, DuplicateException;

    List<User> findByRoles(List<String> roles);

    List<User> findByRole(String role);

    List<User> findListUserByName(Long userID, String userName);

    User findByUserCode(String userCode) throws ObjectNotFoundException;

    List<User> findByIds(List<Long> userIDs);

    void addNewDcdtUser(UserBean userBean) throws DuplicateException;

    void updateDcdtUser(UserBean userBean) throws ObjectNotFoundException, DuplicateException;

    Object[] searchDCDTUser(UserBean bean);

    Object[] searchAllDCDTUser(UserBean bean);

    List<String> findAllRoles();


}