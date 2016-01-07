package com.banvien.tpk.webapp.dcdt;

import org.apache.log4j.Logger;

import java.io.*;
import java.util.Properties;

/**
 * Created with IntelliJ IDEA.
 * User: viennh
 * Date: 8/26/13
 * Time: 2:06 PM
 * To change this template use File | Settings | File Templates.
 */
public class Config extends Properties {
    private transient final Logger log = Logger.getLogger(getClass());
    private static Config ourInstance = new Config();
    public static Config getInstance() {
        return ourInstance;
    }

    private Config() {
        super();
        try {
            super.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("dcdt.properties"));
        } catch (IOException e) {
            log.fatal("ERROR: can not load config file whm.properties : "+e);
        }
    }


}
