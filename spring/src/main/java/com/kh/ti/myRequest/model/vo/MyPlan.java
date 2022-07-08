package com.kh.ti.myRequest.model.vo;

import java.sql.Date;

public class MyPlan {
	private int planId;			//설계번호
	private int reqId;			//의뢰번호
	private String planTitle;	//설계제목
	private Date endDate;		//마감일
	private String reqName;		//의뢰자
	private String memberId;	//설계자번호
	private int reqPrice;		//의뢰가격
	private String chooseStatus;	//채택여부
	
	public MyPlan() {}

	public MyPlan(int planId, int reqId, String planTitle, Date endDate, String reqName, String memberId, int reqPrice,
			String chooseStatus) {
		super();
		this.planId = planId;
		this.reqId = reqId;
		this.planTitle = planTitle;
		this.endDate = endDate;
		this.reqName = reqName;
		this.memberId = memberId;
		this.reqPrice = reqPrice;
		this.chooseStatus = chooseStatus;
	}

	public int getPlanId() {
		return planId;
	}

	public void setPlanId(int planId) {
		this.planId = planId;
	}

	public int getReqId() {
		return reqId;
	}

	public void setReqId(int reqId) {
		this.reqId = reqId;
	}

	public String getPlanTitle() {
		return planTitle;
	}

	public void setPlanTitle(String planTitle) {
		this.planTitle = planTitle;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getReqName() {
		return reqName;
	}

	public void setReqName(String reqName) {
		this.reqName = reqName;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getReqPrice() {
		return reqPrice;
	}

	public void setReqPrice(int reqPrice) {
		this.reqPrice = reqPrice;
	}

	public String getChooseStatus() {
		return chooseStatus;
	}

	public void setChooseStatus(String chooseStatus) {
		this.chooseStatus = chooseStatus;
	}

	@Override
	public String toString() {
		return "MyPlan [planId=" + planId + ", reqId=" + reqId + ", planTitle=" + planTitle + ", endDate=" + endDate
				+ ", reqName=" + reqName + ", memberId=" + memberId + ", reqPrice=" + reqPrice + ", chooseStatus="
				+ chooseStatus + "]";
	}
}
