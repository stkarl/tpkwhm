package com.banvien.tpk.core.service;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.dao.BookProductDAO;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.dao.ImportproductDAO;
import com.banvien.tpk.core.domain.BookProduct;
import com.banvien.tpk.core.domain.Importproduct;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class BookProductServiceImpl extends GenericServiceImpl<BookProduct,Long>
                                                    implements BookProductService {

    protected final Log logger = LogFactory.getLog(getClass());

    private BookProductDAO bookProductDAO;

    public void setBookProductDAO(BookProductDAO bookProductDAO) {
        this.bookProductDAO = bookProductDAO;
    }

    private ImportproductDAO importproductDAO;

    public void setImportproductDAO(ImportproductDAO importproductDAO) {
        this.importproductDAO = importproductDAO;
    }

    @Override
	protected GenericDAO<BookProduct, Long> getGenericDAO() {
		return bookProductDAO;
	}
    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                bookProductDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public void deleteItem(Long bookProductID) throws ObjectNotFoundException {
        BookProduct dbBookProduct = this.bookProductDAO.findByIdNoAutoCommit(bookProductID);
        if(dbBookProduct == null) throw new ObjectNotFoundException("Not found booked product " + bookProductID);
        Importproduct importproduct = dbBookProduct.getImportProduct();
        importproduct.setStatus(Constants.ROOT_MATERIAL_STATUS_AVAILABLE);
        this.importproductDAO.update(importproduct);
        bookProductDAO.delete(bookProductID);
    }
}