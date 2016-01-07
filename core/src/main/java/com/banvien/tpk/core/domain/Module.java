package com.banvien.tpk.core.domain;

import java.io.Serializable;


/**
 * <p>Pojo mapping TABLE setting</p>
 * <p></p>
 *
 * <p>Generated at Tue Jul 10 16:04:17 ICT 2012</p>
 * @author Salto-db Generator v1.1 / Hibernate pojos and xml mapping files.
 * 
 */
public class Module implements Serializable {
    private Long moduleID;
    private String name;
    private String description;

    public Long getModuleID() {
        return moduleID;
    }

    public void setModuleID(Long moduleID) {
        this.moduleID = moduleID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}