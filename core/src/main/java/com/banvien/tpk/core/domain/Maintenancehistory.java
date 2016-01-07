package com.banvien.tpk.core.domain;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE maintenancehistory</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Maintenancehistory implements Serializable {

	/**
	 * Attribute maintenanceHistoryID.
	 */
	private Long maintenanceHistoryID;
	
	/**
	 * Attribute botcher.
	 */
	private String botcher;
	
	/**
	 * Attribute machine
	 */
	 private Machine machine;	

	/**
	 * Attribute machinecomponent
	 */
	 private Machinecomponent machinecomponent;	

	/**
	 * Attribute note.
	 */
	private String note;
	
	/**
	 * Attribute maintenanceDate.
	 */
	private Timestamp maintenanceDate;

    private Timestamp createdDate;

    private User createdBy;

    private Integer noDay;

    public Integer getNoDay() {
        return noDay;
    }

    public void setNoDay(Integer noDay) {
        this.noDay = noDay;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    /**
	 * <p> 
	 * </p>
	 * @return maintenanceHistoryID
	 */
	public Long getMaintenanceHistoryID() {
		return maintenanceHistoryID;
	}

	/**
	 * @param maintenanceHistoryID new value for maintenanceHistoryID 
	 */
	public void setMaintenanceHistoryID(Long maintenanceHistoryID) {
		this.maintenanceHistoryID = maintenanceHistoryID;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return botcher
	 */
	public String getBotcher() {
		return botcher;
	}

	/**
	 * @param botcher new value for botcher 
	 */
	public void setBotcher(String botcher) {
		this.botcher = botcher;
	}
	
	/**
	 * get machine
	 */
	public Machine getMachine() {
		return this.machine;
	}
	
	/**
	 * set machine
	 */
	public void setMachine(Machine machine) {
		this.machine = machine;
	}

	/**
	 * get machinecomponent
	 */
	public Machinecomponent getMachinecomponent() {
		return this.machinecomponent;
	}
	
	/**
	 * set machinecomponent
	 */
	public void setMachinecomponent(Machinecomponent machinecomponent) {
		this.machinecomponent = machinecomponent;
	}

	/**
	 * <p> 
	 * </p>
	 * @return note
	 */
	public String getNote() {
		return note;
	}

	/**
	 * @param note new value for note 
	 */
	public void setNote(String note) {
		this.note = note;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return maintenanceDate
	 */
	public Timestamp getMaintenanceDate() {
		return maintenanceDate;
	}

	/**
	 * @param maintenanceDate new value for maintenanceDate 
	 */
	public void setMaintenanceDate(Timestamp maintenanceDate) {
		this.maintenanceDate = maintenanceDate;
	}
	


}