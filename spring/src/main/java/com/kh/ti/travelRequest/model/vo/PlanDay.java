package com.kh.ti.travelRequest.model.vo;

import java.io.Serializable;
import java.util.ArrayList;

//설계 여행일자
public class PlanDay implements Serializable {
	private int PdayId;		//설계일자 코드
	private String pDay;	//일자
	private String pDayMemo;	//메모
	private String openStatus = "N";	//공개여부
	private int planId;	//설계번호
	private int count = 1;
	private ArrayList<PlanPlace> placeList;	//일자장소들
	
	public PlanDay() {}

	
	public PlanDay(int pdayId, String pDay, String pDayMemo, String openStatus, int planId, int count,
			ArrayList<PlanPlace> placeList) {
		super();
		PdayId = pdayId;
		this.pDay = pDay;
		this.pDayMemo = pDayMemo;
		this.openStatus = openStatus;
		this.planId = planId;
		this.count = count;
		this.placeList = placeList;
	}

	public PlanDay(int pdayId, String pDay, String pDayMemo, String openStatus, int planId) {
		super();
		this.PdayId = pdayId;
		this.pDay = pDay;
		this.pDayMemo = pDayMemo;
		this.openStatus = openStatus;
		this.planId = planId;
	}


	public PlanDay(String pDay, String pDayMemo, String openStatus) {
		super();
		this.pDay = pDay;
		this.pDayMemo = pDayMemo;
		this.openStatus = openStatus;
	}


	public int getPdayId() {
		return PdayId;
	}


	public void setPdayId(int pdayId) {
		PdayId = pdayId;
	}


	public String getpDay() {
		return pDay;
	}


	public void setpDay(String pDay) {
		this.pDay = pDay;
	}


	public String getpDayMemo() {
		return pDayMemo;
	}


	public void setpDayMemo(String pDayMemo) {
		this.pDayMemo = pDayMemo;
	}


	public String getOpenStatus() {
		return openStatus;
	}


	public void setOpenStatus(String openStatus) {
		this.openStatus = openStatus;
	}


	public int getPlanId() {
		return planId;
	}


	public void setPlanId(int planId) {
		this.planId = planId;
	}


	public int getCount() {
		return count;
	}


	public void setCount(int count) {
		this.count = count;
	}


	public ArrayList<PlanPlace> getPlaceList() {
		return placeList;
	}


	public void setPlaceList(ArrayList<PlanPlace> placeList) {
		this.placeList = placeList;
	}


	@Override
	public String toString() {
		return "PlanDay [PdayId=" + PdayId + ", pDay=" + pDay + ", pDayMemo=" + pDayMemo + ", openStatus=" + openStatus
				+ ", planId=" + planId + ", count=" + count + ", placeList=" + placeList + "]";
	}
}
