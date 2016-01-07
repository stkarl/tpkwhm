package com.banvien.tpk.core.util;

import com.banvien.tpk.core.domain.Importmaterial;
import com.banvien.tpk.core.domain.Importproduct;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;

import java.text.DecimalFormat;
import java.text.Normalizer;

public class StringUtil
{
    public static String convertStringNotUTF8(String stringInput)
    {
        stringInput = removeDiacritic(stringInput);
        stringInput = stringInput.replaceAll(" ", "");
        stringInput = stringInput.toLowerCase();
        return stringInput;
    }

    public static String removeDiacritic(String str) {
        String result = Normalizer.normalize(str, Normalizer.Form.NFD);
        result = result.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        result = result.replace('đ', 'd');
        result = result.replace('Đ', 'D');
        result = result.replaceAll("[^a-z A-Z0-9-]", "");
        return result;
    }

    public static String escapeJS(String value) {
        return StringEscapeUtils.escapeJavaScript(value);
    }
    public static String replaceLineBreakChar(String input) {
        if (input == null) {
            return "";
        }
        return input.replaceAll("\\n", "<br/>");
    }

    public static String unEscapeHTML(String value) {
        if (StringUtils.isNotBlank(value)) {
            value = StringEscapeUtils.unescapeHtml(value);
        }
        return value;
    }
    public static String escapeHTML(String value) {
        if (StringUtils.isNotBlank(value)) {
            value = StringEscapeUtils.escapeHtml(value);
        }
        return value;
    }
    public static String convertDouble2String(Double value){
        DecimalFormat myFormatter = new DecimalFormat("#,###");
        return myFormatter.format(value);
    }

    public static String getDetailInfo(Importproduct importproduct){
        StringBuffer info = new StringBuffer();
        info.append(importproduct.getProductname().getName());
        if(importproduct.getSize() != null){
            info.append("-").append(importproduct.getSize().getName());
        }
        if(importproduct.getThickness() != null){
            info.append("-").append(importproduct.getThickness().getName());
        }
        if(importproduct.getStiffness() != null){
            info.append("-").append(importproduct.getStiffness().getName());
        }
        if(importproduct.getColour() != null){
            info.append("-").append(importproduct.getColour().getName());
        }
        if(importproduct.getQuantity1() != null && importproduct.getUnit1() != null){
            info.append("-").append(StringUtil.convertDouble2String(importproduct.getQuantity1())).append("(").append(importproduct.getUnit1().getName()).append(")");
        }
        if(importproduct.getQuantity2Pure() != null && importproduct.getUnit2() != null){
            info.append("-").append(StringUtil.convertDouble2String(importproduct.getQuantity2Pure())).append("(").append(importproduct.getUnit2().getName()).append(")");
        }
        if(importproduct.getOrigin() != null){
            info.append("-").append(importproduct.getOrigin().getName());
        }
        if(importproduct.getMarket() != null){
            info.append("-").append(importproduct.getMarket().getName());
        }
        if(importproduct.getImportDate() != null){
            info.append("-").append(DateUtils.date2String(importproduct.getImportDate(),"dd/MM/yyyy"));
        }else if(importproduct.getProduceDate() != null){
            info.append("-").append(DateUtils.date2String(importproduct.getProduceDate(),"dd/MM/yyyy"));
        }
        return info.toString();
    }

    public static String getDetailMaterialInfo(Importmaterial importMaterial){
        StringBuffer info = new StringBuffer();
        info.append(importMaterial.getMaterial().getName());

        if(importMaterial.getCode() != null && StringUtils.isNotBlank(importMaterial.getCode())){
            info.append("-").append(importMaterial.getCode());
        }

        if(importMaterial.getRemainQuantity() != null && importMaterial.getMaterial().getUnit() != null){
            info.append("-").append(StringUtil.convertDouble2String(importMaterial.getRemainQuantity())).append("(").append(importMaterial.getMaterial().getUnit().getName()).append(")");
        }

        if(importMaterial.getOrigin() != null){
            info.append("-").append(importMaterial.getOrigin().getName());
        }
        if(importMaterial.getMarket() != null){
            info.append("-").append(importMaterial.getMarket().getName());
        }
        if(importMaterial.getImportDate() != null){
            info.append("-").append(DateUtils.date2String(importMaterial.getImportDate(),"dd/MM/yyyy"));
        }else if(importMaterial.getExpiredDate() != null){
            info.append("-").append(DateUtils.date2String(importMaterial.getExpiredDate(),"dd/MM/yyyy"));
        }
        return info.toString();
    }

}
