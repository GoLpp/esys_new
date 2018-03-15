package com.qfedu.esys.dao;

import java.util.List;

import com.qfedu.common.dao.BaseDao;
import com.qfedu.esys.entity.Menu;

/**
 * @author cailei
 */
public interface MenuDao extends BaseDao<Menu>{

	List<Menu> findAllTops();

	List<Menu> findAllByParentId(String parentId);

}