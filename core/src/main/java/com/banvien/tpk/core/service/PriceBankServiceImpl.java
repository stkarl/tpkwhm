package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.PriceBankDAO;
import com.banvien.tpk.core.domain.*;
import com.banvien.tpk.core.dto.PriceBankBean;
import com.banvien.tpk.core.dto.PriceUpdateDTO;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PriceBankServiceImpl extends GenericServiceImpl<PriceBank,Long>
                                                    implements PriceBankService {

    protected final Log logger = LogFactory.getLog(getClass());

    private PriceBankDAO priceBankDAO;

    public void setPriceBankDAO(PriceBankDAO priceBankDAO) {
        this.priceBankDAO = priceBankDAO;
    }

    @Override
	protected GenericDAO<PriceBank, Long> getGenericDAO() {
		return priceBankDAO;
	}

    @Override
    public void updateItem(PriceBankBean bean) throws ObjectNotFoundException, DuplicateException {
        PriceBank dbItem = this.priceBankDAO.findByIdNoAutoCommit(bean.getPojo().getPriceBankID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found PriceBank " + bean.getPojo().getPriceBankID());
        Double value = bean.getPojo().getPrice() != null && bean.getPojo().getPrice() > 0 ? bean.getPojo().getPrice() : 0d;
        if(value > 0){
            dbItem.setPrice(value);
            this.priceBankDAO.update(dbItem);
        }
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                priceBankDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(PriceBankBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");
        if(SecurityUtils.getPrincipal().getWarehouseID() != null){
            properties.put("warehouse.warehouseID", SecurityUtils.getPrincipal().getWarehouseID());
        }

        if(bean.getSortExpression() == null){
            bean.setSortExpression("effectedDate");
        }
        if(bean.getSortDirection() == null){
            bean.setSortDirection("1");
        }
        return this.priceBankDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }


    @Override
    public void addNew (PriceBankBean bean) throws DuplicateException{
        if(bean.getPriceUpdates() != null && bean.getPriceUpdates().size() > 0){
            for(PriceUpdateDTO priceUpdateDTO : bean.getPriceUpdates()){
//                Long productNameID = priceUpdateDTO.getProductNameID() != null ? priceUpdateDTO.getProductNameID() : null;
                Double price = priceUpdateDTO.getPrice() != null && priceUpdateDTO.getPrice() > 0 ? priceUpdateDTO.getPrice() : null;
                Timestamp effectedDate = priceUpdateDTO.getEffectedDate() != null ? priceUpdateDTO.getEffectedDate()  : null;
//                if(productNameID != null && price != null && effectedDate != null){
//                    PriceBank priceBank = new PriceBank();
//                    priceBank.setPrice(price);
//                    priceBank.setEffectedDate(effectedDate);
//                    this.priceBankDAO.save(priceBank);
//                }
            }
        }
    }


}