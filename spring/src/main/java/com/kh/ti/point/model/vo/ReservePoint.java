package com.kh.ti.point.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class ReservePoint implements Serializable {
	//포인트적립내역
	private int pointId;		//포인트적립코드
	private int reservePoint;	//적립포인트
	private Date reserveDate;	//포인트적립일
	private int memberId;		//회원코드
	private int reserveType; 	//적립유형 	-10:일정작성, 20:일정리뷰, 30:여행지리뷰
	private int reviewId;		//여행리뷰코드
	private int spotReviewId;	//장소리뷰코드
	private int trvId;			//여행일정번호
	//가입:3000P, 일정작성:300P, 일정리뷰:50P, 여행지리뷰:10P
	private String month;		//검색월
	
	public ReservePoint() {}

	public ReservePoint(int pointId, int reservePoint, Date reserveDate, int memberId, int reserveType, int reviewId,
			int spotReviewId, int trvId, String month) {
		super();
		this.pointId = pointId;
		this.reservePoint = reservePoint;
		this.reserveDate = reserveDate;
		this.memberId = memberId;
		this.reserveType = reserveType;
		this.reviewId = reviewId;
		this.spotReviewId = spotReviewId;
		this.trvId = trvId;
		this.month = month;
	}

	public int getPointId() {
		return pointId;
	}

	public int getReservePoint() {
		return reservePoint;
	}

	public Date getReserveDate() {
		return reserveDate;
	}

	public int getMemberId() {
		return memberId;
	}

	public int getReserveType() {
		return reserveType;
	}

	public int getReviewId() {
		return reviewId;
	}

	public int getSpotReviewId() {
		return spotReviewId;
	}

	public int getTrvId() {
		return trvId;
	}

	public String getMonth() {
		return month;
	}

	public void setPointId(int pointId) {
		this.pointId = pointId;
	}

	public void setReservePoint(int reservePoint) {
		this.reservePoint = reservePoint;
	}

	public void setReserveDate(Date reserveDate) {
		this.reserveDate = reserveDate;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public void setReserveType(int reserveType) {
		this.reserveType = reserveType;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public void setSpotReviewId(int spotReviewId) {
		this.spotReviewId = spotReviewId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	@Override
	public String toString() {
		return "ReservePoint [pointId=" + pointId + ", reservePoint=" + reservePoint + ", reserveDate=" + reserveDate
				+ ", memberId=" + memberId + ", reserveType=" + reserveType + ", reviewId=" + reviewId
				+ ", spotReviewId=" + spotReviewId + ", trvId=" + trvId + ", month=" + month + "]";
	}

}
