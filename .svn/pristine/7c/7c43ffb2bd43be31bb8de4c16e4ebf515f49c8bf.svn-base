package com.qfedu.esys.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.qfedu.common.entity.WoResultCode;
import com.qfedu.common.util.WoUtil;
import com.qfedu.esys.entity.Dictionary;
import com.qfedu.esys.service.IDictionaryService;
import com.qfedu.esys.vo.GridEuiVo;

@RestController
@RequestMapping(value = "/sys/dictionary", produces = "application/json")
public class DictionaryController {
	@SuppressWarnings("unused")
	private final static Logger LOG = LogManager.getLogger(DictionaryController.class);

	@Resource
	private IDictionaryService dictionaryService;

	@RequestMapping("/list")
	public GridEuiVo<Dictionary> getDictionaryList(String dicType, Long page, Long rows) {
		if (page == null) {
			page = 1L;
		}
		if (rows == null) {
			rows = 10L;
		}
		return new GridEuiVo<Dictionary>(dictionaryService.getGridData(dicType, (page - 1) * rows, rows));
	}

	/*
	 * 
	 */
	@RequestMapping("/getItems")
	public List<Dictionary> getItems(String dicType) {
		return dictionaryService.getByType(dicType);
	}

	/**
	 * @param dic
	 * @return
	 */
	@RequestMapping("/create")
	public WoResultCode create (Dictionary dic) {
		dictionaryService.create(dic);
		return WoResultCode.getSuccessCode();
	}
	
	/**
	 * @param dic
	 * @return
	 */
	@RequestMapping("/update")
	public WoResultCode update (Dictionary dic) {
		dictionaryService.update(dic);
		return WoResultCode.getSuccessCode();
	}
	
	/**
	 * @param dic
	 * @return
	 */
	@RequestMapping("/delete")
	public WoResultCode delete (String woSelectedIds) {
		String[] ids = new String[0];
		if (!WoUtil.isEmpty(woSelectedIds)) {
			ids = woSelectedIds.split(",");
		}
		dictionaryService.delete(ids);;
		return WoResultCode.getSuccessCode();
	}
}
