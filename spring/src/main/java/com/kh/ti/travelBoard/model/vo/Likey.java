package com.kh.ti.travelBoard.model.vo;

import java.sql.Date;

public class Likey implements java.io.Serializable {
	
	private int likeyId;
	private int memberId;
	private Date enrollDate;
	private String likeyType;
	private int spotId;
	private int trvId;
	
	public Likey() {}

	public Likey(int likeyId, int memberId, Date enrollDate, String likeyType, int spotId, int trvId) {
		super();
		this.likeyId = likeyId;
		this.memberId = memberId;
		this.enrollDate = enrollDate;
		this.likeyType = likeyType;
		this.spotId = spotId;
		this.trvId = trvId;
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

	@Override
	public String toString() {
		return "Likey [likeyId=" + likeyId + ", memberId=" + memberId + ", enrollDate=" + enrollDate + ", likeyType="
				+ likeyType + ", spotId=" + spotId + ", trvId=" + trvId + "]";
	}
	
	
	
}
