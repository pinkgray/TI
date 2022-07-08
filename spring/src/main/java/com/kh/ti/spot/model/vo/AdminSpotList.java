package com.kh.ti.spot.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class AdminSpotList implements Serializable{
	private int spotId;
	private String spotNameKo;
	private String spotAddress;
	private int cityId;
	private String cityNameKo;
	private int countryId;
	private String countryNameKo;
	private Date enrollDate;
	private String spotStatus;
	private int plctypeId;
	
	public AdminSpotList() {
		// TODO Auto-generated constructor stub
	}

	public AdminSpotList(int spotId, String spotNameKo, String spotAddress, int cityId, String cityNameKo,
			int countryId, String countryNameKo, Date enrollDate, String spotStatus, int plctypeId) {
		super();
		this.spotId = spotId;
		this.spotNameKo = spotNameKo;
		this.spotAddress = spotAddress;
		this.cityId = cityId;
		this.cityNameKo = cityNameKo;
		this.countryId = countryId;
		this.countryNameKo = countryNameKo;
		this.enrollDate = enrollDate;
		this.spotStatus = spotStatus;
		this.plctypeId = plctypeId;
	}

	@Override
	public String toString() {
		return "AdminSpotList [spotId=" + spotId + ", spotNameKo=" + spotNameKo + ", spotAddress=" + spotAddress
				+ ", cityId=" + cityId + ", cityNameKo=" + cityNameKo + ", countryId=" + countryId + ", countryNameKo="
				+ countryNameKo + ", enrollDate=" + enrollDate + ", spotStatus=" + spotStatus + ", plctypeId="
				+ plctypeId + "]";
	}

	public int getSpotId() {
		return spotId;
	}

	public void setSpotId(int spotId) {
		this.spotId = spotId;
	}

	public String getSpotNameKo() {
		return spotNameKo;
	}

	public void setSpotNameKo(String spotNameKo) {
		this.spotNameKo = spotNameKo;
	}

	public String getSpotAddress() {
		return spotAddress;
	}

	public void setSpotAddress(String spotAddress) {
		this.spotAddress = spotAddress;
	}

	public int getCityId() {
		return cityId;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public String getCityNameKo() {
		return cityNameKo;
	}

	public void setCityNameKo(String cityNameKo) {
		this.cityNameKo = cityNameKo;
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	public String getCountryNameKo() {
		return countryNameKo;
	}

	public void setCountryNameKo(String countryNameKo) {
		this.countryNameKo = countryNameKo;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public String getSpotStatus() {
		return spotStatus;
	}

	public void setSpotStatus(String spotStatus) {
		this.spotStatus = spotStatus;
	}

	public int getPlctypeId() {
		return plctypeId;
	}

	public void setPlctypeId(int plctypeId) {
		this.plctypeId = plctypeId;
	}
	
	
}
