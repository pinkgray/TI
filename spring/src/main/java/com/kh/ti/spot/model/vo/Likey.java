package com.kh.ti.spot.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Likey implements Serializable{
	private int likeyId;
	private int memberId;
	private Date enrollDate;
	private String likeyType;
	private int spotId;
	private int trvId;
	private SpotList spotList;
	
	public Likey() {
		// TODO Auto-generated constructor stub
	}

	public Likey(int likeyId, int memberId, Date enrollDate, String likeyType, int spotId, int trvId,
			SpotList spotList) {
		super();
		this.likeyId = likeyId;
		this.memberId = memberId;
		this.enrollDate = enrollDate;
		this.likeyType = likeyType;
		this.spotId = spotId;
		this.trvId = trvId;
		this.spotList = spotList;
	}

	public Likey(int likeyId, int memberId, Date enrollDate, String likeyType, int spotId) {
		super();
		this.likeyId = likeyId;
		this.memberId = memberId;
		this.enrollDate = enrollDate;
		this.likeyType = likeyType;
		this.spotId = spotId;
	}

	public int getLikeyId() {
		return likeyId;
	}

	public void setLikeyId(int likeyId) {
		this.likeyId = likeyId;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public String getLikeyType() {
		return likeyType;
	}

	public void setLikeyType(String likeyType) {
		this.likeyType = likeyType;
	}

	public int getSpotId() {
		return spotId;
	}

	public void setSpotId(int spotId) {
		this.spotId = spotId;
	}

	public int getTrvId() {
		return trvId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public SpotList getSpotList() {
		return spotList;
	}

	public void setSpotList(SpotList spotList) {
		this.spotList = spotList;
	}

	@Override
	public String toString() {
		return "Likey [likeyId=" + likeyId + ", memberId=" + memberId + ", enrollDate=" + enrollDate + ", likeyType="
				+ likeyType + ", spotId=" + spotId + ", trvId=" + trvId + ", spotList=" + spotList + "]";
	}
	
}
