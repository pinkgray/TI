package com.kh.ti.travel.model.vo;

public class TrvCost implements java.io.Serializable {

	private int costId;
	private String costContent;
	private double costAmount;
	private int schId;
	private int dayId;
	private String costType;
	private String currency;
	
	public TrvCost() {}

	public TrvCost(int costId, String costContent, double costAmount, String currency, int schId, int dayId,
			String costType) {
		super();
		this.costId = costId;
		this.costContent = costContent;
		this.costAmount = costAmount;
		this.currency = currency;
		this.schId = schId;
		this.dayId = dayId;
		this.costType = costType;
	}

	public int getCostId() {
		return costId;
	}

	public void setCostId(int costId) {
		this.costId = costId;
	}

	public String getCostContent() {
		return costContent;
	}

	public void setCostContent(String costContent) {
		this.costContent = costContent;
	}

	public double getCostAmount() {
		return costAmount;
	}

	public void setCostAmount(double costAmount) {
		this.costAmount = costAmount;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public int getSchId() {
		return schId;
	}

	public void setSchId(int schId) {
		this.schId = schId;
	}

	public int getDayId() {
		return dayId;
	}

	public void setDayId(int dayId) {
		this.dayId = dayId;
	}

	public String getCostType() {
		return costType;
	}

	public void setCostType(String costType) {
		this.costType = costType;
	}

	@Override
	public String toString() {
		return "TrvCost [costId=" + costId + ", costContent=" + costContent + ", costAmount=" + costAmount
				+ ", currency=" + currency + ", schId=" + schId + ", dayId=" + dayId + ", costType=" + costType + "]";
	}

	


	

	
	
}
