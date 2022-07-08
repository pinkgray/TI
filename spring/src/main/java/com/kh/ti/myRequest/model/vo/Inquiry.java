package com.kh.ti.myRequest.model.vo;

import java.io.Serializable;
import java.sql.Date;

import com.kh.ti.member.model.vo.Member;

public class Inquiry implements Serializable{
	private int inquiryId;		//문의번호
	private Date inquiryDate;	//문의일
	private Date replyDate;		//답변일
	private String replyStatus;	//답변여부
	private String replyContent;	//답변내용
	private int memberId;		//회원번호
	private String inquiryContent;	//문의내용
	private String inquiryType;	//문의종류
	private String inquiryTitle;	//문의제목
	private Member member;
	
	public Inquiry() {}

	public Inquiry(int inquiryId, Date inquiryDate, Date replyDate, String replyStatus, String replyContent,
			int memberId, String inquiryContent, String inquiryType, String inquiryTitle, Member member) {
		super();
		this.inquiryId = inquiryId;
		this.inquiryDate = inquiryDate;
		this.replyDate = replyDate;
		this.replyStatus = replyStatus;
		this.replyContent = replyContent;
		this.memberId = memberId;
		this.inquiryContent = inquiryContent;
		this.inquiryType = inquiryType;
		this.inquiryTitle = inquiryTitle;
		this.member = member;
	}

	public int getInquiryId() {
		return inquiryId;
	}

	public void setInquiryId(int inquiryId) {
		this.inquiryId = inquiryId;
	}

	public Date getInquiryDate() {
		return inquiryDate;
	}

	public void setInquiryDate(Date inquiryDate) {
		this.inquiryDate = inquiryDate;
	}

	public Date getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}

	public String getReplyStatus() {
		return replyStatus;
	}

	public void setReplyStatus(String replyStatus) {
		this.replyStatus = replyStatus;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public String getInquiryContent() {
		return inquiryContent;
	}

	public void setInquiryContent(String inquiryContent) {
		this.inquiryContent = inquiryContent;
	}

	public String getInquiryType() {
		return inquiryType;
	}

	public void setInquiryType(String inquiryType) {
		this.inquiryType = inquiryType;
	}

	public String getInquiryTitle() {
		return inquiryTitle;
	}

	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public String toString() {
		return "Inquiry [inquiryId=" + inquiryId + ", inquiryDate=" + inquiryDate + ", replyDate=" + replyDate
				+ ", replyStatus=" + replyStatus + ", replyContent=" + replyContent + ", memberId=" + memberId
				+ ", inquiryContent=" + inquiryContent + ", inquiryType=" + inquiryType + ", inquiryTitle="
				+ inquiryTitle + ", member=" + member + "]";
	}
}
