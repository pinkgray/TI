package com.kh.ti.point.model.vo;

import java.io.Serializable;
import java.sql.Date;

import com.kh.ti.travel.model.vo.Travel;
import com.kh.ti.travelRequest.model.vo.Participation;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

public class Proceeds implements Serializable {
	//수익금 발생 내역
	private int proceedsId;		//수익금발생코드	
	private int proceeds;		//수익발생액
	private Date proceedsDate;	//수익발생일
	private int proceedsType;	//발생타입	-10:일정판매, 20:설계판매
	private int memberId;		//회원코드
	private int trvId;			//여행일정번호
	private int ptcpId;			//참여번호
	private String month;		//검색월
	
	private String userName;
	private String email;
	
	private Travel travel;
	private TravelRequest travelRequest;
	private TravelRequestPlan travelRequestPlan;
	private Participation participation;
	
	public Proceeds() {}

	public Proceeds(int proceedsId, int proceeds, Date proceedsDate, int proceedsType, int memberId, int trvId,
			int ptcpId, String month, String userName, String email, Travel travel, TravelRequest travelRequest,
			TravelRequestPlan travelRequestPlan, Participation participation) {
		super();
		this.proceedsId = proceedsId;
		this.proceeds = proceeds;
		this.proceedsDate = proceedsDate;
		this.proceedsType = proceedsType;
		this.memberId = memberId;
		this.trvId = trvId;
		this.ptcpId = ptcpId;
		this.month = month;
		this.userName = userName;
		this.email = email;
		this.travel = travel;
		this.travelRequest = travelRequest;
		this.travelRequestPlan = travelRequestPlan;
		this.participation = participation;
	}

	public int getProceedsId() {
		return proceedsId;
	}

	public int getProceeds() {
		return proceeds;
	}

	public Date getProceedsDate() {
		return proceedsDate;
	}

	public int getProceedsType() {
		return proceedsType;
	}

	public int getMemberId() {
		return memberId;
	}

	public int getTrvId() {
		return trvId;
	}

	public int getPtcpId() {
		return ptcpId;
	}

	public String getMonth() {
		return month;
	}

	public String getUserName() {
		return userName;
	}

	public String getEmail() {
		return email;
	}

	public Travel getTravel() {
		return travel;
	}

	public TravelRequest getTravelRequest() {
		return travelRequest;
	}

	public TravelRequestPlan getTravelRequestPlan() {
		return travelRequestPlan;
	}

	public Participation getParticipation() {
		return participation;
	}

	public void setProceedsId(int proceedsId) {
		this.proceedsId = proceedsId;
	}

	public void setProceeds(int proceeds) {
		this.proceeds = proceeds;
	}

	public void setProceedsDate(Date proceedsDate) {
		this.proceedsDate = proceedsDate;
	}

	public void setProceedsType(int proceedsType) {
		this.proceedsType = proceedsType;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public void setPtcpId(int ptcpId) {
		this.ptcpId = ptcpId;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setTravel(Travel travel) {
		this.travel = travel;
	}

	public void setTravelRequest(TravelRequest travelRequest) {
		this.travelRequest = travelRequest;
	}

	public void setTravelRequestPlan(TravelRequestPlan travelRequestPlan) {
		this.travelRequestPlan = travelRequestPlan;
	}

	public void setParticipation(Participation participation) {
		this.participation = participation;
	}

	@Override
	public String toString() {
		return "Proceeds [proceedsId=" + proceedsId + ", proceeds=" + proceeds + ", proceedsDate=" + proceedsDate
				+ ", proceedsType=" + proceedsType + ", memberId=" + memberId + ", trvId=" + trvId + ", ptcpId="
				+ ptcpId + ", month=" + month + ", userName=" + userName + ", email=" + email + ", travel=" + travel
				+ ", travelRequest=" + travelRequest + ", travelRequestPlan=" + travelRequestPlan + ", participation="
				+ participation + "]";
	}

}
