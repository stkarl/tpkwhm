package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE product</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Product implements Serializable {

	/**
	 * Attribute productID.
	 */
	private Long productID;
	
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
	 * Attribute productname
	 */
	 private Productname productname;	

	/**
	 * Attribute size
	 */
	 private Size size;	

	/**
	 * Attribute colour
	 */
	 private Colour colour;	

	/**
	 * Attribute thickness
	 */
	 private Thickness thickness;	

	/**
	 * Attribute stiffness
	 */
	 private Stiffness stiffness;	

	/**
	 * Attribute overlaytype
	 */
	 private Overlaytype overlaytype;	

	
	/**
	 * <p> 
	 * </p>
	 * @return productID
	 */
	public Long getProductID() {
		return productID;
	}

	/**
	 * @param productID new value for productID 
	 */
	public void setProductID(Long productID) {
		this.productID = productID;
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
	 * get productname
	 */
	public Productname getProductname() {
		return this.productname;
	}
	
	/**
	 * set productname
	 */
	public void setProductname(Productname productname) {
		this.productname = productname;
	}

	/**
	 * get size
	 */
	public Size getSize() {
		return this.size;
	}
	
	/**
	 * set size
	 */
	public void setSize(Size size) {
		this.size = size;
	}

	/**
	 * get colour
	 */
	public Colour getColour() {
		return this.colour;
	}
	
	/**
	 * set colour
	 */
	public void setColour(Colour colour) {
		this.colour = colour;
	}

	/**
	 * get thickness
	 */
	public Thickness getThickness() {
		return this.thickness;
	}
	
	/**
	 * set thickness
	 */
	public void setThickness(Thickness thickness) {
		this.thickness = thickness;
	}

	/**
	 * get stiffness
	 */
	public Stiffness getStiffness() {
		return this.stiffness;
	}
	
	/**
	 * set stiffness
	 */
	public void setStiffness(Stiffness stiffness) {
		this.stiffness = stiffness;
	}

	/**
	 * get overlaytype
	 */
	public Overlaytype getOverlaytype() {
		return this.overlaytype;
	}
	
	/**
	 * set overlaytype
	 */
	public void setOverlaytype(Overlaytype overlaytype) {
		this.overlaytype = overlaytype;
	}


}