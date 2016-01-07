package com.banvien.tpk.core.domain;

import java.io.Serializable;


/**
 * <p>Pojo mapping TABLE team</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Team implements Serializable {

	/**
	 * Attribute teamID.
	 */
	private Long teamID;
	
	/**
	 * Attribute name.
	 */
	private String name;

	/**
	 * <p> 
	 * </p>
	 * @return teamID
	 */
	public Long getTeamID() {
		return teamID;
	}

	/**
	 * @param teamID new value for teamID 
	 */
	public void setTeamID(Long teamID) {
		this.teamID = teamID;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name new value for name 
	 */
	public void setName(String name) {
		this.name = name;
	}

}