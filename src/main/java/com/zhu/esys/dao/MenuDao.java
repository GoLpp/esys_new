package com.zhu.esys.dao;

import java.util.List;

import com.zhu.common.dao.BaseDao;
import com.zhu.esys.entity.Menu;


/**
 * @author cailei
 */
public interface MenuDao extends BaseDao<Menu>{

	List<Menu> findAllTops();

	List<Menu> findAllByParentId(String parentId);

}