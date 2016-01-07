package com.banvien.tpk.core.service;
import com.banvien.tpk.core.dao.GenericDAO;
import com.banvien.tpk.core.exception.ObjectNotFoundException;
import org.springframework.transaction.PlatformTransactionManager;

import java.io.Serializable;
import java.util.List;

/**
 *
 *
 * @param <T>
 * @param <ID>
 */
public abstract class GenericServiceImpl<T, ID extends Serializable>
        implements GenericService<T, ID> {

    protected PlatformTransactionManager transactionManager;

    protected abstract GenericDAO<T, ID> getGenericDAO();

    @SuppressWarnings("unchecked")
	public Class getPersistentClass() {
        return getGenericDAO().getPersistentClass();
    }

    public T findById(ID id) throws ObjectNotFoundException {
        T res =  getGenericDAO().findById(id, false);
        if (res == null) throw new ObjectNotFoundException("Not found object " + id);
        return res;
    }

    public T findEqualUnique(String property,
                             Object value) {
        return getGenericDAO().findEqualUnique(property, value);
    }



    /**
     * Find by id. This api must be
     * executed within an transaction with explicitly commit because
     * connection's autocommit is set to false.
     *
     * @param id
     * @return
     */
    public T findByIdNoCommit(ID id) {
        return getGenericDAO().findByIdNoAutoCommit(id);
    }

    public T save(T entity) {
        getGenericDAO().save(entity);
        return entity;
    }

    public T update(T entity) {
        getGenericDAO().update(entity);
        return entity;
    }

    public T saveOrUpdate(T entity) {
        getGenericDAO().saveOrUpdate(entity);
        return entity;
    }

    public void delete(T entity) {
        this.getGenericDAO().delete(entity);
    }

    public void detach(T entity) {
        this.getGenericDAO().detach(entity);
    }

    public List<T> find(int maxResults) {
        return this.getGenericDAO().find(maxResults);
    }

    public List<T> findAll() {
        return this.getGenericDAO().findAll();
    }


    /**
     * @param transactionManager The transactionManager to set.
     */
    public void setTransactionManager(PlatformTransactionManager transactionManager) {
        this.transactionManager = transactionManager;
    }


    /**
     * @return Returns the transactionManager.
     */
    public PlatformTransactionManager getTransactionManager() {
        return transactionManager;
    }
}


