package com.qfedu.esys.vo;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.qfedu.common.entity.WoPage;

public class GridEuiVo<T> {
	
	private final static Logger LOG = LogManager.getLogger(GridEuiVo.class);
	
	private Long total;
	
	private List<T> rows;

	public GridEuiVo(Long total, List<T> rows) {
		super();
		this.total = total;
		this.rows = rows;
	}
	
	public GridEuiVo(WoPage<T> page) {
		super();
		this.total = page.getResults();
		this.rows = page.getRows();
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}
	
	
}
