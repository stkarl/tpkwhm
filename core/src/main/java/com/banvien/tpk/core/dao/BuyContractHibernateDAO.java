package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.domain.BuyContract;
import com.banvien.tpk.core.dto.BuyContractDTO;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;


public class BuyContractHibernateDAO extends
		AbstractHibernateDAO<BuyContract, Long> implements
		BuyContractDAO {

    @Override
    public List<BuyContractDTO> findBuyContracts(final Date fromDate, final Date toDate, final Long customerID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<BuyContractDTO>>() {
                    public List<BuyContractDTO> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer nativeSQL = new StringBuffer();
                        nativeSQL.append("select bc1.buyContractID as buyContractID, bc1.code as code,");
                        nativeSQL.append(" bc1.noRoll as noRoll, bc1.weight as weight, ");
                        nativeSQL.append(" c.name as customerName, c.customerID as customerID,");
                        nativeSQL.append(" bc1.date as startDate, case when bc2.date = (");
                        nativeSQL.append("      select min(bc3.date) from buycontract bc3 ");
                        nativeSQL.append("      where bc3.customerID = bc1.customerID");
                        nativeSQL.append("      and bc3.date > bc1.date) then bc2.date else null end as endDate ");
                        nativeSQL.append(" from buycontract bc1, buycontract bc2 , customer c");
                        nativeSQL.append(" where c.customerID = bc1.customerID ");
                        nativeSQL.append(" AND bc1.customerID = bc2.customerID");
                        if (fromDate != null){
                            nativeSQL.append(" AND bc1.date >= :fromDate");
                        }
                        if (toDate != null){
                            nativeSQL.append(" AND bc1.date <= :toDate");
                        }
                        if (customerID != null && customerID > - 1){
                            nativeSQL.append(" AND bc1.customerID = :customerID");
                        }
                        nativeSQL.append(" group by customerID, startDate, endDate");
                        nativeSQL.append(" order by startDate, customerID");
                        SQLQuery nativeQuery = session.createSQLQuery(nativeSQL.toString());

                        if(fromDate !=null){
                            nativeQuery.setParameter("fromDate", fromDate);
                        }
                        if(toDate !=null){
                            nativeQuery.setParameter("toDate", toDate);
                        }
                        if(customerID !=null && customerID > - 1){
                            nativeQuery.setParameter("customerID", customerID);
                        }
                        nativeQuery.setResultTransformer(Transformers.aliasToBean(BuyContractDTO.class));
                        nativeQuery.addScalar("buyContractID", StandardBasicTypes.LONG);
                        nativeQuery.addScalar("noRoll", StandardBasicTypes.INTEGER);
                        nativeQuery.addScalar("weight", StandardBasicTypes.DOUBLE);
                        nativeQuery.addScalar("customerName", StandardBasicTypes.STRING);
                        nativeQuery.addScalar("customerID", StandardBasicTypes.LONG);
                        nativeQuery.addScalar("code", StandardBasicTypes.STRING);
                        nativeQuery.addScalar("startDate", StandardBasicTypes.TIMESTAMP);
                        nativeQuery.addScalar("endDate", StandardBasicTypes.TIMESTAMP);

                        return (List<BuyContractDTO>) nativeQuery.list();
                    }
                });
    }

    @Override
    public List<BuyContract> findBuyContractList(final Date fromDate,final Date toDate,final Long customerID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<BuyContract>>() {
                    public List<BuyContract> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("from BuyContract bc1");
                        if (fromDate != null){
                            sql.append(" AND bc1.date >= :fromDate");
                        }
                        if (toDate != null){
                            sql.append(" AND bc1.date <= :toDate");
                        }
                        if (customerID != null && customerID > - 1){
                            sql.append(" AND bc1.customer.customerID = :customerID");
                        }
                        sql.append(" order by bc1.customer.customerID, bc1.date");
                        Query query = session.createQuery(sql.toString());

                        if(fromDate !=null){
                            query.setParameter("fromDate", fromDate);
                        }
                        if(toDate !=null){
                            query.setParameter("toDate", toDate);
                        }
                        if(customerID !=null && customerID > - 1){
                            query.setParameter("customerID", customerID);
                        }
                        return (List<BuyContract>) query.list();
                    }
                });
    }
}
