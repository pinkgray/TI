package com.kh.ti.travelRequest.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Participation implements Serializable{
	private int ptcpId;				//참여번호
	private String chooseStatus;	//채택여부
	private Date ptcpDate;			//참여일
	private Date chooseDate;		//채택일
	private int requestId;			//의뢰번호
	private int planId;				//설계번호
	
	public Participation() {}

	public Participation(int ptcpId, String chooseStatus, Date ptcpDate, Date chooseDate, int requestId, int planId) {
		super();
		this.ptcpId = ptcpId;
		this.chooseStatus = chooseStatus;
		this.ptcpDate = ptcpDate;
		this.chooseDate = chooseDate;
		this.requestId = requestId;
		this.planId = planId;
	}

	public int getPtcpId() {
		return ptcpId;
	}

	public void setPtcpId(int ptcpId) {
		this.ptcpId = ptcpId;
	}

	public String getChooseStatus() {
		return chooseStatus;
	}

	public void setChooseStatus(String chooseStatus) {
		this.chooseStatus = chooseStatus;
	}

	public Date getPtcpDate() {
		return ptcpDate;
	}

	public void setPtcpDate(Date ptcpDate) {
		this.ptcpDate = ptcpDate;
	}

	public Date getChooseDate() {
		return chooseDate;
	}

	public void setChooseDate(Date chooseDate) {
		this.chooseDate = chooseDate;
	}

	public int getRequestId() {
		return requestId;
	}

	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}

	public int getPlanId() {
		return planId;
	}

	public void setPlanId(int planId) {
		this.planId = planId;
	}

	@Override
	public String toString() {
		return "Participation [ptcpId=" + ptcpId + ", chooseStatus=" + chooseStatus + ", ptcpDate=" + ptcpDate
				+ ", chooseDate=" + chooseDate + ", requestId=" + requestId + ", planId=" + planId + "]";
	}
}
