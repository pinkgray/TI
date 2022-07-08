package com.kh.ti.point.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class UsePoint implements Serializable {
	//포인트 사용내역
	private int pointId;	//사용내역코드
	private int usePoint;	//사용포인트
	private Date useDate;	//사용일
	private int useType;	//사용타입	-10:일정구매, 20:설계의뢰
	private int memberId;	//회원코드
	private int trvId;		//여행일정번호
	private int requestId;	//의뢰번호
	private String month;	//검색월
	private Refund refund;
	
	public UsePoint() {}

	public UsePoint(int pointId, int usePoint, Date useDate, int useType, int memberId, int trvId, int requestId,
			String month, Refund refund) {
		super();
		this.pointId = pointId;
		this.usePoint = usePoint;
		this.useDate = useDate;
		this.useType = useType;
		this.memberId = memberId;
		this.trvId = trvId;
		this.requestId = requestId;
		this.month = month;
		this.refund = refund;
	}

	public int getPointId() {
		return pointId;
	}

	public int getUsePoint() {
		return usePoint;
	}

	public Date getUseDate() {
		return useDate;
	}

	public int getUseType() {
		return useType;
	}

	public int getMemberId() {
		return memberId;
	}

	public int getTrvId() {
		return trvId;
	}

	public int getRequestId() {
		return requestId;
	}

	public String getMonth() {
		return month;
	}

	public Refund getRefund() {
		return refund;
	}

	public void setPointId(int pointId) {
		this.pointId = pointId;
	}

	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}

	public void setUseDate(Date useDate) {
		this.useDate = useDate;
	}

	public void setUseType(int useType) {
		this.useType = useType;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public void setRefund(Refund refund) {
		this.refund = refund;
	}

	@Override
	public String toString() {
		return "UsePoint [pointId=" + pointId + ", usePoint=" + usePoint + ", useDate=" + useDate + ", useType="
				+ useType + ", memberId=" + memberId + ", trvId=" + trvId + ", requestId=" + requestId + ", month="
				+ month + ", refund=" + refund + "]";
	}

}
