package com.kh.ti.penalty.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

public class Penalty implements Serializable{
	private int listId;		//신고번호
	private String penaltyContent;		//신고내용
	private Date penaltyDate;		//신고일
	private String penaltyResult;		//신고결과
	private Date processDate;		//처리일
	private int penaltyId;		//신고종류코드
	private int complainantId;		//신고인 번호
	private String list;			//구분
	private String listType;		//구분번호
	private String rejectionReson;		//거절사유
	private int trvId;				//여행일정번호
	private int reviewId;			//여행리뷰코드
	private int memberId;			//회원번호
	private int planId;				//설계번호
	private int requestId;			//의뢰번호
	private int memberPenalty;		//벌점
	private int penalty;			//누적벌점
	private ArrayList<PenaltyAttachment> attachmentFileList;	//사진들
	private PenaltyType penaltyType;
	private String complainantName;	//신고자
	private String userName;	//대상자
	
	public Penalty() {}

	public Penalty(int listId, String penaltyContent, Date penaltyDate, String penaltyResult, Date processDate,
			int penaltyId, int complainantId, String list, String listType, String rejectionReson, int trvId,
			int reviewId, int memberId, int planId, int requestId, int memberPenalty, int penalty,
			ArrayList<PenaltyAttachment> attachmentFileList, PenaltyType penaltyType, String complainantName,
			String userName) {
		super();
		this.listId = listId;
		this.penaltyContent = penaltyContent;
		this.penaltyDate = penaltyDate;
		this.penaltyResult = penaltyResult;
		this.processDate = processDate;
		this.penaltyId = penaltyId;
		this.complainantId = complainantId;
		this.list = list;
		this.listType = listType;
		this.rejectionReson = rejectionReson;
		this.trvId = trvId;
		this.reviewId = reviewId;
		this.memberId = memberId;
		this.planId = planId;
		this.requestId = requestId;
		this.memberPenalty = memberPenalty;
		this.penalty = penalty;
		this.attachmentFileList = attachmentFileList;
		this.penaltyType = penaltyType;
		this.complainantName = complainantName;
		this.userName = userName;
	}

	public int getListId() {
		return listId;
	}

	public void setListId(int listId) {
		this.listId = listId;
	}

	public String getPenaltyContent() {
		return penaltyContent;
	}

	public void setPenaltyContent(String penaltyContent) {
		this.penaltyContent = penaltyContent;
	}

	public Date getPenaltyDate() {
		return penaltyDate;
	}

	public void setPenaltyDate(Date penaltyDate) {
		this.penaltyDate = penaltyDate;
	}

	public String getPenaltyResult() {
		return penaltyResult;
	}

	public void setPenaltyResult(String penaltyResult) {
		this.penaltyResult = penaltyResult;
	}

	public Date getProcessDate() {
		return processDate;
	}

	public void setProcessDate(Date processDate) {
		this.processDate = processDate;
	}

	public int getPenaltyId() {
		return penaltyId;
	}

	public void setPenaltyId(int penaltyId) {
		this.penaltyId = penaltyId;
	}

	public int getComplainantId() {
		return complainantId;
	}

	public void setComplainantId(int complainantId) {
		this.complainantId = complainantId;
	}

	public String getList() {
		return list;
	}

	public void setList(String list) {
		this.list = list;
	}

	public String getListType() {
		return listType;
	}

	public void setListType(String listType) {
		this.listType = listType;
	}

	public String getRejectionReson() {
		return rejectionReson;
	}

	public void setRejectionReson(String rejectionReson) {
		this.rejectionReson = rejectionReson;
	}

	public int getTrvId() {
		return trvId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	public int getReviewId() {
		return reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public int getPlanId() {
		return planId;
	}

	public void setPlanId(int planId) {
		this.planId = planId;
	}

	public int getRequestId() {
		return requestId;
	}

	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}

	public int getMemberPenalty() {
		return memberPenalty;
	}

	public void setMemberPenalty(int memberPenalty) {
		this.memberPenalty = memberPenalty;
	}

	public int getPenalty() {
		return penalty;
	}

	public void setPenalty(int penalty) {
		this.penalty = penalty;
	}

	public ArrayList<PenaltyAttachment> getAttachmentFileList() {
		return attachmentFileList;
	}

	public void setAttachmentFileList(ArrayList<PenaltyAttachment> attachmentFileList) {
		this.attachmentFileList = attachmentFileList;
	}

	public PenaltyType getPenaltyType() {
		return penaltyType;
	}

	public void setPenaltyType(PenaltyType penaltyType) {
		this.penaltyType = penaltyType;
	}

	public String getComplainantName() {
		return complainantName;
	}

	public void setComplainantName(String complainantName) {
		this.complainantName = complainantName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "Penalty [listId=" + listId + ", penaltyContent=" + penaltyContent + ", penaltyDate=" + penaltyDate
				+ ", penaltyResult=" + penaltyResult + ", processDate=" + processDate + ", penaltyId=" + penaltyId
				+ ", complainantId=" + complainantId + ", list=" + list + ", listType=" + listType + ", rejectionReson="
				+ rejectionReson + ", trvId=" + trvId + ", reviewId=" + reviewId + ", memberId=" + memberId
				+ ", planId=" + planId + ", requestId=" + requestId + ", memberPenalty=" + memberPenalty + ", penalty="
				+ penalty + ", attachmentFileList=" + attachmentFileList + ", penaltyType=" + penaltyType
				+ ", complainantName=" + complainantName + ", userName=" + userName + "]";
	}
}
