package com.kh.ti.travel.model.vo;

public class TrvTag implements java.io.Serializable{

	private int trvId;
	private int tagId;
	private String tagName;
	
	public TrvTag() {}
	
	public TrvTag(int trvId, int tagId, String tagName) {
		super();
		this.trvId = trvId;
		this.tagId = tagId;
		this.tagName = tagName;
	}

	public int getTrvId() {
		return trvId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public int getTagId() {
		return tagId;
	}

	public void setTagId(int tagId) {
		this.tagId = tagId;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	@Override
	public String toString() {
		return "TrvTag [trvId=" + trvId + ", tagId=" + tagId + ", tagName=" + tagName + "]";
	}
	
	
	
}
