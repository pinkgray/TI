package com.kh.ti.travelRequest.model.vo;

import java.io.Serializable;

public class PlanDayList implements Serializable {
	private String pDay;
	private String pDayMemo;
	
	public PlanDayList() {}

	public PlanDayList(String pDay, String pDayMemo) {
		super();
		this.pDay = pDay;
		this.pDayMemo = pDayMemo;
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

	@Override
	public String toString() {
		return "PlanDayList [pDay=" + pDay + ", pDayMemo=" + pDayMemo + "]";
	}
}
