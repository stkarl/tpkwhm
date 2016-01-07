package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Colour;
import com.banvien.tpk.core.dto.ColourBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.util.List;


public interface ColourService extends GenericService<Colour,Long> {

    void updateItem(ColourBean ColourBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(ColourBean ColourBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(ColourBean bean);

    List<Colour> findAllByOrder(String name);
}