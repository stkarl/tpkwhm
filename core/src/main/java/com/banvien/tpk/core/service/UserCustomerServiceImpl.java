package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.CustomerDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.UserCustomerDAO;
import com.banvien.tpk.core.domain.Customer;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.domain.UserCustomer;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserCustomerServiceImpl extends GenericServiceImpl<UserCustomer,Long>
                                                    implements UserCustomerService {

    protected final Log logger = LogFactory.getLog(getClass());

    private UserCustomerDAO userCustomerDAO;

    public void setUserCustomerDAO(UserCustomerDAO userCustomerDAO) {
        this.userCustomerDAO = userCustomerDAO;
    }

    private CustomerDAO customerDAO;

    public void setCustomerDAO(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    @Override
	protected GenericDAO<UserCustomer, Long> getGenericDAO() {
		return userCustomerDAO;
	}
    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                userCustomerDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public void deleteItem(Long userCustomerID) throws ObjectNotFoundException {
        userCustomerDAO.delete(userCustomerID);
    }

    @Override
    public List<UserCustomer> findByUserID(Long userID) {
        return this.userCustomerDAO.findByUserID(userID);
    }

    @Override
    public List<UserCustomer> updateAssignedCustomer(Long userID, List<Long> customerIDs) {
        User user = new User();
        user.setUserID(userID);
        List<UserCustomer> userCustomers = new ArrayList<UserCustomer>();
        List<UserCustomer> dbUserCustomers = this.userCustomerDAO.findByUserID(userID);
        Map<Long,UserCustomer> mapCustomerUserCustomer = new HashMap<Long, UserCustomer>();
        if(dbUserCustomers != null && dbUserCustomers.size() > 0){
            for(UserCustomer dbUC : dbUserCustomers){
                mapCustomerUserCustomer.put(dbUC.getCustomer().getCustomerID(),dbUC);
            }
        }

        for(Long customerID : customerIDs){
            Customer customer = new Customer();
            customer.setCustomerID(customerID);
            UserCustomer userCustomer;
            if(mapCustomerUserCustomer.size() > 0){
                  if(!mapCustomerUserCustomer.containsKey(customerID)){
                      userCustomer = saveUserCustomer(user,customer);
                      userCustomers.add(userCustomer);
                  }else{
                      userCustomers.add(mapCustomerUserCustomer.get(customerID));
                      dbUserCustomers.remove(mapCustomerUserCustomer.get(customerID));
                  }
            }else{
                userCustomer = saveUserCustomer(user,customer);
                userCustomers.add(userCustomer);
            }
        }

        if(dbUserCustomers != null && !dbUserCustomers.isEmpty()){
            this.userCustomerDAO.deleteAll(dbUserCustomers);
        }
        return userCustomers;
    }

    @Override
    public List<UserCustomer> addAssignedCustomer(Long userID, List<Long> customerIDs) {
        User user = new User();
        user.setUserID(userID);
        List<UserCustomer> userCustomers = new ArrayList<UserCustomer>();
        if(customerIDs != null){
            List<Customer> customers = this.customerDAO.findByIDs(customerIDs);
            for(Customer customer : customers){
                UserCustomer userCustomer = saveUserCustomer(user,customer);
                userCustomers.add(userCustomer);
            }
        }
        return userCustomers;
    }

    private UserCustomer saveUserCustomer(User user,Customer customer){
        UserCustomer newUserCustomer = new UserCustomer();
        newUserCustomer.setUser(user);
        newUserCustomer.setCustomer(customer);
        return this.userCustomerDAO.save(newUserCustomer);
    }
}