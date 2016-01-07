package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ArrangementDAO;
import com.banvien.tpk.core.dao.ArrangementDetailDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Arrangement;
import com.banvien.tpk.core.domain.ArrangementDetail;
import com.banvien.tpk.core.dto.ArrangementBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ArrangementServiceImpl extends GenericServiceImpl<Arrangement,Long>
                                                    implements ArrangementService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ArrangementDAO arrangementDAO;

    public void setArrangementDAO(ArrangementDAO arrangementDAO) {
        this.arrangementDAO = arrangementDAO;
    }
    private ArrangementDetailDAO arrangementDetailDAO;

    public void setArrangementDetailDAO(ArrangementDetailDAO arrangementDetailDAO) {
        this.arrangementDetailDAO = arrangementDetailDAO;
    }

    @Override
	protected GenericDAO<Arrangement, Long> getGenericDAO() {
		return arrangementDAO;
	}

    @Override
    public void updateItem(ArrangementBean bean) throws ObjectNotFoundException, DuplicateException {
        Arrangement dbItem = this.arrangementDAO.findByIdNoAutoCommit(bean.getPojo().getArrangementID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Arrangement " + bean.getPojo().getArrangementID());
        List<ArrangementDetail> dbArrangementDetails = dbItem.getArrangementDetails();

        Arrangement pojo = bean.getPojo();
        dbItem.setFromDate(pojo.getFromDate());
        dbItem.setToDate(pojo.getToDate());
        dbItem.setAverage(pojo.getAverage());
        dbItem.setTotalBlack(pojo.getTotalBlack());
        dbItem = this.arrangementDAO.update(dbItem);

        if(bean.getArrangementDetails() != null){
            for(ArrangementDetail detail : bean.getArrangementDetails()){
                if(detail.getFixExpense() != null && detail.getFixExpense().getFixExpenseID() != null && detail.getValue() != null){
                    ArrangementDetail arrangementDetail = null;
                    if(dbArrangementDetails != null){
                        for(int i = dbArrangementDetails.size() - 1; i >= 0; i--){
                            ArrangementDetail dbArrangementDetail = dbArrangementDetails.get(i);
                            if(detail.getFixExpense().getFixExpenseID().equals(dbArrangementDetail.getFixExpense().getFixExpenseID())){
                                arrangementDetail = dbArrangementDetail;
                                dbArrangementDetails.remove(i);
                                break;
                            }
                        }
                        if(arrangementDetail == null){
                            arrangementDetail = new ArrangementDetail();
                        }
                        saveOrUpdateDetail(dbItem, arrangementDetail, detail);
                    }else {
                        arrangementDetail = new ArrangementDetail();
                        saveOrUpdateDetail(dbItem, arrangementDetail, detail);
                    }
                }
            }

            if(dbArrangementDetails != null && !dbArrangementDetails.isEmpty()){
                this.arrangementDetailDAO.deleteAll(dbArrangementDetails);
            }
        }
    }

    private void saveOrUpdateDetail(Arrangement arrangement, ArrangementDetail arrangementDetail, ArrangementDetail detail) {
        arrangementDetail.setValue(detail.getValue());
        if(arrangementDetail.getArrangementDetailID() == null){
            arrangementDetail.setArrangement(arrangement);
            arrangementDetail.setFixExpense(detail.getFixExpense());
        }
        this.arrangementDetailDAO.saveOrUpdate(arrangementDetail);
    }

    @Override
    public void addNew(ArrangementBean bean) throws DuplicateException {
        Arrangement pojo = bean.getPojo();
        pojo = this.arrangementDAO.save(pojo);
        if(bean.getArrangementDetails() != null){
            for(ArrangementDetail detail : bean.getArrangementDetails()){
                if(detail.getFixExpense() != null && detail.getFixExpense().getFixExpenseID() != null && detail.getValue() != null){
                    detail.setArrangement(pojo);
                    this.arrangementDetailDAO.save(detail);
                }
            }
        }
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                arrangementDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ArrangementBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1");


        if(bean.getFromDate() != null){
            whereClause.append(" AND fromDate >= '").append(bean.getFromDate()).append("'");
        }
        if(bean.getToDate() != null){
            whereClause.append(" AND toDate <= '").append(bean.getToDate()).append("'");
        }

        if(bean.getSortExpression() == null &&  bean.getSortDirection() == null){
            bean.setSortExpression("fromDate");
            bean.setSortDirection("1");
        }

        return this.arrangementDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true, whereClause.toString());
    }

}