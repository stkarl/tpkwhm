package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE material</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Material implements Serializable {
	private Long materialID;
	private String name;
	private String code;
	private String description;
    private Unit unit;
    private Double price;
    private Double warningQuantity;
    private List<MaterialAndCategory> materialAndCategories;

    public Double getWarningQuantity() {
        return warningQuantity;
    }

    public void setWarningQuantity(Double warningQuantity) {
        this.warningQuantity = warningQuantity;
    }

    public List<MaterialAndCategory> getMaterialAndCategories() {
        return materialAndCategories;
    }

    public void setMaterialAndCategories(List<MaterialAndCategory> materialAndCategories) {
        this.materialAndCategories = materialAndCategories;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Unit getUnit() {
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }

    /**
	 * <p> 
	 * </p>
	 * @return materialID
	 */
	public Long getMaterialID() {
		return materialID;
	}

	/**
	 * @param materialID new value for materialID 
	 */
	public void setMaterialID(Long materialID) {
		this.materialID = materialID;
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

}