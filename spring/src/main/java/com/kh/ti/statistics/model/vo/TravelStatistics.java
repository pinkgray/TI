package com.kh.ti.statistics.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class TravelStatistics implements Serializable {
	
	//선호 나라 조회용
	private int rownum;
	private String year;
	private String month;
	private String countryNameEn;
	private String countryNameKo;
	private int countryCount;
	
	//선호 태그 조회용
	private String tagName;
	private int tagCount;
	
	public TravelStatistics() {}

	public TravelStatistics(int rownum, String year, String month, String countryNameEn, String countryNameKo,
			int countryCount, String tagName, int tagCount) {
		super();
		this.rownum = rownum;
		this.year = year;
		this.month = month;
		this.countryNameEn = countryNameEn;
		this.countryNameKo = countryNameKo;
		this.countryCount = countryCount;
		this.tagName = tagName;
		this.tagCount = tagCount;
	}

	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getCountryNameEn() {
		return countryNameEn;
	}

	public void setCountryNameEn(String countryNameEn) {
		this.countryNameEn = countryNameEn;
	}

	public String getCountryNameKo() {
		return countryNameKo;
	}

	public void setCountryNameKo(String countryNameKo) {
		this.countryNameKo = countryNameKo;
	}

	public int getCountryCount() {
		return countryCount;
	}

	public void setCountryCount(int countryCount) {
		this.countryCount = countryCount;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public int getTagCount() {
		return tagCount;
	}

	public void setTagCount(int tagCount) {
		this.tagCount = tagCount;
	}

	@Override
	public String toString() {
		return "TravelStatistics [rownum=" + rownum + ", year=" + year + ", month=" + month + ", countryNameEn="
				+ countryNameEn + ", countryNameKo=" + countryNameKo + ", countryCount=" + countryCount + ", tagName="
				+ tagName + ", tagCount=" + tagCount + "]";
	}

}
