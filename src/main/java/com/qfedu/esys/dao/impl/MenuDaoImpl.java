package com.qfedu.esys.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.qfedu.common.dao.impl.BaseDaoImpl;
import com.qfedu.esys.dao.MenuDao;
import com.qfedu.esys.entity.Menu;

@Repository
public class MenuDaoImpl extends BaseDaoImpl<Menu> implements MenuDao {

	private final static Logger LOG = LogManager.getLogger(MenuDaoImpl.class);

	// @Resource // @Autowired
	// private SessionFactory sessionFactory;

	@Override
	public List<Menu> findAllTops() {
		String hql = "from Menu m where m.parent.id is null";
		return getSession().createQuery(hql, Menu.class).getResultList();
	}

	@Override
	public List<Menu> findAllByParentId(String parentId) {
		String hql = "from Menu m where m.parent.id = :parentId";
		return getSession().createQuery(hql, Menu.class).setParameter("parentId", parentId)
				.getResultList();
	}
}
