package com.banvien.tpk.webapp.listener;


import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.context.AppContext;
import com.banvien.tpk.core.domain.Setting;
import com.banvien.tpk.core.service.*;
import com.banvien.tpk.core.util.GeneratorUtils;
import com.banvien.tpk.webapp.util.GlobalDataUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>StartupListener class used to initialize and database settings
 * and populate any application-wide drop-downs.
 * <p/>
 * <p>Keep in mind that this listener is executed outside of OpenSessionInViewFilter,
 * so if you're using Hibernate you'll have to explicitly initialize all loaded data at the
 * GenericDao or service level to avoid LazyInitializationException. Hibernate.initialize() works
 * well for doing this.
 *
 */
public class StartupListener implements ServletContextListener {
    private static final Log log = LogFactory.getLog(StartupListener.class);
    
    /**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public void contextInitialized(ServletContextEvent event) {
        log.debug("Initializing context...");

        ServletContext context = event.getServletContext();

        // set fields of Constants class in Application Scope
        context.setAttribute(Constants.class.getSimpleName(), createNameToValueMap());
        
        // Orion starts Servlets before Listeners, so check if the config
        // object already exists
        Map<String, Object> config = (HashMap<String, Object>) context.getAttribute(Constants.CONFIG);

        if (config == null) {
            config = new HashMap<String, Object>();
        }

        if (context.getInitParameter(Constants.CSS_THEME) != null) {
            config.put(Constants.CSS_THEME, context.getInitParameter(Constants.CSS_THEME));
        }

        ApplicationContext ctx =
                WebApplicationContextUtils.getRequiredWebApplicationContext(context);
        AppContext.setApplicationContext(ctx);


        context.setAttribute(Constants.CONFIG, config);
        setMaxPNKPLCode(ctx);
        setMaxPXKPLCode(ctx);

        setMaxPNKTONCode(ctx);
        setMaxPXKTONCode(ctx);
        setMaxPTNTONCode(ctx);
        setMaxBookBillNumber(ctx);

        setupContext(context);
    }

    private void setMaxBookBillNumber(ApplicationContext ctx) {
        BookProductBillService bookProductBillService = ctx.getBean(BookProductBillService.class);
        String maxBBNUmber = null;
        try {
            maxBBNUmber = bookProductBillService.getLatestBookBillNumber();
        } catch (Exception e) {
            log.error(e);
        }
        if(maxBBNUmber != null) {
            GeneratorUtils.MAX_BB_UID = Long.parseLong(maxBBNUmber);
        }
    }

    private void setMaxPTNTONCode(ApplicationContext ctx) {
        ImportproductbillService importproductbillService = ctx.getBean(ImportproductbillService.class);
        String maxPTNTON = null;
        try {
            maxPTNTON = importproductbillService.getLatestPTNTON();
        } catch (Exception e) {
            log.error(e);
        }
        if(maxPTNTON != null) {
            GeneratorUtils.MAX_PTN_TON_UID = Long.parseLong(maxPTNTON);
        }
    }

    private void setMaxPNKPLCode(ApplicationContext ctx){
        ImportmaterialbillService importmaterialbillService = ctx.getBean(ImportmaterialbillService.class);
        String maxPNKPL = null;
        try {
            maxPNKPL = importmaterialbillService.getLatestPNKPL();
        } catch (Exception e) {
            log.error(e);
        }
        if(maxPNKPL != null) {
            GeneratorUtils.MAX_PNK_PL_UID = Long.parseLong(maxPNKPL);
        }
    }

    private void setMaxPXKPLCode(ApplicationContext ctx){
        ExportmaterialbillService exportmaterialbillService = ctx.getBean(ExportmaterialbillService.class);
        String maxPXKPL = null;
        try {
            maxPXKPL = exportmaterialbillService.getLatestPXKPL();
        } catch (Exception e) {
            log.error(e);
        }
        if(maxPXKPL != null) {
            GeneratorUtils.MAX_PXK_PL_UID = Long.parseLong(maxPXKPL);
        }
    }

    private void setMaxPNKTONCode(ApplicationContext ctx){
        ImportproductbillService importproductbillService = ctx.getBean(ImportproductbillService.class);
        String maxPNKTON = null;
        try {
            maxPNKTON = importproductbillService.getLatestPNKTON();
        } catch (Exception e) {
            log.error(e);
        }
        if(maxPNKTON != null) {
            GeneratorUtils.MAX_PNK_TON_UID = Long.parseLong(maxPNKTON);
        }
    }

    private void setMaxPXKTONCode(ApplicationContext ctx){
        ExportproductbillService exportproductbillService = ctx.getBean(ExportproductbillService.class);
        String maxPXKTON = null;
        try {
            maxPXKTON = exportproductbillService.getLatestPXKTON();
        } catch (Exception e) {
            log.error(e);
        }
        if(maxPXKTON != null) {
            GeneratorUtils.MAX_PXK_TON_UID = Long.parseLong(maxPXKTON);
        }
    }
    

	/**
     * This method uses the LookupManager to lookup available roles from the data layer.
     *
     * @param context The servlet context
     */
    public static void setupContext(ServletContext context) {
        ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

    }

    /**
     * Shutdown servlet context (currently a no-op method).
     *
     * @param servletContextEvent The servlet context event
     */
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        //LogFactory.release(Thread.currentThread().getContextClassLoader());
        //Commented out the above call to avoid warning when SLF4J in classpath.
        //WARN: The method class org.apache.commons.logging.impl.SLF4JLogFactory#release() was invoked.
        //WARN: Please see http://www.slf4j.org/codes.html for an explanation.
    }
    
    /**
     * Puts all public static fields via introspection into the resulting Map.
     * Uses the name of the field as key to reference it's in the Map.
     *
     * @return a Map of field names to field values of
     *         all public static fields of this class
     */
    private static Map createNameToValueMap() {
        Map result = new HashMap();
        Field[] publicFields = Constants.class.getFields();
        for (int i = 0; i < publicFields.length; i++) {
            Field field = publicFields[i];
            String name = field.getName();
            try {
                result.put(name, field.get(null));
            } catch (Exception e) {
                log.fatal(e);
            }
        }

        return result;
    }
}
