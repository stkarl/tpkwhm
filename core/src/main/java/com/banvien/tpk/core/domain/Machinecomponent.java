package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE machinecomponent</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Machinecomponent implements Serializable {

	/**
	 * Attribute machineComponentID.
	 */
	private Long machineComponentID;
	
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
	 * Attribute machine
	 */
	 private Machine machine;

    private Integer reserve;

    private Timestamp needMaintainDate;

    private List<Maintenancehistory> maintenancehistories;

    private String groupCode;
    private Maintenancehistory latestMaintenance;

    private Machinecomponent parent;
    private Integer confirmStatus;
    private User leader;
    private User chief;

    private User createdBy;

    private List<MachineComponentPicture> machineComponentPictures;

    public List<MachineComponentPicture> getMachineComponentPictures() {
        return machineComponentPictures;
    }

    public void setMachineComponentPictures(List<MachineComponentPicture> machineComponentPictures) {
        this.machineComponentPictures = machineComponentPictures;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    private List<Machinecomponent> childComponents;

    public List<Machinecomponent> getChildComponents() {
        return childComponents;
    }

    public void setChildComponents(List<Machinecomponent> childComponents) {
        this.childComponents = childComponents;
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

    public Machinecomponent getParent() {
        return parent;
    }

    public void setParent(Machinecomponent parent) {
        this.parent = parent;
    }

    public Maintenancehistory getLatestMaintenance() {
        return latestMaintenance;
    }

    public void setLatestMaintenance(Maintenancehistory latestMaintenance) {
        this.latestMaintenance = latestMaintenance;
    }

    public Machinecomponent() {
    }

    public Machinecomponent(String componentName, String componentCode, String componentDescription, Machine machine, Integer status) {
        this.machine = machine;
        this.name = componentName;
        this.code = componentCode;
        this.description = componentDescription;
        this.status = status;
    }

    public String getGroupCode() {
        return groupCode;
    }

    public void setGroupCode(String groupCode) {
        this.groupCode = groupCode;
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

    /**
	 * <p> 
	 * </p>
	 * @return machineComponentID
	 */
	public Long getMachineComponentID() {
		return machineComponentID;
	}

	/**
	 * @param machineComponentID new value for machineComponentID 
	 */
	public void setMachineComponentID(Long machineComponentID) {
		this.machineComponentID = machineComponentID;
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


}