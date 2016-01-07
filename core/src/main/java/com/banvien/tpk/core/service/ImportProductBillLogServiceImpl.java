package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ImportProductBillLogDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.ImportProductBillLog;
import com.banvien.tpk.core.dto.ImportProductBillLogBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class ImportProductBillLogServiceImpl extends GenericServiceImpl<ImportProductBillLog,Long>
                                                    implements ImportProductBillLogService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ImportProductBillLogDAO ImportProductBillLogDAO;

    public void setImportProductBillLogDAO(ImportProductBillLogDAO ImportProductBillLogDAO) {
        this.ImportProductBillLogDAO = ImportProductBillLogDAO;
    }

    @Override
	protected GenericDAO<ImportProductBillLog, Long> getGenericDAO() {
		return ImportProductBillLogDAO;
	}

    @Override
    public void updateItem(ImportProductBillLogBean colourBean) throws ObjectNotFoundException, DuplicateException {
        ImportProductBillLog dbItem = this.ImportProductBillLogDAO.findByIdNoAutoCommit(colourBean.getPojo().getImportProductBillLogID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found ImportProductBillLog " + colourBean.getPojo().getImportProductBillLogID());

        ImportProductBillLog pojo = colourBean.getPojo();

        this.ImportProductBillLogDAO.detach(dbItem);
        this.ImportProductBillLogDAO.update(pojo);
    }

    @Override
    public void addNew(ImportProductBillLogBean colourBean) throws DuplicateException {
        ImportProductBillLog pojo = colourBean.getPojo();
        pojo = this.ImportProductBillLogDAO.save(pojo);
        colourBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                ImportProductBillLogDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ImportProductBillLogBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        return this.ImportProductBillLogDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}