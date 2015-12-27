package com.wuye.entity;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * MeterSpec entity. @author MyEclipse Persistence Tools
 */

public class MeterSpec extends BaseEntity implements java.io.Serializable {

	// Fields

	private Integer meterSpecId;
	private String meterType;
	private Integer parentMeterId;
	private String meterName;
	private String unit;
	private Float price;
	private String classId;
	private Integer attribute55;
	private Set meterInsts = new HashSet(0);

	// Constructors

	/** default constructor */
	public MeterSpec() {
	}

	/** minimal constructor */
	public MeterSpec(String meterType, String meterName) {
		this.meterType = meterType;
		this.meterName = meterName;
	}

	/** full constructor */
	public MeterSpec(String meterType, Integer parentMeterId, String meterName,
			String unit, Float price, String classId, Integer attribute55,
			Timestamp createDate, Timestamp updateDate, String statusCd,
			Timestamp statusDate, Set meterInsts) {
		this.meterType = meterType;
		this.parentMeterId = parentMeterId;
		this.meterName = meterName;
		this.unit = unit;
		this.price = price;
		this.classId = classId;
		this.attribute55 = attribute55;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.statusCd = statusCd;
		this.statusDate = statusDate;
		this.meterInsts = meterInsts;
	}

	// Property accessors

	public Integer getMeterSpecId() {
		return super.getId();
	}

	public void setMeterSpecId(Integer meterSpecId) {
		super.setId(meterSpecId);
	}

	public String getMeterType() {
		return this.meterType;
	}

	public void setMeterType(String meterType) {
		this.meterType = meterType;
	}

	public Integer getParentMeterId() {
		return this.parentMeterId;
	}

	public void setParentMeterId(Integer parentMeterId) {
		this.parentMeterId = parentMeterId;
	}

	public String getMeterName() {
		return this.meterName;
	}

	public void setMeterName(String meterName) {
		this.meterName = meterName;
	}

	public String getUnit() {
		return this.unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public Float getPrice() {
		return this.price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public String getClassId() {
		return this.classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}

	public Integer getAttribute55() {
		return this.attribute55;
	}

	public void setAttribute55(Integer attribute55) {
		this.attribute55 = attribute55;
	}

	public Set getMeterInsts() {
		return this.meterInsts;
	}

	public void setMeterInsts(Set meterInsts) {
		this.meterInsts = meterInsts;
	}

}