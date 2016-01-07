package com.banvien.tpk.core.domain;

import java.io.Serializable;


/**
 * <p>Pojo mapping TABLE bookproduct</p>
 * <p></p>
 *
 * <p>Generated at Tue Feb 18 21:28:55 ICT 2014</p>
 * @author Salto-db Generator v1.0.16 / Hibernate pojos and xml mapping files.
 * 
 */
public class BookProduct implements Serializable {

	private Long bookProductID;
	 private BookProductBill bookProductBill;
	private String note;
    private Importproduct importProduct;

    public Long getBookProductID() {
        return bookProductID;
    }

    public void setBookProductID(Long bookProductID) {
        this.bookProductID = bookProductID;
    }

    public BookProductBill getBookProductBill() {
        return bookProductBill;
    }

    public void setBookProductBill(BookProductBill bookProductBill) {
        this.bookProductBill = bookProductBill;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Importproduct getImportProduct() {
        return importProduct;
    }

    public void setImportProduct(Importproduct importProduct) {
        this.importProduct = importProduct;
    }
}