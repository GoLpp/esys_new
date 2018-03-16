package com.zhu.esys.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import com.zhu.common.util.WoUtil;
import com.zhu.esys.dao.UserDao;
import com.zhu.esys.entity.User;


@Repository
public class UserDaoImpl implements UserDao {
	private final static Logger LOG = LogManager.getLogger(UserDaoImpl.class);

	@Resource // @Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<User> findAll() {
		String hql = "from User u";
		return sessionFactory.getCurrentSession().createQuery(hql, User.class).list();
	}

	@Override
	public void create(User u) {
		sessionFactory.getCurrentSession().persist(u);
	}

	public void update(User u) {
		sessionFactory.getCurrentSession().merge(u);
	}

	@Override
	public void delete(User user) {
		sessionFactory.getCurrentSession().delete(user);
	}

	@Override
	public User findByLoginName(String user) {
		String hql = "from User u where u.loginName = :loginName";
		return sessionFactory.getCurrentSession().createQuery(hql, User.class).setParameter("loginName", user)
				.uniqueResult();
	}

	@Override
	public List<User> finUserByCondition(Long page, Long rows, String loginName) {
		String hql = "from User u";
		if (!WoUtil.isEmpty(loginName)) {
			hql += " where u.loginName like :name";
		}
		Query<User> query = sessionFactory.getCurrentSession().createQuery(hql, User.class);
		if (!WoUtil.isEmpty(loginName)) {
			query.setParameter("name", "%" + loginName + "%");
		}
		query.setFirstResult(page.intValue()).setMaxResults(rows.intValue());
		List<User> list = query.list();
		return list;
	}
}
