package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.*;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.util.DateUtils;
import com.banvien.tpk.core.util.StringUtil;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.*;

public class CustomerServiceImpl extends GenericServiceImpl<Customer,Long>
                                                    implements CustomerService {

    protected final Log logger = LogFactory.getLog(getClass());

    private CustomerDAO customerDAO;

    public void setCustomerDAO(CustomerDAO CustomerDAO) {
        this.customerDAO = CustomerDAO;
    }

    private OweLogDAO oweLogDAO;

    public void setOweLogDAO(OweLogDAO oweLogDAO) {
        this.oweLogDAO = oweLogDAO;
    }

    private ProvinceDAO provinceDAO;

    public void setProvinceDAO(ProvinceDAO provinceDAO) {
        this.provinceDAO = provinceDAO;
    }

    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    private UserCustomerDAO userCustomerDAO;

    public void setUserCustomerDAO(UserCustomerDAO userCustomerDAO) {
        this.userCustomerDAO = userCustomerDAO;
    }

    @Override
	protected GenericDAO<Customer, Long> getGenericDAO() {
		return customerDAO;
	}

    @Override
    public Customer updateItem(CustomerBean bean) throws ObjectNotFoundException, DuplicateException {
        Customer dbItem = this.customerDAO.findByIdNoAutoCommit(bean.getPojo().getCustomerID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Customer " + bean.getPojo().getCustomerID());

        Customer pojo = bean.getPojo();
        if(pojo.getProvince() != null && pojo.getProvince().getProvinceID() == null){
            pojo.setProvince(null);
        }else{
            Province province = this.provinceDAO.findByIdNoAutoCommit(pojo.getProvince().getProvinceID());
            pojo.setRegion(province.getRegion());
        }
        this.customerDAO.detach(dbItem);
        return this.customerDAO.update(pojo);
    }

    @Override
    public Customer addNew(CustomerBean bean) throws DuplicateException {
        Customer pojo = bean.getPojo();
        if(pojo.getProvince() != null && pojo.getProvince().getProvinceID() == null){
            pojo.setProvince(null);
        }else{
            Province province = this.provinceDAO.findByIdNoAutoCommit(pojo.getProvince().getProvinceID());
            pojo.setRegion(province.getRegion());
        }
        pojo = this.customerDAO.save(pojo);
        bean.setPojo(pojo);
        return pojo;
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                customerDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(CustomerBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1 ");

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }
        if (bean.getPojo().getCustomerID() != null && bean.getPojo().getCustomerID() > 0) {
            properties.put("customerID", bean.getPojo().getCustomerID());
        }
        if (bean.getPojo().getRegion() != null && bean.getPojo().getRegion().getRegionID() > 0) {
            properties.put("region.regionID", bean.getPojo().getRegion().getRegionID());
        }
        if (bean.getPojo().getProvince() != null && bean.getPojo().getProvince().getProvinceID() > 0) {
            properties.put("province.provinceID", bean.getPojo().getProvince().getProvinceID());
        }
        if(SecurityUtils.userHasAuthority(Constants.NVKD_ROLE)){
            whereClause.append(" AND (createdBy.userID = ").append(SecurityUtils.getLoginUserId());
            whereClause.append(" OR customerID IN (SELECT uc.customer.customerID FROM UserCustomer uc WHERE uc.user.userID = ").append(SecurityUtils.getLoginUserId()).append("))");
        }

        return this.customerDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true,whereClause.toString());
    }

    @Override
    public List<Customer> findByUser(Long loginUserId) {
        return this.customerDAO.findByUser(loginUserId);
    }

    @Override
    public SummaryLiabilityDTO summaryLiability(ReportBean bean) {
        List<Customer> customers = this.customerDAO.findCustomerHasLiability(bean);
        SummaryLiabilityDTO result = new SummaryLiabilityDTO();
//        result.setCustomers(customers);
        return result;
    }

    @Override
    public void updateLiability(Long loginUserId, List<UpdateLiabilityDTO> updateLiabilities) {
        User user = new User();
        user.setUserID(loginUserId);
        Timestamp now = new Timestamp(System.currentTimeMillis());
        if(updateLiabilities != null && updateLiabilities.size() > 0){
            for(UpdateLiabilityDTO updateLiabilityDTO : updateLiabilities){
                Long customerID = updateLiabilityDTO.getCustomerID();
                Double payAmount = updateLiabilityDTO.getValue();
                Timestamp payDate = updateLiabilityDTO.getDate();
                Integer day = updateLiabilityDTO.getDay();
                if(customerID != null && payAmount != null && payDate != null){
                    Customer customer = new Customer();
                    customer.setCustomerID(customerID);
                    OweLog log = new OweLog();
                    log.setCustomer(customer);
                    log.setCreatedBy(user);
                    log.setCreatedDate(now);
                    log.setPay(payAmount);
                    Calendar calendar = Calendar.getInstance();
                    payDate.setHours(calendar.get(Calendar.HOUR_OF_DAY));
                    payDate.setMinutes(calendar.get(Calendar.MINUTE));
                    payDate.setSeconds(calendar.get(Calendar.SECOND));
                    log.setPayDate(payDate);
                    log.setType(Constants.OWE_MINUS);
                    log.setDayAllow(day);
                    log.setNote(updateLiabilityDTO.getNote());
                    oweLogDAO.save(log);
                }
            }
        }
    }

    @Override
    public void updateReceiveOwe(Long loginUserId, List<UpdateLiabilityDTO> updateLiabilities) {
        User user = new User();
        user.setUserID(loginUserId);
        Timestamp now = new Timestamp(System.currentTimeMillis());
        if(updateLiabilities != null && updateLiabilities.size() > 0){
            for(UpdateLiabilityDTO updateLiabilityDTO : updateLiabilities){
                Long customerID = updateLiabilityDTO.getCustomerID();
                Double oweAmount = updateLiabilityDTO.getValue();
                Timestamp oweDate = updateLiabilityDTO.getDate();
                Integer day = updateLiabilityDTO.getDay();
                if(customerID != null && oweAmount != null && oweDate != null){
                    Customer customer = new Customer();
                    customer.setCustomerID(customerID);
                    if(oweAmount != null){
                        OweLog log = new OweLog();
                        log.setCustomer(customer);
                        log.setCreatedBy(user);
                        log.setCreatedDate(now);
                        log.setPay(oweAmount);
                        Calendar calendar = Calendar.getInstance();
                        oweDate.setHours(calendar.get(Calendar.HOUR_OF_DAY));
                        oweDate.setMinutes(calendar.get(Calendar.MINUTE));
                        oweDate.setSeconds(calendar.get(Calendar.SECOND));
                        log.setOweDate(oweDate);
                        log.setType(Constants.OWE_PLUS);
                        log.setDayAllow(day);
                        log.setNote(updateLiabilityDTO.getNote());
                        oweLogDAO.save(log);
                    }
                }
            }
        }
    }

    @Override
    public Object[] importCustomerData2DB(List<ImportCustomerDataDTO> importedDatas) throws Exception{
        List<Customer> dbCustomers = this.customerDAO.findAll();
        Map<String,Customer> mapCustomer = mappingCustomer(dbCustomers);
        List<Province> dbProvinces = this.provinceDAO.findAll();
        Map<String,Province> mapProvince = mappingProvince(dbProvinces);
        List<User> dbUsers = this.userDAO.findAll();
        Map<String,User> mapUser = mappingUser(dbUsers);

        List<UserCustomer> userCustomers = this.userCustomerDAO.findAll();
        Map<String,UserCustomer> mapUserCustomer = mappingUserCustomer(userCustomers);
        StringBuilder failCode = new StringBuilder("");
        Integer totalImported = 0;
        if(importedDatas != null){
            Customer customer;
            String key,cName,pName,customerName = "";
            Province province;
            boolean isNewCustomer;
            User user;
            for (ImportCustomerDataDTO dataDTO : importedDatas){
                if(dataDTO.isValid()){
                    customerName = dataDTO.getCustomerName();
                    if(customerName.indexOf("-") > 0){
                        customerName = StringUtils.trim(StringUtils.split(customerName, "-")[0]);
                    }
                    cName = StringUtil.convertStringNotUTF8(StringUtils.deleteSpaces(customerName));
                    pName = StringUtils.isNotBlank(dataDTO.getProvince()) ? StringUtil.convertStringNotUTF8(StringUtils.deleteSpaces(dataDTO.getProvince())) : "";
                    key = cName + "_" + pName;
                    customer = mapCustomer.get(key.toLowerCase());
                    if(customer == null){
                        customer = new Customer();
                        isNewCustomer = true;
                    }else {
                        isNewCustomer = false;
                    }

                    province = mapProvince.get(dataDTO.getProvince().toLowerCase());
                    if(province == null){
                        province = new Province();
                        province.setName(dataDTO.getProvince());
                        provinceDAO.save(province);
                        mapProvince.put(dataDTO.getProvince().toLowerCase(), province);
                    }

                    customer.setName(customerName);
                    customer.setCompany(dataDTO.getCompanyName());
                    customer.setProvince(province);
                    customer.setRegion(province.getRegion());
                    customer.setAddress(dataDTO.getAddress());
                    customer.setPhone(dataDTO.getCompanyTel());
                    customer.setFax(dataDTO.getFax());
                    customer.setContact(dataDTO.getContact());
                    customer.setContactPhone(dataDTO.getContactPhone());
                    customer.setOweLimit(StringUtils.isNotBlank(dataDTO.getOweLimit()) ? Double.valueOf(dataDTO.getOweLimit()) : null);
                    customer.setBirthday(StringUtils.isNotBlank(dataDTO.getBirthday()) ? new Timestamp(DateUtils.string2Date(dataDTO.getBirthday(), "dd/MM/yyyy").getTime())  : null);
                    customer.setStatus(Constants.CUSTOMER_NORMAL);
                    customer = customerDAO.saveOrUpdate(customer);
                    totalImported++;
                    if(isNewCustomer){
                        mapCustomer.put(key.toLowerCase(), customer);
                    }

                    user = mapUser.get(dataDTO.getUserName().toLowerCase());
                    saveUserCustomer(user, customer, mapUserCustomer);
                    saveInitialOwe(customer,user, dataDTO.getOwePast(), dataDTO.getOweCurrent(), dataDTO.getPayCurrent(), dataDTO.getOweDate());

                }else{
                    if(StringUtils.isNotBlank(failCode.toString())){
                        failCode.append(", ").append(customerName).append("-").append(dataDTO.getProvince());
                    }else{
                        failCode.append(customerName).append("-").append(dataDTO.getProvince());
                    }
                }

            }
        }

        String msg = failCode.toString();


        return new Object[]{totalImported, msg};
    }

    @Override
    public Object[] importCustomerOwe2DB(List<ImportCustomerOweDTO> importedDatas, Long loginUserId) {
        List<Customer> dbCustomers = this.customerDAO.findAll();
        Map<String,Customer> mapCustomer = mappingCustomer(dbCustomers);
        List<Province> dbProvinces = this.provinceDAO.findAll();
        Map<String,Province> mapProvince = mappingProvince(dbProvinces);
        StringBuilder failCode = new StringBuilder("");
        Integer totalImported = 0;
        User user = new User();
        user.setUserID(loginUserId);
        if(importedDatas != null){
            Customer customer;
            String key,cName,pName,customerName = "";
            for (ImportCustomerOweDTO dataDTO : importedDatas){
                if(dataDTO.isValid()){
                    customerName = dataDTO.getCustomerName();
                    if(customerName.indexOf("-") > 0){
                        customerName = StringUtils.trim(StringUtils.split(customerName, "-")[0]);
                    }
                    cName = StringUtil.convertStringNotUTF8(StringUtils.deleteSpaces(customerName));
                    pName = StringUtils.isNotBlank(dataDTO.getProvince()) ? StringUtil.convertStringNotUTF8(StringUtils.deleteSpaces(dataDTO.getProvince())) : "";
                    key = cName + "_" + pName;
                    customer = mapCustomer.get(key.toLowerCase());
                    if(customer == null){
                        if(StringUtils.isNotBlank(failCode.toString())){
                            failCode.append(", ").append(customerName).append("(").append(dataDTO.getProvince()).append(")");
                        }else{
                            failCode.append(customerName).append("(").append(dataDTO.getProvince()).append(")");
                        }
                        continue;
                    }
                    saveInitialOwe(customer, user, dataDTO.getOwePast(), dataDTO.getOweCurrent(), dataDTO.getPayCurrent(), dataDTO.getOweDate());
                    totalImported++;
                }else{
                    if(StringUtils.isNotBlank(failCode.toString())){
                        failCode.append(", ").append(customerName).append("(").append(dataDTO.getProvince()).append(")");
                    }else{
                        failCode.append(customerName).append("(").append(dataDTO.getProvince()).append(")");
                    }
                }

            }
        }

        String msg = failCode.toString();
        return new Object[]{totalImported, msg};
    }

    private Map<String, UserCustomer> mappingUserCustomer(List<UserCustomer> userCustomers) {
        Map<String, UserCustomer> r = new HashMap<String, UserCustomer>();
        for(UserCustomer userCustomer : userCustomers){
            r.put(userCustomer.getUser().getUserID() + "-" + userCustomer.getCustomer().getCustomerID(), userCustomer);
        }
        return r;
    }

    private void saveInitialOwe(Customer customer,User user, String owePast, String oweCurrent, String payCurrent, String oweDate) {
        if(StringUtils.isBlank(oweDate)){
            oweDate = DateUtils.date2String(new Date(System.currentTimeMillis()), "dd/MM/yyyy");
        }
        saveImportedOweLog(customer, user,owePast, "31/12/2013", "Dư nợ đến hết 2013", Constants.OWE_PLUS);
        saveImportedOweLog(customer, user, oweCurrent, oweDate, "Tổng mua tính đến ngày " + oweDate, Constants.OWE_PLUS);
        saveImportedOweLog(customer, user,payCurrent, oweDate, "Tổng trả tính đến ngày " + oweDate, Constants.OWE_MINUS);
    }

    private void saveImportedOweLog(Customer customer,User user, String money, String date, String note, String type){
        if(StringUtils.isNotBlank(money)){
            OweLog log = new OweLog();
            log.setCustomer(customer);
            log.setPay(Double.valueOf(money));
            if(type.equals(Constants.OWE_MINUS)){
                if(StringUtils.isNotBlank(date)){
                    log.setPayDate(new Timestamp(DateUtils.string2Date(date, "dd/MM/yyyy").getTime()) );
                }else{
                    log.setPayDate(new Timestamp(System.currentTimeMillis()));
                }
            }else if(type.equals(Constants.OWE_PLUS)){
                if(StringUtils.isNotBlank(date)){
                    log.setOweDate(new Timestamp(DateUtils.string2Date(date, "dd/MM/yyyy").getTime()) );
                }else{
                    log.setOweDate(new Timestamp(System.currentTimeMillis()));
                }
            }
            log.setNote(note);
            log.setCreatedBy(user);
            log.setType(type);
            oweLogDAO.save(log);
        }
    }

    private void saveUserCustomer(User user, Customer customer, Map<String, UserCustomer> mapUserCustomer) {
        if(user != null && customer != null){
            String key = user.getUserID() + "-" + customer.getCustomerID();
            if(!mapUserCustomer.containsKey(key)){
                UserCustomer uc = new UserCustomer();
                uc.setCustomer(customer);
                uc.setUser(user);
                userCustomerDAO.save(uc);
                mapUserCustomer.put(key,uc);
            }
        }
    }

    private Map<String, User> mappingUser(List<User> dbUsers) {
        Map<String, User> result = new HashMap<String, User>();
        if(dbUsers != null){
            String key;
            for(User user : dbUsers){
                key = user.getUserName();
                if(!result.containsKey(key)){
                    result.put(key.toLowerCase(),user);
                }
            }
        }
        return result;
    }

    private Map<String, Province> mappingProvince(List<Province> dbProvinces) {
        Map<String, Province> result = new HashMap<String, Province>();
        if(dbProvinces != null){
            String key;
            for(Province province : dbProvinces){
                key = province.getName();
                if(!result.containsKey(key)){
                    result.put(key.toLowerCase(),province);
                }
            }
        }
        return result;
    }

    private Map<String, Customer> mappingCustomer(List<Customer> dbCustomers) {
        Map<String, Customer> result = new HashMap<String, Customer>();
        if(dbCustomers != null){
            String key,cName,pName;
            for(Customer customer : dbCustomers){
                cName = StringUtil.convertStringNotUTF8(StringUtils.deleteSpaces(customer.getName()));
                pName = customer.getProvince() != null ? StringUtil.convertStringNotUTF8(StringUtils.deleteSpaces(customer.getProvince().getName())) : "";
                key = cName + "_" + pName;
                if(!result.containsKey(key.toLowerCase())){
                    result.put(key.toLowerCase(),customer);
                }
            }
        }
        return result;
    }
}