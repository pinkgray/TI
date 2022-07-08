package com.kh.ti.travelRequest.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

import com.kh.ti.point.model.vo.Refund;

public class TravelRequest implements Serializable{
	private int requestId;	//의뢰번호
	private String requestTitle;	//제목
	private String requestContent;	//내용
	private Date endDate;	//의뢰마감일
	private int requestPrice;	//의뢰가격
	private int memberId;	//회원코드
	private String userName;	//회원명
	private String chooseStatus;	//채택상태
	private Date chooseDate;	//채택날짜
	private int trvCost;	//예산
	private ArrayList<TravelRequestPlan> planList;	//설계글 목록
	private ArrayList<Participation> participationList;	//참여글 목록
	private Refund refund;
	
	public TravelRequest() {}

	public TravelRequest(int requestId, String requestTitle, String requestContent, Date endDate, int requestPrice,
			int memberId, String userName, String chooseStatus, Date chooseDate, int trvCost,
			ArrayList<TravelRequestPlan> planList, ArrayList<Participation> participationList, Refund refund) {
		super();
		this.requestId = requestId;
		this.requestTitle = requestTitle;
		this.requestContent = requestContent;
		this.endDate = endDate;
		this.requestPrice = requestPrice;
		this.memberId = memberId;
		this.userName = userName;
		this.chooseStatus = chooseStatus;
		this.chooseDate = chooseDate;
		this.trvCost = trvCost;
		this.planList = planList;
		this.participationList = participationList;
		this.refund = refund;
	}

	public int getRequestId() {
		return requestId;
	}

	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}

	public String getRequestTitle() {
		return requestTitle;
	}

	public void setRequestTitle(String requestTitle) {
		this.requestTitle = requestTitle;
	}

	public String getRequestContent() {
		return requestContent;
	}

	public void setRequestContent(String requestContent) {
		this.requestContent = requestContent;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getRequestPrice() {
		return requestPrice;
	}

	public void setRequestPrice(int requestPrice) {
		this.requestPrice = requestPrice;
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

	public String getChooseStatus() {
		return chooseStatus;
	}

	public void setChooseStatus(String chooseStatus) {
		this.chooseStatus = chooseStatus;
	}

	public Date getChooseDate() {
		return chooseDate;
	}

	public void setChooseDate(Date chooseDate) {
		this.chooseDate = chooseDate;
	}

	public int getTrvCost() {
		return trvCost;
	}

	public void setTrvCost(int trvCost) {
		this.trvCost = trvCost;
	}

	public ArrayList<TravelRequestPlan> getPlanList() {
		return planList;
	}

	public void setPlanList(ArrayList<TravelRequestPlan> planList) {
		this.planList = planList;
	}

	public ArrayList<Participation> getParticipationList() {
		return participationList;
	}

	public void setParticipationList(ArrayList<Participation> participationList) {
		this.participationList = participationList;
	}

	public Refund getRefund() {
		return refund;
	}

	public void setRefund(Refund refund) {
		this.refund = refund;
	}

	@Override
	public String toString() {
		return "TravelRequest [requestId=" + requestId + ", requestTitle=" + requestTitle + ", requestContent="
				+ requestContent + ", endDate=" + endDate + ", requestPrice=" + requestPrice + ", memberId=" + memberId
				+ ", userName=" + userName + ", chooseStatus=" + chooseStatus + ", chooseDate=" + chooseDate
				+ ", trvCost=" + trvCost + ", planList=" + planList + ", participationList=" + participationList
				+ ", refund=" + refund + "]";
	}
}
