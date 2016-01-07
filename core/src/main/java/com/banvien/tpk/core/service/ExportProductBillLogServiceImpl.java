package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ExportProductBillLogDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.ExportProductBillLog;
import com.banvien.tpk.core.dto.ExportProductBillLogBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class ExportProductBillLogServiceImpl extends GenericServiceImpl<ExportProductBillLog,Long>
                                                    implements ExportProductBillLogService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ExportProductBillLogDAO ExportProductBillLogDAO;

    public void setExportProductBillLogDAO(ExportProductBillLogDAO ExportProductBillLogDAO) {
        this.ExportProductBillLogDAO = ExportProductBillLogDAO;
    }

    @Override
	protected GenericDAO<ExportProductBillLog, Long> getGenericDAO() {
		return ExportProductBillLogDAO;
	}

    @Override
    public void updateItem(ExportProductBillLogBean colourBean) throws ObjectNotFoundException, DuplicateException {
        ExportProductBillLog dbItem = this.ExportProductBillLogDAO.findByIdNoAutoCommit(colourBean.getPojo().getExportProductBillLogID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found ExportProductBillLog " + colourBean.getPojo().getExportProductBillLogID());

        ExportProductBillLog pojo = colourBean.getPojo();

        this.ExportProductBillLogDAO.detach(dbItem);
        this.ExportProductBillLogDAO.update(pojo);
    }

    @Override
    public void addNew(ExportProductBillLogBean colourBean) throws DuplicateException {
        ExportProductBillLog pojo = colourBean.getPojo();
        pojo = this.ExportProductBillLogDAO.save(pojo);
        colourBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                ExportProductBillLogDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ExportProductBillLogBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        return this.ExportProductBillLogDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}