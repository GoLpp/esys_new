package com.qfedu.common.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.qfedu.common.dao.IBaseDao;
import com.qfedu.common.entity.WoPage;
import com.qfedu.common.util.WoUtil;

// @Repository
@SuppressWarnings(value = { "unchecked" })
public class BaseDao<E> implements IBaseDao<E> {
	private final static Logger LOG = LogManager.getLogger(BaseDao.class);

	private Class<?> entityClass;
	private String entityName;

	public BaseDao() {
		ParameterizedType pt = (ParameterizedType) this.getClass().getGenericSuperclass();
		entityClass = (Class<?>) pt.getActualTypeArguments()[0];
		entityName = entityClass.getSimpleName();
	}

	@Resource
	protected SessionFactory sessionFactory;

	/**
	 * 
	 * @return
	 */
	protected Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public void create(E entity) {
		getSession().persist(entity);
	}

	@Override
	public void delete(E entity) {
		getSession().delete(entity);
	}

	@Override
	public boolean deleteById(Serializable id) {
		E entity = findById(id);
		if (entity != null) {
			delete(entity);
			return true;
		}
		return false;
	}

	@Override
	public void update(E entity) {
		getSession().merge(entity);
	}

	@Override
	public E findById(Serializable id) {
		return (E) getSession().get(entityClass, id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.qf.wobb.dao.IBaseDao#findBy(java.util.Map)
	 */
	public E findBy(Map<String, Object> props) {
		List<E> list = findAllBy(props);
		return list.size() == 1 ? list.get(0) : null;
	}

	public List<E> findAll() {
		return findAllBy(null);
	}

	public List<E> findAllBy(Map<String, Object> props) {
		String hql = "";
		if (props != null && props.size() > 0) {
			for (String key : props.keySet()) {
				if (!hql.equals("")) {
					hql += " and ";
				}
				hql += " u." + key + " = :" + key.replace('.', '_');
			}
			hql = "from " + entityName + " u where " + hql;
		} else {
			hql = "from " + entityName + " u";
		}
		LOG.info(hql);
		Query query = getSession().createQuery(hql, entityClass);
		if (props != null && props.size() > 0) {
			for (String key : props.keySet()) {
				query.setParameter(key.replace('.', '_'), props.get(key));
			}
		}
		return (List<E>) query.getResultList();
	}

	@Override
	public WoPage<E> findAllBy(String whereOrOrderBy, Long start, Long limit, Map<String, Object> props) {
		// 获取分页数据
		String hql = "from " + entityName + " e ";
		if (!WoUtil.isEmpty(whereOrOrderBy)) {
			String upper = whereOrOrderBy.toUpperCase().trim();
			if (upper.startsWith("ORDER ") || upper.startsWith("WHERE ")) {
				hql += whereOrOrderBy;
			} else {
				hql += " where " + whereOrOrderBy;
			}
		}
		Query query = getSession().createQuery(hql, entityClass);
		for (String key : props.keySet()) {
			query.setParameter(key, props.get(key));
		}
		List<E> list = (List<E>) query.setMaxResults(limit.intValue()).setFirstResult(start.intValue()).list();
		// 获取总数量
		String countHql = "select count(*) " + hql;
		query = getSession().createQuery(countHql);
		for (String key : props.keySet()) {
			query.setParameter(key, props.get(key));
		}
		Long total = (Long) query.uniqueResult();
		return new WoPage<E>(list, total);
	}

	@Override
	public List<E> findAllBy(String whereOrOrderBy, Map<String, Object> props) {
		// 获取数据列表
		String hql = "from " + entityName + " e ";
		if (!WoUtil.isEmpty(whereOrOrderBy)) {
			String upper = whereOrOrderBy.toUpperCase().trim();
			if (upper.startsWith("ORDER ") || upper.startsWith("WHERE ")) {
				hql += whereOrOrderBy;
			} else {
				hql += " where " + whereOrOrderBy;
			}
		}
		Query query = getSession().createQuery(hql, entityClass);
		for (String key : props.keySet()) {
			query.setParameter(key, props.get(key));
		}
		List<E> list = (List<E>) query.list();
		return list;
	}
}
