package com.banvien.tpk.core.service;

import com.banvien.tpk.core.domain.Team;
import com.banvien.tpk.core.dto.TeamBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;


public interface TeamService extends GenericService<Team,Long> {

    void updateItem(TeamBean TeamBean) throws ObjectNotFoundException, DuplicateException;

    void addNew(TeamBean TeamBean) throws DuplicateException;

    Integer deleteItems(String[] checkList);

    Object[] search(TeamBean bean);
}