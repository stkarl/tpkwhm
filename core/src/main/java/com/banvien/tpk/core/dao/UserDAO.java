package com.banvien.tpk.core.dao;

import java.util.List;
import java.sql.Timestamp;

import com.banvien.tpk.core.domain.User;

/**
 * <p>Generic DAO layer for Users</p>
 * <p>Generated at Thu Jun 14 18:28:11 GMT+07:00 2012</p>
 *
 * @author Salto-db Generator v1.1 / EJB3 + Spring/Hibernate DAO
 */
public interface UserDAO extends GenericDAO<User,Long> {

    User findByUsername(String username);

    User findByUserIDAndPassword(Long userID, String password);

    List<User> findByRoles(List<String> roles);

    List<User> findListUserByName(Long userID, String userName);

    public List<User> findByIds(List<Long> userIDs);

    List<String> findAllRoles();


}