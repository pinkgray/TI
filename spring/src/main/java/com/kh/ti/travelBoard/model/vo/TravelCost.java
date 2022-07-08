package com.kh.ti.travelBoard.model.vo;

import java.sql.Date;
import java.util.ArrayList;

public class TravelCost implements java.io.Serializable {
	private int dayNumber;
	private Date dayDate;
	
	private String roomCharge;
	private String trafficCharge;
	private String foodCharge;
	private String shoppingCharge;
	private String sightseeingCharge;
	private String etcCharge;
	private String totalCost;
	
	private ArrayList trvCost;
	
	public TravelCost() {}

	public TravelCost(int dayNumber, Date dayDate, String roomCharge, String trafficCharge, String foodCharge,
			String shoppingCharge, String sightseeingCharge, String etcCharge, String totalCost, ArrayList trvCost) {
		super();
		this.dayNumber = dayNumber;
		this.dayDate = dayDate;
		this.roomCharge = roomCharge;
		this.trafficCharge = trafficCharge;
		this.foodCharge = foodCharge;
		this.shoppingCharge = shoppingCharge;
		this.sightseeingCharge = sightseeingCharge;
		this.etcCharge = etcCharge;
		this.totalCost = totalCost;
		this.trvCost = trvCost;
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

	public String getRoomCharge() {
		return roomCharge;
	}

	public void setRoomCharge(String roomCharge) {
		this.roomCharge = roomCharge;
	}

	public String getTrafficCharge() {
		return trafficCharge;
	}

	public void setTrafficCharge(String trafficCharge) {
		this.trafficCharge = trafficCharge;
	}

	public String getFoodCharge() {
		return foodCharge;
	}

	public void setFoodCharge(String foodCharge) {
		this.foodCharge = foodCharge;
	}

	public String getShoppingCharge() {
		return shoppingCharge;
	}

	public void setShoppingCharge(String shoppingCharge) {
		this.shoppingCharge = shoppingCharge;
	}

	public String getSightseeingCharge() {
		return sightseeingCharge;
	}

	public void setSightseeingCharge(String sightseeingCharge) {
		this.sightseeingCharge = sightseeingCharge;
	}

	public String getEtcCharge() {
		return etcCharge;
	}

	public void setEtcCharge(String etcCharge) {
		this.etcCharge = etcCharge;
	}

	public String getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(String totalCost) {
		this.totalCost = totalCost;
	}

	public ArrayList getTrvCost() {
		return trvCost;
	}

	public void setTrvCost(ArrayList trvCost) {
		this.trvCost = trvCost;
	}

	@Override
	public String toString() {
		return "TravelCost [dayNumber=" + dayNumber + ", dayDate=" + dayDate + ", roomCharge=" + roomCharge
				+ ", trafficCharge=" + trafficCharge + ", foodCharge=" + foodCharge + ", shoppingCharge="
				+ shoppingCharge + ", sightseeingCharge=" + sightseeingCharge + ", etcCharge=" + etcCharge
				+ ", totalCost=" + totalCost + ", trvCost=" + trvCost + "]\n";
	}

	

}
