package com.kh.ti.adminCallCenter.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

public class Board implements Serializable{
	private int boardId;	//게시글코드
	private String boardTitle;		//제목
	private String boardContent;	//내용
	private int boardCount;		//조회수
	private Date enrollDate;	//작성일
	private Date modifyDate;	//수정일
	private String boardStatus;	//상태
	private String boardType;	//구분
	private int memberId;		//회원코드
	private ArrayList<BoardAttachment> attachmentFileList;	//글 이미지들
	
	public Board() {}

	public Board(int boardId, String boardTitle, String boardContent, int boardCount, Date enrollDate, Date modifyDate,
			String boardStatus, String boardType, int memberId, ArrayList<BoardAttachment> attachmentFileList) {
		super();
		this.boardId = boardId;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.boardCount = boardCount;
		this.enrollDate = enrollDate;
		this.modifyDate = modifyDate;
		this.boardStatus = boardStatus;
		this.boardType = boardType;
		this.memberId = memberId;
		this.attachmentFileList = attachmentFileList;
	}

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getBoardStatus() {
		return boardStatus;
	}

	public void setBoardStatus(String boardStatus) {
		this.boardStatus = boardStatus;
	}

	public String getBoardType() {
		return boardType;
	}

	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public ArrayList<BoardAttachment> getAttachmentFileList() {
		return attachmentFileList;
	}

	public void setAttachmentFileList(ArrayList<BoardAttachment> attachmentFileList) {
		this.attachmentFileList = attachmentFileList;
	}

	@Override
	public String toString() {
		return "Board [boardId=" + boardId + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", boardCount=" + boardCount + ", enrollDate=" + enrollDate + ", modifyDate=" + modifyDate
				+ ", boardStatus=" + boardStatus + ", boardType=" + boardType + ", memberId=" + memberId
				+ ", attachmentFileList=" + attachmentFileList + "]";
	}
}
