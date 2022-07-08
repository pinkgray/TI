package com.kh.ti.travel.model.vo;

import java.util.ArrayList;

public class TrvSchedule implements java.io.Serializable {

	private int schId;
	private String schTitle;
	private int schNumber;
	private String startTime;
	private String endTime;
	private String isTimeset;
	private String schContent;
	private String schTransp;
	private String plcId;
	private String plcName;
	private int dayId;
	private int likeyId;
	private int spotId;
	private TrvCost trvCost;
	private ArrayList<SchFile> fileList;
	
	public TrvSchedule() {}

	public TrvSchedule(int schId, String schTitle, int schNumber, String startTime, String endTime, String isTimeset,
			String schContent, String schTransp, String plcId, String plcName, int dayId, int likeyId, int spotId,
			TrvCost trvCost, ArrayList<SchFile> fileList) {
		super();
		this.schId = schId;
		this.schTitle = schTitle;
		this.schNumber = schNumber;
		this.startTime = startTime;
		this.endTime = endTime;
		this.isTimeset = isTimeset;
		this.schContent = schContent;
		this.schTransp = schTransp;
		this.plcId = plcId;
		this.plcName = plcName;
		this.dayId = dayId;
		this.likeyId = likeyId;
		this.spotId = spotId;
		this.trvCost = trvCost;
		this.fileList = fileList;
	}

	public int getSchId() {
		return schId;
	}

	public void setSchId(int schId) {
		this.schId = schId;
	}

	public String getSchTitle() {
		return schTitle;
	}

	public void setSchTitle(String schTitle) {
		this.schTitle = schTitle;
	}

	public int getSchNumber() {
		return schNumber;
	}

	public void setSchNumber(int schNumber) {
		this.schNumber = schNumber;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getIsTimeset() {
		return isTimeset;
	}

	public void setIsTimeset(String isTimeset) {
		this.isTimeset = isTimeset;
	}

	public String getSchContent() {
		return schContent;
	}

	public void setSchContent(String schContent) {
		this.schContent = schContent;
	}

	public String getSchTransp() {
		return schTransp;
	}

	public void setSchTransp(String schTransp) {
		this.schTransp = schTransp;
	}

	public String getPlcId() {
		return plcId;
	}

	public void setPlcId(String plcId) {
		this.plcId = plcId;
	}

	public String getPlcName() {
		return plcName;
	}

	public void setPlcName(String plcName) {
		this.plcName = plcName;
	}

	public int getDayId() {
		return dayId;
	}

	public void setDayId(int dayId) {
		this.dayId = dayId;
	}

	public int getLikeyId() {
		return likeyId;
	}

	public void setLikeyId(int likeyId) {
		this.likeyId = likeyId;
	}

	public int getSpotId() {
		return spotId;
	}

	public void setSpotId(int spotId) {
		this.spotId = spotId;
	}

	public TrvCost getTrvCost() {
		return trvCost;
	}

	public void setTrvCost(TrvCost trvCost) {
		this.trvCost = trvCost;
	}

	public ArrayList<SchFile> getFileList() {
		return fileList;
	}

	public void setFileList(ArrayList<SchFile> fileList) {
		this.fileList = fileList;
	}

	@Override
	public String toString() {
		return "TrvSchedule [schId=" + schId + ", schTitle=" + schTitle + ", schNumber=" + schNumber + ", startTime="
				+ startTime + ", endTime=" + endTime + ", isTimeset=" + isTimeset + ", schContent=" + schContent
				+ ", schTransp=" + schTransp + ", plcId=" + plcId + ", plcName=" + plcName + ", dayId=" + dayId
				+ ", likeyId=" + likeyId + ", spotId=" + spotId + ", trvCost=" + trvCost + ", fileList=" + fileList
				+ "]";
	}

	
	

	
	
	
	
}
