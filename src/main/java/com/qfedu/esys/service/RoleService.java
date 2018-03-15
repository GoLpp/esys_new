package com.qfedu.esys.service;

import com.qfedu.common.entity.WoPage;
import com.qfedu.esys.dto.RoleDto;

public interface RoleService {

	WoPage<RoleDto> getGridData(String name, long l, Long rows);
	
	void create(RoleDto dto);

	void update(RoleDto dto);

	void delete(String woSelectedIds);
}
