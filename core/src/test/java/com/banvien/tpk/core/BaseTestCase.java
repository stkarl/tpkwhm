package com.banvien.tpk.core;

import org.springframework.test.AbstractTransactionalDataSourceSpringContextTests;

/**
 * Base class for Service and Dao Unitests
 * @author ltran
 *
 */
@SuppressWarnings("deprecation")
public abstract class BaseTestCase extends AbstractTransactionalDataSourceSpringContextTests {


	protected String[] getConfigLocations() {
		setAutowireMode(AUTOWIRE_BY_NAME);
        return new String[] {
                "classpath:/applicationContext-resources.xml",
                "classpath:/applicationContext-dao.xml",
                "classpath:/applicationContext-service.xml"
            };
   }
	 
   public BaseTestCase(){	   
    	super();
    }
    
    public BaseTestCase(String arg){
    	super(arg);
    }
}
