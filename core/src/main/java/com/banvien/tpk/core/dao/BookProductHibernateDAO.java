package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.BookProduct;
import com.banvien.tpk.core.domain.Importproduct;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;
public class BookProductHibernateDAO extends
		AbstractHibernateDAO<BookProduct, Long> implements
		BookProductDAO {

	@SuppressWarnings("unchecked")
	public List<BookProduct> findByBookProductBillID(Long bookProductBillID) {
		return findByCriteria(Restrictions.eq("bookProductBill.bookProductBillID", bookProductBillID));
	}

    @Override
    public List<Importproduct> findProductInBookBill(final Long bookProductBillID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Importproduct>>() {
                    public List<Importproduct> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("Select bp.importProduct FROM BookProduct bp WHERE 1 = 1");
                        if (bookProductBillID != null){
                            sqlQuery.append(" AND bp.bookProductBill.bookProductBillID = :bookProductBillID");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        if(bookProductBillID != null){
                            query.setParameter("bookProductBillID", bookProductBillID);
                        }
                        return (List<Importproduct>) query.list();
                    }
                });
    }
}
