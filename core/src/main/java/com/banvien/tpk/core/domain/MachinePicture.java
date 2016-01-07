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
public class MachinePicture implements Serializable {

	/**
	 * Attribute colourID.
	 */
	private Long machinePictureID;

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
	private Machine machine;

	public Long getMachinePictureID() {
		return machinePictureID;
	}

	public void setMachinePictureID(Long machinePictureID) {
		this.machinePictureID = machinePictureID;
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

	public Machine getMachine() {
		return machine;
	}

	public void setMachine(Machine machine) {
		this.machine = machine;
	}
}

