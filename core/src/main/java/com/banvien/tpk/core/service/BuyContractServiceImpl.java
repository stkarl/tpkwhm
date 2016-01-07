package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.BuyContractDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.ImportproductDAO;
import com.banvien.tpk.core.dao.ImportproductbillDAO;
import com.banvien.tpk.core.domain.BuyContract;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.Importproductbill;
import com.banvien.tpk.core.domain.User;
import com.banvien.tpk.core.dto.BuyContractBean;
import com.banvien.tpk.core.dto.BuyContractDTO;
import com.banvien.tpk.core.dto.ReportByContractBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BuyContractServiceImpl extends GenericServiceImpl<BuyContract,Long>
                                                    implements BuyContractService {

    protected final Log logger = LogFactory.getLog(getClass());

    private BuyContractDAO buyContractDAO;

    private ImportproductDAO importproductDAO;

    private ImportproductbillDAO importproductbillDAO;

    public void setImportproductDAO(ImportproductDAO importproductDAO) {
        this.importproductDAO = importproductDAO;
    }

    public void setImportproductbillDAO(ImportproductbillDAO importproductbillDAO) {
        this.importproductbillDAO = importproductbillDAO;
    }

    public void setBuyContractDAO(BuyContractDAO buyContractDAO) {
        this.buyContractDAO = buyContractDAO;
    }

    @Override
	protected GenericDAO<BuyContract, Long> getGenericDAO() {
		return buyContractDAO;
	}

    @Override
    public void updateItem(BuyContractBean buyContractBean) throws ObjectNotFoundException, DuplicateException {
        BuyContract dbItem = this.buyContractDAO.findByIdNoAutoCommit(buyContractBean.getPojo().getBuyContractID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found buyContract " + buyContractBean.getPojo().getBuyContractID());
        BuyContract pojo = buyContractBean.getPojo();
        dbItem.setCode(pojo.getCode());
        dbItem.setCustomer(pojo.getCustomer());
        dbItem.setNoRoll(pojo.getNoRoll());
        dbItem.setWeight(pojo.getWeight());
        dbItem.setDate(pojo.getDate());
        this.buyContractDAO.update(dbItem);
    }

    @Override
    public void addNew(BuyContractBean buyContractBean) throws DuplicateException {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        User loginUser = new User();
        loginUser.setUserID(buyContractBean.getLoginID());
        BuyContract pojo = buyContractBean.getPojo();
        pojo.setCreatedDate(now);
        pojo.setCreatedBy(loginUser);
        pojo = this.buyContractDAO.save(pojo);
        buyContractBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                    buyContractDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(BuyContractBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer();
        return this.buyContractDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

    @Override
    public List<BuyContractDTO> reportImportByContract(ReportByContractBean bean) {
//        List<BuyContractDTO> buyContracts = this.buyContractDAO.findBuyContracts(bean.getFromDate(), bean.getToDate(), bean.getCustomerID());
//        buyContracts = crossOutDuplicate(buyContracts);
//        List<Importproductbill> importproductbills = this.importproductbillDAO.find4Contract(bean.getFromDate(),bean.getToDate(),bean.getCustomerID());
//        summaryBillByContract(buyContracts, importproductbills);
//        calTotalImportedByContract(buyContracts);
        List<BuyContract> buyContractList = this.buyContractDAO.findBuyContractList(bean.getFromDate(), bean.getToDate(), bean.getCustomerID());
        List<BuyContractDTO> buyContracts = calTotalImportedByContract2(buyContractList);
        return buyContracts;
    }

    private List<BuyContractDTO> calTotalImportedByContract2(List<BuyContract> buyContractList) {
        List<BuyContractDTO> buyContracts = new ArrayList<BuyContractDTO>();
        if(buyContractList != null){
            for(BuyContract buyContract : buyContractList){
                BuyContractDTO buyContractDTO = new BuyContractDTO(buyContract);
                List<Importproduct> importproducts = new ArrayList<Importproduct>();
                Double totalWeight = 0d;
                Double totalMoney = 0d;
                if(buyContract.getImportProductBills() != null){
                    for(Importproductbill importproductbill : buyContract.getImportProductBills()){
                        if(importproductbill.getImportproducts() != null){
                            importproducts.addAll(importproductbill.getImportproducts());
                            for(Importproduct importproduct : importproductbill.getImportproducts()){
                                totalWeight += importproduct.getQuantity2Pure() != null ? importproduct.getQuantity2Pure() : 0d;
                            }
                        }
                        totalMoney += importproductbill.getTotalMoney() != null ? importproductbill.getTotalMoney() : 0d;
                    }
                }
                buyContractDTO.setImportProducts(importproducts);
                buyContractDTO.setTotalWeight(totalWeight);
                buyContractDTO.setTotalMoney(totalMoney);
                buyContracts.add(buyContractDTO);
            }
        }
        return buyContracts;
    }

    private List<BuyContractDTO> crossOutDuplicate(List<BuyContractDTO> buyContracts) {
        Map<Long,BuyContractDTO> map = new HashMap<Long, BuyContractDTO>();
        if(buyContracts != null){
            for(BuyContractDTO buyContractDTO : buyContracts){
                if(!map.containsKey(buyContractDTO.getBuyContractID())){
                    map.put(buyContractDTO.getBuyContractID(), buyContractDTO);
                }else if(buyContractDTO.getEndDate() != null) {
                    map.put(buyContractDTO.getBuyContractID(), buyContractDTO);
                }
            }
        }
        return new ArrayList<BuyContractDTO>(map.values());
    }


    private void summaryBillByContract(List<BuyContractDTO> buyContracts, List<Importproductbill> importproductbills) {
        if(buyContracts != null){
            Map<Long,List<Importproductbill>> mapCustomerProducts = new HashMap<Long, List<Importproductbill>>();
            if(importproductbills != null){
                for(Importproductbill importproductbill : importproductbills){
                    Long customerID = importproductbill.getCustomer().getCustomerID();
                    List<Importproductbill> importproductbillList = mapCustomerProducts.get(customerID);
                    if(importproductbillList != null){
                        importproductbillList.add(importproductbill);
                    }else {
                        importproductbillList = new ArrayList<Importproductbill>();
                        importproductbillList.add(importproductbill);
                        mapCustomerProducts.put(customerID,importproductbillList);
                    }
                }
            }

            for(BuyContractDTO buyContractDTO : buyContracts){
                List<Importproductbill> bills = new ArrayList<Importproductbill>();
                Timestamp startContract = buyContractDTO.getStartDate();
                Timestamp endContract = buyContractDTO.getEndDate();
                Long customerID = buyContractDTO.getCustomerID();
                if(mapCustomerProducts.get(customerID) != null){
                    for(Importproductbill importproductbill : mapCustomerProducts.get(customerID)){
                        Timestamp billDate = importproductbill.getImportDate();
                        if(endContract != null){
                            if(billDate.getTime() >= startContract.getTime() && billDate.getTime() <= startContract.getTime()){
                                bills.add(importproductbill);
                            }
                        }else {
                            if(billDate.getTime() >= startContract.getTime()){
                                bills.add(importproductbill);
                            }
                        }
                    }
                }
                buyContractDTO.setImportProductBills(bills);
            }
        }
    }

    private void calTotalImportedByContract(List<BuyContractDTO> buyContracts) {
        if(buyContracts != null){
            for(BuyContractDTO buyContractDTO : buyContracts){
                List<Importproduct> importproducts = new ArrayList<Importproduct>();
                Double totalWeight = 0d;
                Double totalMoney = 0d;
                if(buyContractDTO.getImportProductBills() != null){
                    for(Importproductbill importproductbill : buyContractDTO.getImportProductBills()){
                        if(importproductbill.getImportproducts() != null){
                            importproducts.addAll(importproductbill.getImportproducts());
                            for(Importproduct importproduct : importproductbill.getImportproducts()){
                                totalWeight += importproduct.getQuantity2Pure() != null ? importproduct.getQuantity2Pure() : 0d;
                            }
                        }
                        totalMoney += importproductbill.getTotalMoney() != null ? importproductbill.getTotalMoney() : 0d;
                    }
                }
                buyContractDTO.setImportProducts(importproducts);
                buyContractDTO.setTotalWeight(totalWeight);
                buyContractDTO.setTotalMoney(totalMoney);

            }
        }
    }
}