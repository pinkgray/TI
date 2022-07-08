package com.kh.ti.travel.model.vo;

import java.sql.Date;
import java.util.ArrayList;

public class TrvDay implements java.io.Serializable {

	private int dayId;
	private int dayNumber;
	private Date dayDate;
	private String dayMemo;
	private String dayWeather;
	private int trvId;
	private ArrayList<TrvSchedule> schList;
	private ArrayList<TrvCost> costList;
	
	public TrvDay() {}

	public TrvDay(int dayId, int dayNumber, Date dayDate, String dayMemo, String dayWeather, int trvId,
			ArrayList<TrvSchedule> schList, ArrayList<TrvCost> costList) {
		super();
		this.dayId = dayId;
		this.dayNumber = dayNumber;
		this.dayDate = dayDate;
		this.dayMemo = dayMemo;
		this.dayWeather = dayWeather;
		this.trvId = trvId;
		this.schList = schList;
		this.costList = costList;
	}

	public int getDayId() {
		return dayId;
	}

	public void setDayId(int dayId) {
		this.dayId = dayId;
	}

	public int getDayNumber() {
		return dayNumber;
	}

	public void setDayNumber(int dayNumber) {
		this.dayNumber = dayNumber;
	}

	public Date getDayDate() {
		return dayDate;
	}

	public void setDayDate(Date dayDate) {
		this.dayDate = dayDate;
	}

	public String getDayMemo() {
		return dayMemo;
	}

	public void setDayMemo(String dayMemo) {
		this.dayMemo = dayMemo;
	}

	public String getDayWeather() {
		return dayWeather;
	}

	public void setDayWeather(String dayWeather) {
		this.dayWeather = dayWeather;
	}

	public int getTrvId() {
		return trvId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public ArrayList<TrvSchedule> getSchList() {
		return schList;
	}

	public void setSchList(ArrayList<TrvSchedule> schList) {
		this.schList = schList;
	}

	public ArrayList<TrvCost> getCostList() {
		return costList;
	}

	public void setCostList(ArrayList<TrvCost> costList) {
		this.costList = costList;
	}

	@Override
	public String toString() {
		return "TrvDay [dayId=" + dayId + ", dayNumber=" + dayNumber + ", dayDate=" + dayDate + ", dayMemo=" + dayMemo
				+ ", dayWeather=" + dayWeather + ", trvId=" + trvId + ", schList=" + schList + ", costList=" + costList
				+ "]";
	}

	
	
	
	
	
	
}
