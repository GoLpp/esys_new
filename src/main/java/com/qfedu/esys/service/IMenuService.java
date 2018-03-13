package com.qfedu.esys.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.qfedu.esys.dto.MenuDto;
import com.qfedu.esys.entity.Menu;

public interface IMenuService {

	/**
	 * @param parentId
	 * @param req 
	 * @return
	 */
	List<Menu> getChildren(String parentId, HttpServletRequest req);

	void create(MenuDto m);
	
	List<Menu> getChildren(String id);
}
