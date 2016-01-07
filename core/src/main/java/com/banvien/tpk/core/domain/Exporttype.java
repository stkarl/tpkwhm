package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE exporttype</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Exporttype implements Serializable {

	/**
	 * Attribute exportTypeID.
	 */
	private Long exportTypeID;
	
	/**
	 * Attribute name.
	 */
	private String name;

    private String code;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    /**
	 * <p> 
	 * </p>
	 * @return exportTypeID
	 */
	public Long getExportTypeID() {
		return exportTypeID;
	}

	/**
	 * @param exportTypeID new value for exportTypeID 
	 */
	public void setExportTypeID(Long exportTypeID) {
		this.exportTypeID = exportTypeID;
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