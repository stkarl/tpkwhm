package com.banvien.tpk.core.dto;

import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.domain.Productname;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.Serializable;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Chu Quoc Khanh
 * Date: 19/03/14
 * Time: 22:16
 * To change this template use File | Settings | File Templates.
 */
public class ProducedProductDTO implements Serializable {
    private transient final Log log = LogFactory.getLog(getClass());

    private Importproduct mainMaterial;
    private List<Importproduct> producedProducts;
    private Double productsKg;
    private Double productsM2;
    private Double totalStick;

    // 4 calculate cost report
    private Double totalProduced;
    private Productname productname;

    public ProducedProductDTO() {
    }

    public ProducedProductDTO(Importproduct mainMaterial, List<Importproduct> producedProducts, Double productsKg, Double productsM2, Double totalStick, Double totalProduced, Productname productname) {
        this.mainMaterial = mainMaterial;
        this.producedProducts = producedProducts;
        this.productsKg = productsKg;
        this.productsM2 = productsM2;
        this.totalStick = totalStick;
        this.totalProduced = totalProduced;
        this.productname = productname;
    }

    public ProducedProductDTO(ProducedProductDTO producedProductDTO) {
        this.mainMaterial = producedProductDTO.getMainMaterial();
        this.producedProducts = producedProductDTO.getProducedProducts();
        this.productsKg = producedProductDTO.getProductsKg();
        this.productsM2 = producedProductDTO.getProductsM2();
        this.totalStick = producedProductDTO.getTotalStick();
        this.totalProduced = producedProductDTO.getTotalProduced();
        this.productname = producedProductDTO.getProductname();
    }

    public Double getProductsKg() {
        return productsKg;
    }

    public void setProductsKg(Double productsKg) {
        this.productsKg = productsKg;
    }

    public Double getProductsM2() {
        return productsM2;
    }

    public void setProductsM2(Double productsM2) {
        this.productsM2 = productsM2;
    }

    public Double getTotalStick() {
        return totalStick;
    }

    public void setTotalStick(Double totalStick) {
        this.totalStick = totalStick;
    }

    public Importproduct getMainMaterial() {
        return mainMaterial;
    }

    public void setMainMaterial(Importproduct mainMaterial) {
        this.mainMaterial = mainMaterial;
    }

    public List<Importproduct> getProducedProducts() {
        return producedProducts;
    }

    public void setProducedProducts(List<Importproduct> producedProducts) {
        this.producedProducts = producedProducts;
    }

    public Double getTotalProduced() {
        return totalProduced;
    }

    public void setTotalProduced(Double totalProduced) {
        this.totalProduced = totalProduced;
    }

    public Productname getProductname() {
        return productname;
    }

    public void setProductname(Productname productname) {
        this.productname = productname;
    }
}
