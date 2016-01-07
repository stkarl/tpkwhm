package com.banvien.tpk.core.domain;

import java.io.Serializable;


/**
 * <p>Pojo mapping TABLE colour</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class MachineComponentPicture implements Serializable {

	/**
	 * Attribute colourID.
	 */
	private Long machineComponentPictureID;

	/**
	 * Attribute name.
	 */
	private String path;

	/**
	 * Attribute code.
	 */
	private String des;

	/**
	 * Attribute sign.
	 */
	private Machinecomponent machinecomponent;

	public Long getMachineComponentPictureID() {
		return machineComponentPictureID;
	}

	public void setMachineComponentPictureID(Long machineComponentPictureID) {
		this.machineComponentPictureID = machineComponentPictureID;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public Machinecomponent getMachinecomponent() {
		return machinecomponent;
	}

	public void setMachinecomponent(Machinecomponent machinecomponent) {
		this.machinecomponent = machinecomponent;
	}
}

