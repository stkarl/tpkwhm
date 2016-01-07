package com.banvien.tpk.webapp.util;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Origin;
import com.banvien.tpk.core.domain.Productquality;
import com.banvien.tpk.security.SecurityUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: khanhcq
 * Date: 6/3/14
 * Time: 10:18 PM
 * To change this template use File | Settings | File Templates.
 */
public class WebCommonUtils {

    public static Boolean checkEditable(String role,Long createdUserID, Timestamp createdDate){
        Boolean editable = Boolean.FALSE;
        if(System.currentTimeMillis() - createdDate.getTime() < Constants.A_WEEK){
            editable = Boolean.TRUE;
        }

        return  editable;
    }

    public static Boolean checkDeletable(String role){
        Boolean deletable = Boolean.FALSE;
        if(role.equals(Constants.ADMIN_ROLE)){
            deletable = Boolean.TRUE;
        }
        return  deletable;
    }

    public static String productShipName(String productName, String colour){
        if(StringUtils.isNotBlank(colour)){
            StringBuffer buffer = new StringBuffer();
            buffer.append(productName).append(" ")
                    .append(StringUtils.isNotBlank(colour) ? colour : "");
            String[] nameArr = buffer.toString().split(" ");
            StringBuffer name = new StringBuffer();
            for(int i = 0; i < nameArr.length; i ++){
                if(!StringUtils.upperCase(nameArr[i]).equals(Constants.TON) && !StringUtils.upperCase(nameArr[i]).equals(Constants.MAU)){
                    String temp = Character.toUpperCase(nameArr[i].charAt(0)) + nameArr[i].substring(1);
                    if(i != 0){
                        name.append(" ").append(temp);
                    }else {
                        name.append(temp);
                    }
                }
            }
            return name.toString();
        }else{
            return WordUtils.capitalize(productName);
        }
    }

    public static String productShipNote(List<Productquality> productqualities){
        DecimalFormat decimalFormat = new DecimalFormat("###,###");
        int i = 0;
        StringBuffer buffer = new StringBuffer();
        for(Productquality productquality : productqualities){
            if(!productquality.getQuality().getCode().equals(Constants.QUALITY_A) && productquality.getQuantity1() != null && productquality.getQuantity1() > 0){
                if(buffer.length() != 0){
                    buffer.append(", ").append(productquality.getQuality().getCode()).append(" : ").append(decimalFormat.format(productquality.getQuantity1())).append("m");
                }else{
                    buffer.append(productquality.getQuality().getCode()).append(" : ").append(decimalFormat.format(productquality.getQuantity1())).append("m");
                }
            }
            i++;
        }
        return buffer.toString();
    }

    public static Map<Long, String> buildMapOriginName(List<Origin> origins) {
        Map<Long,String> result = new HashMap<Long, String>();
        for(Origin origin : origins){
            result.put(origin.getOriginID(),origin.getName());
        }
        return result;
    }

    public static Map<Long,Double> mapProductQuality(List<Productquality> productqualities){
        Map<Long,Double> productqualityMap = new HashMap<Long, Double>();
        for(Productquality productquality : productqualities){
            productqualityMap.put(productquality.getQuality().getQualityID(),productquality.getQuantity1());
        }
        return productqualityMap;
    }

    public static Double productWidth(String size){
        Double w;
        try{
            String[] sizeArr = StringUtils.split(size, "x");
            w = Double.valueOf(sizeArr[sizeArr.length-1]) / 1000;
        }catch (Exception e){
            w = 0d;
        }
        return w;
    }

    public static Double productThick(String size){
        Double w;
        try{
            String[] sizeArr = StringUtils.split(size, "x");
            w = Double.valueOf(sizeArr[0]);
        }catch (Exception e){
            w = 0d;
        }
        return w;
    }

    public static Double balanceArrangeFee(Double arrangeCost, Double thick){
        Double result;
        try{
            if(thick <= 0.25){
                result = arrangeCost - arrangeCost*0.06;
            }else if(thick > 0.25 && thick <= 0.3){
                result = arrangeCost - arrangeCost*0.03;
            }else if(thick >= 0.31 && thick <= 0.4){
                result = arrangeCost + arrangeCost*0.03;
            }else if(thick >= 0.41 && thick <= 0.5){
                result = arrangeCost + arrangeCost*0.06;
            }else if(thick >= 0.51 && thick <= 0.6){
                result = arrangeCost + arrangeCost*0.09;
            }else{
                result = arrangeCost + arrangeCost*0.12;
            }
        }catch (Exception e){
            result = 0d;
        }
        return result;
    }

    public static String productCodeWhenPrint(String code){
        String result = code;
        if(StringUtils.isNotBlank(code) && code.lastIndexOf("-") > 0){
            result = StringUtils.substring(code,0, code.lastIndexOf("-"));
        }
        return result;
    }

    public static Boolean checkImage(String fileName){
        Boolean result = Boolean.FALSE;
        fileName = fileName.toLowerCase();
        if(fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") ||fileName.endsWith(".png") || fileName.endsWith(".bmp") || fileName.endsWith(".gif")){
            result = Boolean.TRUE;
        }
        return  result;
    }

    public static String getFileName(String path){
        if(path.indexOf("/") > -1){
            String[] paths =  StringUtils.split(path,"/");
            path = paths[paths.length - 1];
        }
        if(path.length() > 10){
            String[] temp = StringUtils.split(path,".");
            path = temp[0].substring(0,7) + "..." + temp[temp.length - 1];
        }
        return path;
    }

    public static Long getLoginID(){
        return SecurityUtils.getLoginUserId();
    }
}
