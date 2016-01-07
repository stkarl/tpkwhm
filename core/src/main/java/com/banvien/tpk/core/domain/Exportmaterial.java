package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE exportmaterial</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 *
 */
public class Exportmaterial implements Serializable {

    /**
     * Attribute exportMaterialID.
     */
    private Long exportMaterialID;

    /**
     * Attribute exportmaterialbill
     */
    private Exportmaterialbill exportmaterialbill;

    /**
     * Attribute material
     */
    private Importmaterial importmaterial;

    /**
     * Attribute quantity1.
     */
    private Double quantity;

    /**
     * Attribute note.
     */
    private String note;

    private Double previous;

    public Double getPrevious() {
        return previous;
    }

    public void setPrevious(Double previous) {
        this.previous = previous;
    }

    /**
     * <p>
     * </p>
     * @return exportMaterialID
     */
    public Long getExportMaterialID() {
        return exportMaterialID;
    }

    /**
     * @param exportMaterialID new value for exportMaterialID
     */
    public void setExportMaterialID(Long exportMaterialID) {
        this.exportMaterialID = exportMaterialID;
    }

    /**
     * get exportmaterialbill
     */
    public Exportmaterialbill getExportmaterialbill() {
        return this.exportmaterialbill;
    }

    /**
     * set exportmaterialbill
     */
    public void setExportmaterialbill(Exportmaterialbill exportmaterialbill) {
        this.exportmaterialbill = exportmaterialbill;
    }

    public Importmaterial getImportmaterial() {
        return importmaterial;
    }

    public void setImportmaterial(Importmaterial importmaterial) {
        this.importmaterial = importmaterial;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
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