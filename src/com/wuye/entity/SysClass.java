package com.wuye.entity;

import java.sql.Timestamp;

/**
 * SysClass entity. @author MyEclipse Persistence Tools
 */

public class SysClass implements java.io.Serializable {

	// Fields

	private Integer classId;
	private String tableName;
	private String javaCode;
	private String statusCd;
	private Timestamp createDate;
	private Timestamp statusDate;
	private Timestamp updateDate;

	// Constructors

	/** default constructor */
	public SysClass() {
	}

	/** minimal constructor */
	public SysClass(String tableName) {
		this.tableName = tableName;
	}

	/** full constructor */
	public SysClass(String tableName, String javaCode, String statusCd,
			Timestamp createDate, Timestamp statusDate, Timestamp updateDate) {
		this.tableName = tableName;
		this.javaCode = javaCode;
		this.statusCd = statusCd;
		this.createDate = createDate;
		this.statusDate = statusDate;
		this.updateDate = updateDate;
	}

	// Property accessors

	public Integer getClassId() {
		return this.classId;
	}

	public void setClassId(Integer classId) {
		this.classId = classId;
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getJavaCode() {
		return this.javaCode;
	}

	public void setJavaCode(String javaCode) {
		this.javaCode = javaCode;
	}

	public String getStatusCd() {
		return this.statusCd;
	}

	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}

	public Timestamp getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public Timestamp getStatusDate() {
		return this.statusDate;
	}

	public void setStatusDate(Timestamp statusDate) {
		this.statusDate = statusDate;
	}

	public Timestamp getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}

}