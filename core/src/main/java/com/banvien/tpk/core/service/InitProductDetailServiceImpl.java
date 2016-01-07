package com.banvien.tpk.core.service;

import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.InitProductDetailDAO;
import com.banvien.tpk.core.domain.InitProductDetail;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class InitProductDetailServiceImpl extends GenericServiceImpl<InitProductDetail,Long>
                                                    implements InitProductDetailService {

    protected final Log logger = LogFactory.getLog(getClass());

    private InitProductDetailDAO initProductDetailDAO;

    public void setInitProductDetailDAO(InitProductDetailDAO initProductDetailDAO) {
        this.initProductDetailDAO = initProductDetailDAO;
    }

    public void setInitProductDetailDetailDAO(InitProductDetailDAO initProductDetailDAO) {
        this.initProductDetailDAO = initProductDetailDAO;
    }

    @Override
	protected GenericDAO<InitProductDetail, Long> getGenericDAO() {
		return initProductDetailDAO;
	}


 

}