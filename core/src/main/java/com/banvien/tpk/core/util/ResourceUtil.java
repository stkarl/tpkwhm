package com.banvien.tpk.core.util;


import org.apache.commons.lang.StringUtils;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.ui.velocity.VelocityEngineUtils;

import java.util.HashMap;
import java.util.Properties;

/**
 * Created with IntelliJ IDEA.
 * User: hau
 * Date: 10/23/13
 * Time: 2:27 PM
 * To change this template use File | Settings | File Templates.
 */
public class ResourceUtil {
    private static final String HEADER_TEMPLATE = "resourceHeaderPassageTemplate.vm";
    private static final String FOOTER_TEMPLATE = "resourceFooterPassageTemplate.vm";

    public static String getProductLibName(String productLib) {
        if (StringUtils.isNotBlank(productLib) && "S".equalsIgnoreCase(productLib)) {
            return "Science";
        } else if (StringUtils.isNotBlank(productLib) && "M".equalsIgnoreCase(productLib)) {
            return "Math";
        } else if (StringUtils.isNotBlank(productLib) && "R".equalsIgnoreCase(productLib)) {
            return "Reading";
        } else if (StringUtils.isNotBlank(productLib) && "B".equalsIgnoreCase(productLib)) {
            return "Character Building";
        } else if (StringUtils.isNotBlank(productLib) && "O".equalsIgnoreCase(productLib)) {
            return "Social Studies";
        }
        return "";
    }

    public static String createHeaderHtml(String title, String description) throws Exception {
        VelocityEngine velocityEngine = new VelocityEngine();
        Properties p = new Properties();
        p.setProperty("resource.loader", "class");
        p.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        velocityEngine.init(p);

        HashMap<String, String> model = new HashMap<String, String>();
        model.put("title", title);
        model.put("description", description);

        String html = VelocityEngineUtils.mergeTemplateIntoString(
                velocityEngine, HEADER_TEMPLATE, model);
        return html;
    }

    public static String createFooterHtml(String resourceCode) throws Exception {
        VelocityEngine velocityEngine = new VelocityEngine();
        Properties p = new Properties();
        p.setProperty("resource.loader", "class");
        p.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        velocityEngine.init(p);

        HashMap<String, String> model = new HashMap<String, String>();
        model.put("resource_code", resourceCode);

        String html = VelocityEngineUtils.mergeTemplateIntoString(
                velocityEngine, FOOTER_TEMPLATE, model);
        return html;
    }
}
