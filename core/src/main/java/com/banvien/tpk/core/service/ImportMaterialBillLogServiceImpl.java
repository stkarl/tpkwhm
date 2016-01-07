package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.ImportMaterialBillLogDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.ImportMaterialBillLog;
import com.banvien.tpk.core.dto.ImportMaterialBillLogBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class ImportMaterialBillLogServiceImpl extends GenericServiceImpl<ImportMaterialBillLog,Long>
                                                    implements ImportMaterialBillLogService {

    protected final Log logger = LogFactory.getLog(getClass());

    private ImportMaterialBillLogDAO ImportMaterialBillLogDAO;

    public void setImportMaterialBillLogDAO(ImportMaterialBillLogDAO ImportMaterialBillLogDAO) {
        this.ImportMaterialBillLogDAO = ImportMaterialBillLogDAO;
    }

    @Override
	protected GenericDAO<ImportMaterialBillLog, Long> getGenericDAO() {
		return ImportMaterialBillLogDAO;
	}

    @Override
    public void updateItem(ImportMaterialBillLogBean colourBean) throws ObjectNotFoundException, DuplicateException {
        ImportMaterialBillLog dbItem = this.ImportMaterialBillLogDAO.findByIdNoAutoCommit(colourBean.getPojo().getImportMaterialBillLogID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found ImportMaterialBillLog " + colourBean.getPojo().getImportMaterialBillLogID());

        ImportMaterialBillLog pojo = colourBean.getPojo();

        this.ImportMaterialBillLogDAO.detach(dbItem);
        this.ImportMaterialBillLogDAO.update(pojo);
    }

    @Override
    public void addNew(ImportMaterialBillLogBean colourBean) throws DuplicateException {
        ImportMaterialBillLog pojo = colourBean.getPojo();
        pojo = this.ImportMaterialBillLogDAO.save(pojo);
        colourBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                ImportMaterialBillLogDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(ImportMaterialBillLogBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        return this.ImportMaterialBillLogDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}