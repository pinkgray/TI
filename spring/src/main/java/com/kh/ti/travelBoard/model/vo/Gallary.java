package com.kh.ti.travelBoard.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Gallary implements Serializable{
	private int fileId;
	private String originName;
	private String changeName;
	private String filePath;
	private Date uploadDate;
	private int fileLevel;
	private String fileCaption;
	private int schId;
	private String fileStatus;
	private int dayNumber;
	
	public Gallary() {}

	public Gallary(int fileId, String originName, String changeName, String filePath, Date uploadDate, int fileLevel,
			String fileCaption, int schId, String fileStatus, int dayNumber) {
		super();
		this.fileId = fileId;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.uploadDate = uploadDate;
		this.fileLevel = fileLevel;
		this.fileCaption = fileCaption;
		this.schId = schId;
		this.fileStatus = fileStatus;
		this.dayNumber = dayNumber;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public int getFileLevel() {
		return fileLevel;
	}

	public void setFileLevel(int fileLevel) {
		this.fileLevel = fileLevel;
	}

	public String getFileCaption() {
		return fileCaption;
	}

	public void setFileCaption(String fileCaption) {
		this.fileCaption = fileCaption;
	}

	public int getSchId() {
		return schId;
	}

	public void setSchId(int schId) {
		this.schId = schId;
	}

	public String getFileStatus() {
		return fileStatus;
	}

	public void setFileStatus(String fileStatus) {
		this.fileStatus = fileStatus;
	}

	public int getDayNumber() {
		return dayNumber;
	}

	public void setDayNumber(int dayNumber) {
		this.dayNumber = dayNumber;
	}

	@Override
	public String toString() {
		return "Gallary [fileId=" + fileId + ", originName=" + originName + ", changeName=" + changeName + ", filePath="
				+ filePath + ", uploadDate=" + uploadDate + ", fileLevel=" + fileLevel + ", fileCaption=" + fileCaption
				+ ", schId=" + schId + ", fileStatus=" + fileStatus + ", dayNumber=" + dayNumber + "]";
	}
	
}
