package com.kh.ti.Chatting.model.vo;

public class RankTagList {
	
	private int tagNum;
	private String tagName;
	private int tagCount;
	
	private int CountryNum;
	private String CountryName;
	private int CountryCount;
	
	public RankTagList() {}
	
	public RankTagList(int tagNum, String tagName, int tagCount, int countryNum, String countryName, int countryCount) {
		super();
		this.tagNum = tagNum;
		this.tagName = tagName;
		this.tagCount = tagCount;
		CountryNum = countryNum;
		CountryName = countryName;
		CountryCount = countryCount;
	}


	public int getTagNum() {
		return tagNum;
	}
	public void setTagNum(int tagNum) {
		this.tagNum = tagNum;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public int getCountryNum() {
		return CountryNum;
	}
	public void setCountryNum(int countryNum) {
		CountryNum = countryNum;
	}
	public String getCountryName() {
		return CountryName;
	}
	public void setCountryName(String countryName) {
		CountryName = countryName;
	}
	
	public int getTagCount() {
		return tagCount;
	}

	public void setTagCount(int tagCount) {
		this.tagCount = tagCount;
	}

	public int getCountryCount() {
		return CountryCount;
	}

	public void setCountryCount(int countryCount) {
		CountryCount = countryCount;
	}

	@Override
	public String toString() {
		return "RankTagList [tagNum=" + tagNum + ", tagName=" + tagName + ", tagCount=" + tagCount + ", CountryNum="
				+ CountryNum + ", CountryName=" + CountryName + ", CountryCount=" + CountryCount + "]";
	}

	
	
	
}
