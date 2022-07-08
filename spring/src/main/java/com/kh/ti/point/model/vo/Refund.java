package com.kh.ti.point.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Refund implements Serializable {
	//환불내역
	private int refundId;		//환불코드
	private String refundReason;//환불사유
	private Date applyDate;		//환불신청일
	private Date processedDate;	//환불처리일
	private int refundStatus;	//환불신청여부	-10:대기, 20:승인, 30:거절
	private int pointId;		//포인트 사용내역코드
	
	private int memberId;
	private String email;
	private String userName;
	
	private int useType;
	private Date useDate;	//사용일
	private int trvId;		//여행일정번호
	private int requestId;	//의뢰번호
	private int usePoint;	//사용포인트
	
	private String trvTitle;
	
	private int planId;
	private String planTitle;	//설계제목
	
	public Refund() {}

	public Refund(int refundId, String refundReason, Date applyDate, Date processedDate, int refundStatus, int pointId,
			int memberId, String email, String userName, int useType, Date useDate, int trvId, int requestId,
			int usePoint, String trvTitle, int planId, String planTitle) {
		super();
		this.refundId = refundId;
		this.refundReason = refundReason;
		this.applyDate = applyDate;
		this.processedDate = processedDate;
		this.refundStatus = refundStatus;
		this.pointId = pointId;
		this.memberId = memberId;
		this.email = email;
		this.userName = userName;
		this.useType = useType;
		this.useDate = useDate;
		this.trvId = trvId;
		this.requestId = requestId;
		this.usePoint = usePoint;
		this.trvTitle = trvTitle;
		this.planId = planId;
		this.planTitle = planTitle;
	}

	public int getRefundId() {
		return refundId;
	}

	public String getRefundReason() {
		return refundReason;
	}

	public Date getApplyDate() {
		return applyDate;
	}

	public Date getProcessedDate() {
		return processedDate;
	}

	public int getRefundStatus() {
		return refundStatus;
	}

	public int getPointId() {
		return pointId;
	}

	public int getMemberId() {
		return memberId;
	}

	public String getEmail() {
		return email;
	}

	public String getUserName() {
		return userName;
	}

	public int getUseType() {
		return useType;
	}

	public Date getUseDate() {
		return useDate;
	}

	public int getTrvId() {
		return trvId;
	}

	public int getRequestId() {
		return requestId;
	}

	public int getUsePoint() {
		return usePoint;
	}

	public String getTrvTitle() {
		return trvTitle;
	}

	public int getPlanId() {
		return planId;
	}

	public String getPlanTitle() {
		return planTitle;
	}

	public void setRefundId(int refundId) {
		this.refundId = refundId;
	}

	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public void setProcessedDate(Date processedDate) {
		this.processedDate = processedDate;
	}

	public void setRefundStatus(int refundStatus) {
		this.refundStatus = refundStatus;
	}

	public void setPointId(int pointId) {
		this.pointId = pointId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setUseType(int useType) {
		this.useType = useType;
	}

	public void setUseDate(Date useDate) {
		this.useDate = useDate;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}

	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}

	public void setTrvTitle(String trvTitle) {
		this.trvTitle = trvTitle;
	}

	public void setPlanId(int planId) {
		this.planId = planId;
	}

	public void setPlanTitle(String planTitle) {
		this.planTitle = planTitle;
	}

	@Override
	public String toString() {
		return "Refund [refundId=" + refundId + ", refundReason=" + refundReason + ", applyDate=" + applyDate
				+ ", processedDate=" + processedDate + ", refundStatus=" + refundStatus + ", pointId=" + pointId
				+ ", memberId=" + memberId + ", email=" + email + ", userName=" + userName + ", useType=" + useType
				+ ", useDate=" + useDate + ", trvId=" + trvId + ", requestId=" + requestId + ", usePoint=" + usePoint
				+ ", trvTitle=" + trvTitle + ", planId=" + planId + ", planTitle=" + planTitle + "]";
	}
	
}
