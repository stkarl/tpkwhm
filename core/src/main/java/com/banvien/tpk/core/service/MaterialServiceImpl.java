package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.MaterialAndCategoryDAO;
import com.banvien.tpk.core.dao.MaterialDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.domain.MaterialAndCategory;
import com.banvien.tpk.core.domain.Materialcategory;
import com.banvien.tpk.core.dto.MaterialBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MaterialServiceImpl extends GenericServiceImpl<Material,Long>
                                                    implements MaterialService {

    protected final Log logger = LogFactory.getLog(getClass());

    private MaterialDAO MaterialDAO;

    public void setMaterialDAO(MaterialDAO MaterialDAO) {
        this.MaterialDAO = MaterialDAO;
    }

    private MaterialAndCategoryDAO materialAndCategoryDAO;

    public void setMaterialAndCategoryDAO(MaterialAndCategoryDAO materialAndCategoryDAO) {
        this.materialAndCategoryDAO = materialAndCategoryDAO;
    }

    @Override
	protected GenericDAO<Material, Long> getGenericDAO() {
		return MaterialDAO;
	}

    @Override
    public void updateItem(MaterialBean bean) throws ObjectNotFoundException, DuplicateException {
        Material dbItem = this.MaterialDAO.findByIdNoAutoCommit(bean.getPojo().getMaterialID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Material " + bean.getPojo().getMaterialID());
        List<MaterialAndCategory> dbMaterialAndCategories = dbItem.getMaterialAndCategories();
        Map<Long,MaterialAndCategory> mapMaterialCategory = new HashMap<Long, MaterialAndCategory>();
        if(dbMaterialAndCategories != null && dbMaterialAndCategories.size() > 0){
             for(MaterialAndCategory materialAndCategory : dbMaterialAndCategories){
                 mapMaterialCategory.put(materialAndCategory.getMaterialCategory().getMaterialCategoryID(),materialAndCategory);
             }
        }
        Material pojo = bean.getPojo();
        dbItem.setName(pojo.getName());
        dbItem.setCode(pojo.getCode());
        dbItem.setDescription(pojo.getDescription());
        dbItem.setUnit(pojo.getUnit());
        dbItem.setPrice(pojo.getPrice());
        this.MaterialDAO.update(dbItem);
        if(bean.getMaterialCategoryIDs() != null && bean.getMaterialCategoryIDs().size()>0){
            for(Long cateID : bean.getMaterialCategoryIDs()){
                if(mapMaterialCategory.size() > 0){
                    if(mapMaterialCategory.containsKey(cateID)){
                        dbMaterialAndCategories.remove(mapMaterialCategory.get(cateID));
                    }else{
                        saveMaterialAndCategory(pojo,cateID);
                    }
                }else{
                    saveMaterialAndCategory(pojo,cateID);
                }
            }
        }
        if(dbMaterialAndCategories != null && !dbMaterialAndCategories.isEmpty()){
            this.materialAndCategoryDAO.deleteAll(dbMaterialAndCategories);
        }
    }

    private void saveMaterialAndCategory(Material material, Long cateID){
        MaterialAndCategory materialAndCategory = new MaterialAndCategory();
        materialAndCategory.setMaterial(material);
        Materialcategory category = new Materialcategory();
        category.setMaterialCategoryID(cateID);
        materialAndCategory.setMaterialCategory(category);
        this.materialAndCategoryDAO.save(materialAndCategory);
    }

    @Override
    public void addNew(MaterialBean bean) throws DuplicateException {
        Material pojo = bean.getPojo();
        pojo = this.MaterialDAO.save(pojo);
        bean.setPojo(pojo);
        if(bean.getMaterialCategoryIDs() != null && bean.getMaterialCategoryIDs().size()>0){
            for(Long cateID : bean.getMaterialCategoryIDs()){
                saveMaterialAndCategory(pojo,cateID);
            }
        }
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                MaterialDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] searchByBean(MaterialBean bean) {
        return this.MaterialDAO.searchByBean(bean, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection());
    }

    @Override
    public List<Material> findByCateCode(String cateCode) {
        return this.MaterialDAO.findByCateCode(cateCode);
    }

    @Override
    public List<Material> findNoneMeasurement() {
        return this.MaterialDAO.findNoneMeasurement();
    }

    @Override
    public List<Material> findAssigned(Long userID) {
        return this.MaterialDAO.findAssigned(userID);
    }

}