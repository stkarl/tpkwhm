package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.TeamDAO;
import com.banvien.tpk.core.domain.Team;
import com.banvien.tpk.core.dto.TeamBean;
import com.banvien.tpk.core.exception.DuplicateException;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.HashMap;
import java.util.Map;

public class TeamServiceImpl extends GenericServiceImpl<Team,Long>
                                                    implements TeamService {

    protected final Log logger = LogFactory.getLog(getClass());

    private TeamDAO TeamDAO;

    public void setTeamDAO(TeamDAO TeamDAO) {
        this.TeamDAO = TeamDAO;
    }

    @Override
	protected GenericDAO<Team, Long> getGenericDAO() {
		return TeamDAO;
	}

    @Override
    public void updateItem(TeamBean colourBean) throws ObjectNotFoundException, DuplicateException {
        Team dbItem = this.TeamDAO.findByIdNoAutoCommit(colourBean.getPojo().getTeamID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Team " + colourBean.getPojo().getTeamID());

        Team pojo = colourBean.getPojo();

        this.TeamDAO.detach(dbItem);
        this.TeamDAO.update(pojo);
    }

    @Override
    public void addNew(TeamBean colourBean) throws DuplicateException {
        Team pojo = colourBean.getPojo();
        pojo = this.TeamDAO.save(pojo);
        colourBean.setPojo(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                TeamDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public Object[] search(TeamBean bean) {
        Map<String, Object> properties = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(bean.getPojo().getName())) {
            properties.put("name", bean.getPojo().getName());
        }
        return this.TeamDAO.searchByProperties(properties, bean.getFirstItem(), bean.getMaxPageItems(), bean.getSortExpression(), bean.getSortDirection(), true);
    }
}