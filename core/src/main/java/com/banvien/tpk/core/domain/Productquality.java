package com.banvien.tpk.core.domain;

import java.util.List;
import java.io.Serializable;
import java.sql.Timestamp;


/**
 * <p>Pojo mapping TABLE productquality</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class Productquality implements Serializable {

	/**
	 * Attribute productQualityID.
	 */
	private Long productQualityID;
	
	/**
	 * Attribute importproduct
	 */
	 private Importproduct importproduct;	

	/**
	 * Attribute quality
	 */
	 private Quality quality;	

	/**
	 * Attribute unit
	 */
	 private Unit unit1;

	/**
	 * Attribute quantity1.
	 */
	private Double quantity1;
	
	/**
	 * Attribute unit
	 */
	 private Unit unit2;

	/**
	 * Attribute quantity2.
	 */
	private Double quantity2;

    private Double price;


    private Double saleQuantity;

    private Double salePrice;

    public Double getSaleQuantity() {
        return saleQuantity;
    }

    public void setSaleQuantity(Double saleQuantity) {
        this.saleQuantity = saleQuantity;
    }

    public Double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(Double salePrice) {
        this.salePrice = salePrice;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    /**
	 * <p> 
	 * </p>
	 * @return productQualityID
	 */
	public Long getProductQualityID() {
		return productQualityID;
	}

	/**
	 * @param productQualityID new value for productQualityID 
	 */
	public void setProductQualityID(Long productQualityID) {
		this.productQualityID = productQualityID;
	}
	
	/**
	 * get importproduct
	 */
	public Importproduct getImportproduct() {
		return this.importproduct;
	}
	
	/**
	 * set importproduct
	 */
	public void setImportproduct(Importproduct importproduct) {
		this.importproduct = importproduct;
	}

	/**
	 * get quality
	 */
	public Quality getQuality() {
		return this.quality;
	}
	
	/**
	 * set quality
	 */
	public void setQuality(Quality quality) {
		this.quality = quality;
	}

	/**
	 * get unit
	 */
	public Unit getUnit1() {
		return this.unit1;
	}
	
	/**
	 * set unit
	 */
	public void setUnit1(Unit unit1) {
		this.unit1 = unit1;
	}

	/**
	 * <p> 
	 * </p>
	 * @return quantity1
	 */
	public Double getQuantity1() {
		return quantity1;
	}

	/**
	 * @param quantity1 new value for quantity1 
	 */
	public void setQuantity1(Double quantity1) {
		this.quantity1 = quantity1;
	}
	
	/**
	 * get unit
	 */
	public Unit getUnit2() {
		return this.unit2;
	}
	
	/**
	 * set unit
	 */
	public void setUnit2(Unit unit2) {
		this.unit2 = unit2;
	}

	/**
	 * <p> 
	 * </p>
	 * @return quantity2
	 */
	public Double getQuantity2() {
		return quantity2;
	}

	/**
	 * @param quantity2 new value for quantity2 
	 */
	public void setQuantity2(Double quantity2) {
		this.quantity2 = quantity2;
	}
	


}