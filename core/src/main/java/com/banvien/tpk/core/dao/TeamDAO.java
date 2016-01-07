package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.Team;

import java.util.List;

/**
 * <p>Generic DAO layer for Teams</p>
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public interface TeamDAO extends GenericDAO<Team,Long> {

	/*
	 * TODO : Add specific businesses daos here.
	 * These methods will be overwrited if you re-generate this interface.
	 * You might want to extend this interface and to change the dao factory to return 
	 * an instance of the new implemenation in buildTeamDAO()
	 */
	  	 
	/**
	 * Find Team by name
	 */
	public List<Team> findByName(String name);

}