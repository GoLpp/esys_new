package com.zhu.esys;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.zhu.common.WoException;
import com.zhu.common.entity.WoResultCode;


public class ESysException extends WoException {
	private final static Logger LOG = LogManager.getLogger(ESysException.class);

	public ESysException() {
	}

	public ESysException(WoResultCode code, Object... args) {
		super(code, args);
	}

	public ESysException(Throwable cause, WoResultCode code, Object... args) {
		super(cause, code, args);
	}
}
