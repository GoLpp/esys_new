package com.qfedu.esys.entity;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
@Entity
@Table(name="sys_lendrecord")
public class LendRcord {
	private final static Logger LOG = LogManager.getLogger(LendRcord.class);
}
