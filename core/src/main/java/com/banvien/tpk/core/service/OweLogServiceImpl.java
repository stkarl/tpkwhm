package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.CustomerDAO;
import com.banvien.tpk.core.dao.OweLogDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Customer;
import com.banvien.tpk.core.domain.OweLog;
import com.banvien.tpk.core.dto.OweLogBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OweLogServiceImpl extends GenericServiceImpl<OweLog,Long>
                                                    implements OweLogService {

    protected final Log logger = LogFactory.getLog(getClass());

    private OweLogDAO oweLogDAO;
    private CustomerDAO customerDAO;

    public void setCustomerDAO(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    public void setOweLogDAO(OweLogDAO oweLogDAO) {
        this.oweLogDAO = oweLogDAO;
    }

    @Override
	protected GenericDAO<OweLog, Long> getGenericDAO() {
		return oweLogDAO;
	}

    @Override
    public void updateItem(OweLogBean colourBean) throws Exception {
        OweLog pojo = colourBean.getPojo();
        OweLog dbItem = this.oweLogDAO.findByIdNoAutoCommit(colourBean.getPojo().getOweLogID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found OweLog " + colourBean.getPojo().getOweLogID());
//        Customer customer = dbItem.getCustomer();
        Integer dbDay = dbItem.getDayAllow();
        Timestamp time = dbItem.getType().equals(Constants.OWE_MINUS) ? dbItem.getPayDate() : dbItem.getOweDate();
        Double gap = pojo.getPay() - dbItem.getPay();
        dbItem.setPay(pojo.getPay());
        dbItem.setDayAllow(pojo.getDayAllow());
        if(dbItem.getType().equals(Constants.OWE_MINUS)){
            dbItem.setPayDate(pojo.getPayDate());
//            customer.setOwe(customer.getOwe() - gap);
//            if(customer.getLastPayDate().equals(time)){
//                customer.setLastPayDate(pojo.getPayDate());
//            }
        }else if(dbItem.getType().equals(Constants.OWE_PLUS)){
            dbItem.setOweDate(pojo.getOweDate());
//            customer.setOwe(customer.getOwe() + gap);
        }
//        customer.setDayAllow(pojo.getDayAllow());
        dbItem.setNote(pojo.getNote());
        this.oweLogDAO.update(dbItem);
//        this.customerDAO.update(customer);
    }

    @Override
    public void addNew(OweLogBean colourBean) throws DuplicateException {
        OweLog pojo = colourBean.getPojo();
        pojo = this.oweLogDAO.save(pojo);
        colourBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) throws ObjectNotFoundException {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                OweLog dbItem = this.oweLogDAO.findByIdNoAutoCommit(Long.parseLong(id));
                if (dbItem == null) throw new ObjectNotFoundException("Not found OweLog " + id);
//                Customer customer = dbItem.getCustomer();
//                if(dbItem.getType().equals(Constants.OWE_MINUS)){
//                    customer.setOwe(customer.getOwe() + dbItem.getPay());
//                }else if(dbItem.getType().equals(Constants.OWE_PLUS)){
//                    customer.setOwe(customer.getOwe() - dbItem.getPay());
//                }
//                customerDAO.update(customer);
                oweLogDAO.delete(dbItem);
            }
        }
        return res;
    }

    @Override
    public Object[] search(OweLogBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1 ");

        if (bean.getPojo().getCustomer() != null && bean.getPojo().getCustomer().getCustomerID() > 0) {
            properties.put("customer.customerID", bean.getPojo().getCustomer().getCustomerID());
        }
        if(SecurityUtils.userHasAuthority(Constants.NVKD_ROLE)){
            whereClause.append(" AND (createdBy.userID = ").append(SecurityUtils.getLoginUserId()).append(")");
//            whereClause.append(" OR customerID IN (SELECT uc.customer.customerID FROM UserCustomer uc WHERE uc.user.userID = ").append(SecurityUtils.getLoginUserId()).append("))");
        }

        if(bean.getFromDate() != null){
            whereClause.append(" AND (payDate >= '").append(bean.getFromDate()).append("'")
            .append(" OR oweDate >= '").append(bean.getFromDate()).append("')");
        }
        if(bean.getToDate() != null){
            whereClause.append(" AND payDate <= '").append(bean.getToDate()).append("'")
            .append(" OR oweDate <= '").append(bean.getToDate()).append("')");
        }
        if(bean.getSortExpression() == null){
            bean.setSortExpression("customer, createdDate");
        }
        if(bean.getSortDirection() == null){
            bean.setSortDirection("1");
        }
        return this.oweLogDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public Double findCustomerOweUtilDate(Long customerID, Date date) {
        return this.oweLogDAO.findCustomerOweUtilDate(customerID, date);
    }

    @Override
    public Map<Long,Double> findCustomersOweUtilDate(List<Long> customerIDs, Timestamp date) {
        return this.oweLogDAO.findCustomersOweUtilDate(customerIDs, date);
    }

    @Override
    public List<OweLog> findPrePaidByBill(Long bookProductBillID) {
        return this.oweLogDAO.findPrePaidByBill(bookProductBillID);
    }
}