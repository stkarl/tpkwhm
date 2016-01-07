package com.banvien.tpk.core.service;

import com.banvien.tpk.core.exception.ObjectNotFoundException;

import java.io.Serializable;
import java.util.List;

/**
 *
 */
public interface GenericService<T, ID extends Serializable> {

    @SuppressWarnings("unchecked")
	public Class getPersistentClass();

    public T findById(ID id) throws ObjectNotFoundException;

    public T findEqualUnique(String property, Object value);

    /**
     * Find by id. This api must be
     * executed within an transaction with explicitly commit because
     * connection's autocommit is set to false.
     *
     * @param id
     * @return
     */
    public T findByIdNoCommit(ID id);

    public T save(T entity);

    public T update(T entity);

    public T saveOrUpdate(T entity);

    public void delete(T entity);

    public void detach(T entity);

    public List<T> find(int maxResults);

    public List<T> findAll();
}