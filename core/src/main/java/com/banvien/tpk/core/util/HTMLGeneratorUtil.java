package com.banvien.tpk.core.util;


import com.banvien.tpk.core.dto.OriginQuantityDTO;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.ui.velocity.VelocityEngineUtils;

import java.text.DecimalFormat;
import java.util.*;

public class HTMLGeneratorUtil {


    public static String createOriginQuantityHTML(Map<Long, Double> mapOriginQuantity, Map<Long, String> mapOrigin) throws Exception {
        VelocityEngine velocityEngine = new VelocityEngine();
        Properties p = new Properties();
        p.setProperty("resource.loader", "class");
        p.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        velocityEngine.init(p);

        Map<String, Object> mapProperties = new HashMap<String, Object>();
        mapProperties.put("originQuantities", prepareOriginQuantity(mapOriginQuantity, mapOrigin));
        String template = "origin_quantity_template.vm";
        String html = VelocityEngineUtils.mergeTemplateIntoString(
                velocityEngine, template, mapProperties);
        return html;
    }

    private static List<OriginQuantityDTO> prepareOriginQuantity(Map<Long, Double> mapOriginQuantity, Map<Long, String> mapOrigin) {
        DecimalFormat decimalFormat = new DecimalFormat("###,###");
        List<OriginQuantityDTO> dtos = new ArrayList<OriginQuantityDTO>();
        for(Long key : mapOriginQuantity.keySet()){
            OriginQuantityDTO originQuantityDTO = new OriginQuantityDTO(mapOrigin.get(key), decimalFormat.format(mapOriginQuantity.get(key)));
            dtos.add(originQuantityDTO);
        }
        return dtos;
    }

    public static String createSimpleOriginQuantityInfo(Map<Long, Double> mapOriginQuantity, Map<Long, String> mapOrigin) {
        DecimalFormat decimalFormat = new DecimalFormat("###,###");
        StringBuffer buffer = new StringBuffer();
        int i = 0;
        for(Long key : mapOriginQuantity.keySet()){
            if(i == 0){
                buffer.append(mapOrigin.get(key) != null ? mapOrigin.get(key) : "N/A").append(": ").append(decimalFormat.format(mapOriginQuantity.get(key)));
            }else {
                buffer.append(";    ").append(mapOrigin.get(key)).append(": ").append(decimalFormat.format(mapOriginQuantity.get(key)));
            }
            i++;
        }
        return buffer.toString();
    }

    public static Map<Long, String> createMapOverlaySimpleOriginQuantityInfo(Map<Long, Map<Long, Double>> mapOverlayOriginQuantity, Map<Long, String> mapOrigin) {
        Map<Long, String> result = new HashMap<Long, String>();
        DecimalFormat decimalFormat = new DecimalFormat("###,###");
        StringBuffer buffer;
        for(Long overlayID : mapOverlayOriginQuantity.keySet()){
            buffer = new StringBuffer();
            int i = 0;
            for (Long originID : mapOverlayOriginQuantity.get(overlayID).keySet()){
                if(i == 0){
                    buffer.append(mapOrigin.get(originID) != null ? mapOrigin.get(originID) : "N/A").append(": ").append(decimalFormat.format(mapOverlayOriginQuantity.get(overlayID).get(originID)));
                }else {
                    buffer.append(";    ").append(mapOrigin.get(originID)).append(": ").append(decimalFormat.format(mapOverlayOriginQuantity.get(overlayID).get(originID)));
                }
                i++;
            }
            result.put(overlayID, buffer.toString());
        }
        return result;
    }
}
