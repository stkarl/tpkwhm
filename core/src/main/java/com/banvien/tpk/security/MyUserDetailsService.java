package com.banvien.tpk.security;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.UserDAO;
import com.banvien.tpk.core.dao.UserModuleDAO;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.domain.UserModule;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author Nguyen Hai Vien
 * 
 */

public class MyUserDetailsService implements UserDetailsService {
	private Logger log = Logger.getLogger(MyUserDetailsService.class);

	protected UserCache userCache = null;
	
	private UserDAO userDAO;

    private UserModuleDAO userModuleDAO;

    public void setUserModuleDAO(UserModuleDAO userModuleDAO) {
        this.userModuleDAO = userModuleDAO;
    }

    /**
	 * @param userDAO the userDAO to set
	 */
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	/**
	 * Creates new instance of UserManagerDaoImpl
	 */
	public MyUserDetailsService() {

	}

	/**
	 * Set UserCache
	 * 
	 * @param userCache
	 *            user cache to set
	 */
	public void setUserCache(UserCache userCache) {
		this.userCache = userCache;
	}

	/**
	 * Locates the user based on the username. In the actual implementation, the
	 * search may possibly be case insensitive, or case insensitive depending on
	 * how the implementaion instance is configured. In this case, the
	 * <code>UserDetails</code> object that comes back may have a username
	 * that is of a different case than what was actually requested..
	 * 
	 * @param username
	 *            the username presented to the {@link
	 *            org.springframework.security.authentication.dao.DaoAuthenticationProvider}
	 * @return a fully populated user record (never <code>null</code>)
	 * @throws org.springframework.security.core.userdetails.UsernameNotFoundException
	 *             if the user could not be found or the user has no
	 *             GrantedAuthority
	 * @throws org.springframework.dao.DataAccessException
	 *             if user could not be found for a repository-specific reason
	 */
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException, DataAccessException {	

		User account = null;

		try {
			account = userDAO.findByUsername(username);
			
		} catch (Exception e) {
			throw new UsernameNotFoundException(e.getMessage(), e);
		}
        if(account.getStatus() != Constants.TPK_USER_ACTIVE)
        {
            throw new UsernameNotFoundException("User InActive !!!");
        }

		
		Map<String, GrantedAuthority> authorities = new HashMap<String, GrantedAuthority>();

		//this line of code is used to check whether the user has login or not
		authorities.put(account.getRole(), new GrantedAuthorityImpl(account.getRole()));

        authorities.put(account.getUserName(), new GrantedAuthorityImpl(account.getUserName()));

        List<UserModule> userModules = this.userModuleDAO.findByUserID(account.getUserID());
        if(userModules != null){
            for(UserModule userModule : userModules){
                authorities.put(userModule.getModule().getName(), new GrantedAuthorityImpl(userModule.getModule().getName()));
            }
        }

        GrantedAuthority[] grantedAuthority = new GrantedAuthority[authorities.size()];
		authorities.values().toArray(grantedAuthority);
		MyUserDetail loginUser = new MyUserDetail(username, account.getPassword(), true, true, true, true, grantedAuthority);
        populateLoginUserInfo(account, loginUser);


		BeanUtils.copyProperties(account, loginUser);

		return loginUser;
	}
    private void populateLoginUserInfo(User account, MyUserDetail loginUser) {
        if(account.getWarehouse() != null) {
            loginUser.setWarehouseID(account.getWarehouse().getWarehouseID());
        }
        loginUser.setRole(account.getRole());
        loginUser.setCode(account.getUserCode());
    }
}