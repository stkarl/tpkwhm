package com.banvien.tpk.core.dao;

import com.banvien.tpk.core.Constants;
import com.banvien.tpk.core.domain.Material;
import com.banvien.tpk.core.dto.MaterialBean;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>Hibernate DAO layer for Materials</p>
 * <p>Generated at Tue Feb 18 21:28:56 ICT 2014</p>
 *
 * @author Salto-db Generator v1.0.16 / Pojos + Hibernate mapping + Generic DAO
 *
 */
public class MaterialHibernateDAO extends
        AbstractHibernateDAO<Material, Long> implements
        MaterialDAO {

    /**
     * Find Material by name
     */
    public List<Material> findByName(String name) {
        return findByCriteria(Restrictions.eq("name", name));
    }

    /**
     * Find Material by code
     */
    public List<Material> findByCode(String code) {
        return findByCriteria(Restrictions.eq("code", code));
    }

    /**
     * Find Material by description
     */
    public List<Material> findByDescription(String description) {
        return findByCriteria(Restrictions.eq("description", description));
    }

    @Override
    public Object[] searchByBean(final MaterialBean bean,final int firstItem,final int maxPageItems,final String sortExpression, final String sortDirection) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {
                    public Object[] doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        String name = StringUtils.isNotBlank(bean.getPojo().getName()) ? bean.getPojo().getName() : null;
                        Long cateID = bean.getMaterialCategoryID() != null && bean.getMaterialCategoryID() > 0 ? bean.getMaterialCategoryID() : null;

                        StringBuffer whereClause = new StringBuffer(" WHERE 1 = 1");
                        if(name != null){
                            whereClause.append(" AND m.name = :name");
                        }
                        if (cateID != null){
                            whereClause.append(" AND m.materialID IN (SELECT mac.material.materialID FROM MaterialAndCategory mac WHERE mac.materialCategory.materialCategoryID = :cateID)");
                        }

                        StringBuffer sqlQuery = new StringBuffer("FROM Material m ");
                        sqlQuery.append(whereClause.toString());
                        sqlQuery.append(" ORDER BY m.");
                        if(sortExpression != null){
                            sqlQuery.append(sortExpression);
                        }else{
                            sqlQuery.append("name");
                        }
                        if(sortDirection != null && sortDirection.equals("1")){
                            sqlQuery.append(" ASC");
                        }else if (sortDirection == null || sortDirection.equals("2")){
                            sqlQuery.append(" DESC");
                        }
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setFirstResult(firstItem);
                        query.setMaxResults(maxPageItems);

                        if(name != null){
                            query.setParameter("name", name);
                        }
                        if (cateID != null){
                            query.setParameter("cateID", cateID);
                        }

                        StringBuffer countQuery = new StringBuffer("SELECT count(*) FROM Material m ");
                        countQuery.append(whereClause.toString());
                        Query cQuery = session.createQuery(countQuery.toString());
                        if(name != null){
                            cQuery.setParameter("name", name);
                        }
                        if (cateID != null){
                            cQuery.setParameter("cateID", cateID);
                        }
                        return new Object[]{cQuery.uniqueResult(), query.list()} ;
                    }
                });
    }

    @Override
    public List<Material> findByCateCode(final String cateCode) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Material>>() {
                    public List<Material> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Material m ");
                        sqlQuery.append(" WHERE m.materialID IN (SELECT mac.material.materialID FROM MaterialAndCategory mac WHERE mac.materialCategory.code = :cateCode)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("cateCode", cateCode);
                        return (List<Material>) query.list();
                    }
                });
    }

    @Override
    public List<Material> findNoneMeasurement() {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Material>>() {
                    public List<Material> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("FROM Material m ");
                        sqlQuery.append(" WHERE m.materialID IN (SELECT mac.material.materialID FROM MaterialAndCategory mac WHERE mac.materialCategory.code NOT IN (:cateCodes))");
                        Query query = session.createQuery(sqlQuery.toString());
                        List<String> cateCodes = new ArrayList<String>();
                        cateCodes.add(Constants.MATERIAL_GROUP_MEASURE_LANH);
                        cateCodes.add(Constants.MATERIAL_GROUP_MEASURE_MAU);
                        query.setParameterList("cateCodes", cateCodes);
                        return (List<Material>) query.list();
                    }
                });
    }

    @Override
    public List<Material> findAssigned(final Long userID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Material>>() {
                    public List<Material> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer("SELECT distinct mac.material FROM MaterialAndCategory mac ");
                        sqlQuery.append(" WHERE mac.materialCategory.materialCategoryID IN (" +
                                " SELECT umc.materialCategory.materialCategoryID FROM UserMaterialCate umc" +
                                " WHERE umc.user.userID = :userID)");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("userID", userID);
                        return (List<Material>) query.list();
                    }
                });
    }


}
