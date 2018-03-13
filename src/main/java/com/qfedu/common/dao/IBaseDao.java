package com.qfedu.common.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.qfedu.common.entity.WoPage;

/**
 * @author cailei
 *
 * @param <E> 实体类型
 */
public interface IBaseDao<E> {
	
	/**
	 * 增加
	 * @param entity 业务实体对象
	 * @return 增加成功返回实体对象的标识
	 */
	public void create(E entity);
	
	/**
	 * 删除
	 * @param entity 业务实体对象
	 * @return 删除成功返回true否则返回false
	 */
	public void delete(E entity);
	
	/**
	 * 根据ID删除
	 * @param id 业务实体对象的标识
	 * @return 删除成功返回true否则返回false
	 */
	public boolean deleteById(Serializable id);
	
	/**
	 * 修改
	 * @param entity 业务实体对象
	 * @return 修改成功返回true否则返回false
	 */
	public void update(E entity);
	
	/**
	 * 根据ID查找业务实体对象
	 * @param id 业务实体对象的标识
	 * @return 业务实体对象对象或null
	 */
	public E findById(Serializable id);
	
	/**
	 * @param props
	 * @return
	 */
	public E findBy (Map<String, Object> props);
	
	/**
	 * @return
	 */
	public List<E> findAll ();
	
	/**
	 * @param props
	 * @return
	 */
	public List<E> findAllBy(Map<String, Object> props);
	
	/**
	 * @param whereOrOrderBy
	 * @param props
	 * @return
	 */
	public List<E> findAllBy (String whereOrOrderBy, Map<String, Object> props);
	
	/**
	 * @param whereOrOrderBy
	 * @param start
	 * @param limit
	 * @param props
	 * @return
	 */
	public WoPage<E> findAllBy (String whereOrOrderBy, Long start, Long limit, Map<String, Object> props);
}
