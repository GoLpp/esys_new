package com.zhu.esys.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.zhu.esys.dto.MenuDto;
import com.zhu.esys.entity.Menu;


public interface MenuService {

	/**
	 * @param parentId
	 * @param req 
	 * @return
	 */
	List<Menu> getChildren(String parentId, HttpServletRequest req);

	void create(MenuDto m);
	
	List<Menu> getChildren(String id);
}
