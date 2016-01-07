package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.MaterialAndCategoryDAO;
import com.banvien.tpk.core.domain.Customer;
import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.domain.MaterialAndCategory;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MaterialAndCategoryServiceImpl extends GenericServiceImpl<MaterialAndCategory,Long>
                                                    implements MaterialAndCategoryService {

    protected final Log logger = LogFactory.getLog(getClass());

    private MaterialAndCategoryDAO materialCategoryDAO;

    public void setMaterialAndCategoryDAO(MaterialAndCategoryDAO materialCategoryDAO) {
        this.materialCategoryDAO = materialCategoryDAO;
    }


    @Override
	protected GenericDAO<MaterialAndCategory, Long> getGenericDAO() {
		return materialCategoryDAO;
	}
    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                materialCategoryDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public void deleteItem(Long materialCategoryID) throws ObjectNotFoundException {
        materialCategoryDAO.delete(materialCategoryID);
    }

    @Override
    public List<MaterialAndCategory> findByMaterialID(Long userID) {
        return this.materialCategoryDAO.findByMaterialID(userID);
    }
}