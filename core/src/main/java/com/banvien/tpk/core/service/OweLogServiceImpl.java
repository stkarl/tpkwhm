package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.CustomerDAO;
import com.banvien.tpk.core.dao.OweLogDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.*;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.core.util.DateUtils;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.util.*;

public class OweLogServiceImpl extends GenericServiceImpl<OweLog,Long>
                                                    implements OweLogService {

    protected final Log logger = LogFactory.getLog(getClass());

    private OweLogDAO oweLogDAO;
    private CustomerDAO customerDAO;

    @Autowired
    private ImportproductService importProductService;

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

    @Override
    public List<OweByDateDTO> dailyOwe(DailyOweBean bean) {
        List<OweLog> oweLogs = this.oweLogDAO.find4DailyOweReport(bean.getFromDate(), bean.getToDate());
        return summaryByCustomer(oweLogs, bean.getFromDate(), bean.getToDate());
    }

    private List<OweByDateDTO> summaryByCustomer(List<OweLog> oweLogs, Date fromDate, Date toDate) {
        final String sToDate = DateUtils.date2String(toDate, "ddMMyyyy");
        Map<Long, OweByDateDTO> dailyOwe = computeDailyOwe(oweLogs);
        List<Long> customerIDs = new ArrayList<Long>(dailyOwe.keySet());
        Map<Long,Double> mapCustomerOwe = importProductService.getCustomerInitialOwe(customerIDs, fromDate);
        List<OweByDateDTO> salePerformanceDTOs = new ArrayList<OweByDateDTO>();
        for(Long cusId : dailyOwe.keySet()){
            OweByDateDTO oweByDateDTO = dailyOwe.get(cusId);
            if(mapCustomerOwe.get(cusId) != null){
                oweByDateDTO.setInitOwe(mapCustomerOwe.get(cusId));
            }
            oweByDateDTO.setFinalOwe(
                    oweByDateDTO.getInitOwe() + oweByDateDTO.getTotalBuy() - oweByDateDTO.getTotalPay()
            );
            salePerformanceDTOs.add(oweByDateDTO);
        }

//        Collections.sort(salePerformanceDTOs, new Comparator<OweByDateDTO>() {
//            public int compare(OweByDateDTO one, OweByDateDTO other) {
//                SalesByDateDTO oneSalesDate = one.getSalesByDates().get(one.getSalesman().getUserID() + "_" + sToDate);
//                Double oneSales = oneSalesDate != null ? oneSalesDate.getWeight() : 0d;
//                SalesByDateDTO otherSalesDate = other.getSalesByDates().get(other.getSalesman().getUserID() + "_" + sToDate);
//                Double otherSales = otherSalesDate != null ? otherSalesDate.getWeight() : 0d;
//                return otherSales.compareTo(oneSales) != 0 ? otherSales.compareTo(oneSales) : other.getTotalWeight().compareTo(one.getTotalWeight());
//            }
//        });
        return salePerformanceDTOs;
    }

    private Map<Long, OweByDateDTO> computeDailyOwe(List<OweLog> oweLogs) {
        Map<Long, OweByDateDTO> overallOwe = new HashMap<Long, OweByDateDTO>();
        String cusDate;
        for(OweLog log : oweLogs){
            Timestamp issueDate = log.getOweDate() != null ? log.getOweDate() : log.getPayDate();
            Customer customer = log.getCustomer();
            Long customerID  = customer.getCustomerID();
            cusDate = log.getCustomer().getCustomerID() + "_" + DateUtils.date2String(issueDate, "ddMMyyyy");

            OweByDateDTO oweByDateDTO = overallOwe.get(customerID);
            if(oweByDateDTO == null){
                oweByDateDTO = new OweByDateDTO(customer);
                DailyOweDTO dailyOweDTO = new DailyOweDTO(issueDate, customer);
                addOweByDate(oweByDateDTO, dailyOweDTO, log);

                Map<String, DailyOweDTO> mapCusOwe = new HashMap<String, DailyOweDTO>();
                mapCusOwe.put(cusDate, dailyOweDTO);
                oweByDateDTO.setOweByDates(mapCusOwe);
                overallOwe.put(customerID, oweByDateDTO);
            }else{
                DailyOweDTO dailyOweDTO = oweByDateDTO.getOweByDates().get(cusDate);
                if(dailyOweDTO == null){
                    dailyOweDTO = new DailyOweDTO(issueDate, customer );
                    addOweByDate(oweByDateDTO, dailyOweDTO, log);
                    oweByDateDTO.getOweByDates().put(cusDate, dailyOweDTO);
                }else{
                    addOweByDate(oweByDateDTO, dailyOweDTO, log);
                }
            }
        }
        return overallOwe;
    }

    private void addOweByDate(OweByDateDTO oweByDate, DailyOweDTO dailyOwe, OweLog log) {
        Double amount = log.getPay();
        boolean isPay = Constants.OWE_MINUS.equals(log.getType());
        if(isPay){
            dailyOwe.setPay(dailyOwe.getPay() + amount);
            oweByDate.setTotalPay(oweByDate.getTotalPay() + amount);
        }else{
            dailyOwe.setBuy(dailyOwe.getBuy() + amount);
            oweByDate.setTotalBuy(oweByDate.getTotalBuy() + amount);
        }
    }
}