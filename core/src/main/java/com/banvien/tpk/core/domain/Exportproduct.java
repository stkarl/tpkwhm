package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE exportproduct</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Exportproduct implements Serializable {

	/**
	 * Attribute exportProductID.
	 */
	private Long exportProductID;
	
	/**
	 * Attribute exportproductbill
	 */
	 private Exportproductbill exportproductbill;
	/**
	 * Attribute note.
	 */
	private String note;

    private Importproduct importproduct;

    public Importproduct getImportproduct() {
        return importproduct;
    }

    public void setImportproduct(Importproduct importproduct) {
        this.importproduct = importproduct;
    }

    /**
	 * <p> 
	 * </p>
	 * @return exportProductID
	 */
	public Long getExportProductID() {
		return exportProductID;
	}

	/**
	 * @param exportProductID new value for exportProductID 
	 */
	public void setExportProductID(Long exportProductID) {
		this.exportProductID = exportProductID;
	}
	
	/**
	 * get exportproductbill
	 */
	public Exportproductbill getExportproductbill() {
		return this.exportproductbill;
	}
	
	/**
	 * set exportproductbill
	 */
	public void setExportproductbill(Exportproductbill exportproductbill) {
		this.exportproductbill = exportproductbill;
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

}