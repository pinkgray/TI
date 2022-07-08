package com.kh.ti.travelBoard.model.vo;

import java.sql.Date;

public class TourReview implements java.io.Serializable {
	
	private int reviewId;
	private Date riviewDate;
	private String reviewStatus;
	private int grade;
	private int memberId;
	private String userName;
	private String reviewContent;
	private int trvId;
	
	private String writeStatus;
	
	public TourReview() {}

	public TourReview(int reviewId, Date riviewDate, String reviewStatus, int grade, int memberId, String userName,
			String reviewContent, int trvId, String writeStatus) {
		super();
		this.reviewId = reviewId;
		this.riviewDate = riviewDate;
		this.reviewStatus = reviewStatus;
		this.grade = grade;
		this.memberId = memberId;
		this.userName = userName;
		this.reviewContent = reviewContent;
		this.trvId = trvId;
		this.writeStatus = writeStatus;
	}

	public int getReviewId() {
		return reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public Date getRiviewDate() {
		return riviewDate;
	}

	public void setRiviewDate(Date riviewDate) {
		this.riviewDate = riviewDate;
	}

	public String getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public int getTrvId() {
		return trvId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public String getWriteStatus() {
		return writeStatus;
	}

	public void setWriteStatus(String writeStatus) {
		this.writeStatus = writeStatus;
	}

	@Override
	public String toString() {
		return "TourReview [reviewId=" + reviewId + ", riviewDate=" + riviewDate + ", reviewStatus=" + reviewStatus
				+ ", grade=" + grade + ", memberId=" + memberId + ", userName=" + userName + ", reviewContent="
				+ reviewContent + ", trvId=" + trvId + ", writeStatus=" + writeStatus + "]";
	}


}
