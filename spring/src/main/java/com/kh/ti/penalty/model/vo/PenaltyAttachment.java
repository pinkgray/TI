package com.kh.ti.penalty.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class PenaltyAttachment implements Serializable{
	private int fileId;	//파일번호
	private String originName;	//원본파일
	private String changeName;	//바뀐파일
	private String filePath;	//파일경로
	private Date uploadDate;	//업로드일시
	private String fileType;	//파일 구분
	private int penaltyId;		//신고번호
	private int fileLevel;		//파일레벨
	private int boardId;		//게시글 코드
	
	public PenaltyAttachment() {}

	public PenaltyAttachment(int fileId, String originName, String changeName, String filePath, Date uploadDate,
			String fileType, int penaltyId, int fileLevel, int boardId) {
		super();
		this.fileId = fileId;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.uploadDate = uploadDate;
		this.fileType = fileType;
		this.penaltyId = penaltyId;
		this.fileLevel = fileLevel;
		this.boardId = boardId;
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

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public int getPenaltyId() {
		return penaltyId;
	}

	public void setPenaltyId(int penaltyId) {
		this.penaltyId = penaltyId;
	}

	public int getFileLevel() {
		return fileLevel;
	}

	public void setFileLevel(int fileLevel) {
		this.fileLevel = fileLevel;
	}

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	@Override
	public String toString() {
		return "PenaltyAttachment [fileId=" + fileId + ", originName=" + originName + ", changeName=" + changeName
				+ ", filePath=" + filePath + ", uploadDate=" + uploadDate + ", fileType=" + fileType + ", penaltyId="
				+ penaltyId + ", fileLevel=" + fileLevel + ", boardId=" + boardId + "]";
	}
}
