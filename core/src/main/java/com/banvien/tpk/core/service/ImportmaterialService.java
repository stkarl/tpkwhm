package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Importmaterial;
import com.banvien.tpk.core.dto.ImportMaterialDataDTO;
import com.banvien.tpk.core.dto.ImportmaterialBean;
import com.banvien.tpk.core.dto.SearchMaterialBean;
import com.banvien.tpk.core.dto.SelectedItemDTO;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface ImportmaterialService extends GenericService<Importmaterial,Long> {

    void updateItem(ImportmaterialBean ImportmaterialBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ImportmaterialBean ImportmaterialBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    List<Importmaterial> findAllSortAsc();

    Object[] search(ImportmaterialBean bean);

    List<Importmaterial> findAvailableMaterialByWarehouse(Long warehouseID);

    Object[] searchMaterialsInStock(SearchMaterialBean bean);

    Object[] importMaterialData2DB(List<ImportMaterialDataDTO> importedDatas, Long loginUserId);

    List<Importmaterial> findWarningMaterial(Long warehouseID);

    void updateMaterialLocation(List<SelectedItemDTO> selectedItems,Long userID);
}