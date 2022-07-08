package com.kh.ti.spot.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class SpotFile implements Serializable{
	private int fileId;
	private String filePath;
	private String changeName;
	private String orginName;
	private String picType;
	private Date uploadDate;
	private String picStatus;
	private int spotId;
	private int cityId;
	private int fileLevel;
	
	public SpotFile() {
		// TODO Auto-generated constructor stub
	}

	public SpotFile(int fileId, String filePath, String changeName, String orginName, String picType, Date uploadDate,
			String picStatus, int spotId, int cityId, int fileLevel) {
		super();
		this.fileId = fileId;
		this.filePath = filePath;
		this.changeName = changeName;
		this.orginName = orginName;
		this.picType = picType;
		this.uploadDate = uploadDate;
		this.picStatus = picStatus;
		this.spotId = spotId;
		this.cityId = cityId;
		this.fileLevel = fileLevel;
	}
	
	
	
	@Override
	public String toString() {
		return "SpotFile [fileId=" + fileId + ", filePath=" + filePath + ", changeName=" + changeName + ", orginName="
				+ orginName + ", picType=" + picType + ", uploadDate=" + uploadDate + ", picStatus=" + picStatus
				+ ", spotId=" + spotId + ", cityId=" + cityId + ", fileLevel=" + fileLevel + "]";
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	public String getOrginName() {
		return orginName;
	}

	public void setOrginName(String orginName) {
		this.orginName = orginName;
	}

	public String getPicType() {
		return picType;
	}

	public void setPicType(String picType) {
		this.picType = picType;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getPicStatus() {
		return picStatus;
	}

	public void setPicStatus(String picStatus) {
		this.picStatus = picStatus;
	}

	public int getSpotId() {
		return spotId;
	}

	public void setSpotId(int spotId) {
		this.spotId = spotId;
	}

	public int getCityId() {
		return cityId;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public int getFileLevel() {
		return fileLevel;
	}

	public void setFileLevel(int fileLevel) {
		this.fileLevel = fileLevel;
	}

}
