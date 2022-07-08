package com.kh.ti.spot.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class SpotReviews implements Serializable{
	
	private int spotReviewId;
	private String reviewContent;
	private Date reviewDate;
	private Date modifyDate;
	private Date delDate;
	private int memberId;
	private int spotId;
	private int grade;
	
	public SpotReviews() {
		// TODO Auto-generated constructor stub
	}

	public SpotReviews(int spotReviewId, String reviewContent, Date reviewDate, Date modifyDate, Date delDate,
			int memberId, int spotId, int grade) {
		super();
		this.spotReviewId = spotReviewId;
		this.reviewContent = reviewContent;
		this.reviewDate = reviewDate;
		this.modifyDate = modifyDate;
		this.delDate = delDate;
		this.memberId = memberId;
		this.spotId = spotId;
		this.grade = grade;
	}

	@Override
	public String toString() {
		return "SpotReviews [spotReviewId=" + spotReviewId + ", reviewContent=" + reviewContent + ", reviewDate="
				+ reviewDate + ", modifyDate=" + modifyDate + ", delDate=" + delDate + ", memberId=" + memberId
				+ ", spotId=" + spotId + ", grade=" + grade + "]";
	}

	public int getSpotReviewId() {
		return spotReviewId;
	}

	public void setSpotReviewId(int spotReviewId) {
		this.spotReviewId = spotReviewId;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public Date getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getSpotId() {
		return spotId;
	}

	public void setSpotId(int spotId) {
		this.spotId = spotId;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	

}
