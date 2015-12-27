package com.wuye.entity;

import java.sql.Timestamp;

/**
 * AttrValue entity. @author MyEclipse Persistence Tools
 */

public class AttrValue extends BaseEntity implements java.io.Serializable {

	// Fields

	private Integer attrValueId;
	private Integer attrId;
	private AttrSpec attrSpec;
	private String attrValueName;
	private String attrValue;
	private Integer communityId;
	
	

	// Constructors

	/** default constructor */
	public AttrValue() {
	}

	/** minimal constructor */
	public AttrValue(Integer communityId) {
		this.communityId = communityId;
	}

	/** full constructor */
	public AttrValue(AttrSpec attrSpec, String attrValueName, String attrValue,
			Integer communityId, Timestamp createDate, Timestamp updateDate,
			String statusCd, Timestamp statusDate) {
		this.attrSpec = attrSpec;
		this.attrValueName = attrValueName;
		this.attrValue = attrValue;
		this.communityId = communityId;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.statusCd = statusCd;
		this.statusDate = statusDate;
	}

	// Property accessors

	public Integer getAttrValueId() {
		return super.getId();
	}

	public void setAttrValueId(Integer attrValueId) {
		super.setId(attrValueId);
	}

	public AttrSpec getAttrSpec() {
		return this.attrSpec;
	}

	public void setAttrSpec(AttrSpec attrSpec) {
		this.attrSpec = attrSpec;
	}

	public String getAttrValueName() {
		return this.attrValueName;
	}

	public void setAttrValueName(String attrValueName) {
		this.attrValueName = attrValueName;
	}

	public String getAttrValue() {
		return this.attrValue;
	}

	public void setAttrValue(String attrValue) {
		this.attrValue = attrValue;
	}

	public Integer getCommunityId() {
		return this.communityId;
	}

	public void setCommunityId(Integer communityId) {
		this.communityId = communityId;
	}
	public Integer getAttrId() {
		return this.attrId;
	}

	public void setAttrId(Integer attrId) {
		this.attrId = attrId;
	}
	
}