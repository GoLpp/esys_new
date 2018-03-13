package com.qfedu.esys.dao;

import java.util.List;

import com.qfedu.common.dao.IBaseDao;
import com.qfedu.esys.entity.Menu;

/**
 * @author cailei
 */
public interface IMenuDao extends IBaseDao<Menu>{

	List<Menu> findAllTops();

	List<Menu> findAllByParentId(String parentId);

}