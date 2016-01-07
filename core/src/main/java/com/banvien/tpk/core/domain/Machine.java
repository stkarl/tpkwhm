package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE machine</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Machine implements Serializable {

	/**
	 * Attribute machineID.
	 */
	private Long machineID;
	
	/**
	 * Attribute name.
	 */
	private String name;
	
	/**
	 * Attribute code.
	 */
	private String code;
	
	/**
	 * Attribute description.
	 */
	private String description;
	
	/**
	 * Attribute lastMaintenanceDate.
	 */
	private Timestamp lastMaintenanceDate;
	
	/**
	 * Attribute nextMaintenance.
	 */
	private Integer nextMaintenance;
	
	/**
	 * Attribute status.
	 */
	private Integer status;
	
	/**
	 * Attribute warehouse
	 */
	 private Warehouse warehouse;	

	/**
	 * List of Machinecomponent
	 */
	private List<Machinecomponent> machinecomponents = null;

    private List<Maintenancehistory> maintenancehistories;

    private Integer reserve;

    private Timestamp boughtDate;

    private Timestamp needMaintainDate;

    private Maintenancehistory latestMaintenance;


    private Integer confirmStatus;
    private User leader;
    private User chief;

    private User createdBy;

	private List<MachinePicture> machinePictures;

	public List<MachinePicture> getMachinePictures() {
		return machinePictures;
	}

	public void setMachinePictures(List<MachinePicture> machinePictures) {
		this.machinePictures = machinePictures;
	}

	public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public Integer getConfirmStatus() {
        return confirmStatus;
    }

    public void setConfirmStatus(Integer confirmStatus) {
        this.confirmStatus = confirmStatus;
    }

    public User getLeader() {
        return leader;
    }

    public void setLeader(User leader) {
        this.leader = leader;
    }

    public User getChief() {
        return chief;
    }

    public void setChief(User chief) {
        this.chief = chief;
    }

    public Maintenancehistory getLatestMaintenance() {
        return latestMaintenance;
    }

    public void setLatestMaintenance(Maintenancehistory latestMaintenance) {
        this.latestMaintenance = latestMaintenance;
    }

    public List<Maintenancehistory> getMaintenancehistories() {
        return maintenancehistories;
    }

    public void setMaintenancehistories(List<Maintenancehistory> maintenancehistories) {
        this.maintenancehistories = maintenancehistories;
    }

    public Timestamp getNeedMaintainDate() {
        return needMaintainDate;
    }

    public void setNeedMaintainDate(Timestamp needMaintainDate) {
        this.needMaintainDate = needMaintainDate;
    }

    public Integer getReserve() {
        return reserve;
    }

    public void setReserve(Integer reserve) {
        this.reserve = reserve;
    }

    public Timestamp getBoughtDate() {
        return boughtDate;
    }

    public void setBoughtDate(Timestamp boughtDate) {
        this.boughtDate = boughtDate;
    }

    /**
	 * <p> 
	 * </p>
	 * @return machineID
	 */
	public Long getMachineID() {
		return machineID;
	}

	/**
	 * @param machineID new value for machineID 
	 */
	public void setMachineID(Long machineID) {
		this.machineID = machineID;
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
	
	/**
	 * <p> 
	 * </p>
	 * @return code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code new value for code 
	 */
	public void setCode(String code) {
		this.code = code;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description new value for description 
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return lastMaintenanceDate
	 */
	public Timestamp getLastMaintenanceDate() {
		return lastMaintenanceDate;
	}

	/**
	 * @param lastMaintenanceDate new value for lastMaintenanceDate 
	 */
	public void setLastMaintenanceDate(Timestamp lastMaintenanceDate) {
		this.lastMaintenanceDate = lastMaintenanceDate;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return nextMaintenance
	 */
	public Integer getNextMaintenance() {
		return nextMaintenance;
	}

	/**
	 * @param nextMaintenance new value for nextMaintenance 
	 */
	public void setNextMaintenance(Integer nextMaintenance) {
		this.nextMaintenance = nextMaintenance;
	}
	
	/**
	 * <p> 
	 * </p>
	 * @return status
	 */
	public Integer getStatus() {
		return status;
	}

	/**
	 * @param status new value for status 
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	/**
	 * get warehouse
	 */
	public Warehouse getWarehouse() {
		return this.warehouse;
	}
	
	/**
	 * set warehouse
	 */
	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}

	/**
	 * Get the list of Machinecomponent
	 */
	 public List<Machinecomponent> getMachinecomponents() {
	 	return this.machinecomponents;
	 }
	 
	/**
	 * Set the list of Machinecomponent
	 */
	 public void setMachinecomponents(List<Machinecomponent> machinecomponents) {
	 	this.machinecomponents = machinecomponents;
	 }


}