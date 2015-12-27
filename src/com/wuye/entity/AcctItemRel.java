package com.wuye.entity;

import java.sql.Timestamp;

/**
 * AcctItemRel entity. @author MyEclipse Persistence Tools
 */

public class AcctItemRel extends BaseEntity implements java.io.Serializable {

	// Fields

	private Integer acctItemRelId;
	private AcctItemType acctItemType;
	private String classId;
	private Integer objId;
	private Float price;
	private Integer floor;
	

	// Constructors

	/** default constructor */
	public AcctItemRel() {
	}

	/** full constructor */
	public AcctItemRel(AcctItemType acctItemType, String classId,
			Integer objId, Float price, Integer floor, Timestamp createDate,
			Timestamp updateDate, String statusCd, Timestamp statusDate) {
		this.acctItemType = acctItemType;
		this.classId = classId;
		this.objId = objId;
		this.price = price;
		this.floor = floor;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.statusCd = statusCd;
		this.statusDate = statusDate;
	}

	// Property accessors

	public Integer getAcctItemRelId() {
		return super.getId();
	}

	public void setAcctItemRelId(Integer acctItemRelId) {
		super.setId(acctItemRelId);
	}

	public AcctItemType getAcctItemType() {
		return this.acctItemType;
	}

	public void setAcctItemType(AcctItemType acctItemType) {
		this.acctItemType = acctItemType;
	}

	public String getClassId() {
		return this.classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}

	public Integer getObjId() {
		return this.objId;
	}

	public void setObjId(Integer objId) {
		this.objId = objId;
	}

	public Float getPrice() {
		return this.price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public Integer getFloor() {
		return this.floor;
	}

	public void setFloor(Integer floor) {
		this.floor = floor;
	}

}