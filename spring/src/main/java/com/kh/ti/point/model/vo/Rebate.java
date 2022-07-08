package com.kh.ti.point.model.vo;

import java.io.Serializable;
import java.sql.Date;

import com.kh.ti.member.model.vo.Member;

public class Rebate implements Serializable {
	//환급내역
	private int rebateId;		//환급코드
	private Date applyDate;		//환급신청일
	private int payAmount;		//환급신청액
	private int memberId;		//회원코드
	private Date payDate;		//환급지급일
	private int rebateStatus;	//상태	-10:미지급, 20:지급완료 (10:대기중 - 관리자만)
	private String month;
	
	private Member member;
	public Rebate() {}
	public Rebate(int rebateId, Date applyDate, int payAmount, int memberId, Date payDate, int rebateStatus,
			String month, Member member) {
		super();
		this.rebateId = rebateId;
		this.applyDate = applyDate;
		this.payAmount = payAmount;
		this.memberId = memberId;
		this.payDate = payDate;
		this.rebateStatus = rebateStatus;
		this.month = month;
		this.member = member;
	}
	public int getRebateId() {
		return rebateId;
	}
	public Date getApplyDate() {
		return applyDate;
	}
	public int getPayAmount() {
		return payAmount;
	}
	public int getMemberId() {
		return memberId;
	}
	public Date getPayDate() {
		return payDate;
	}
	public int getRebateStatus() {
		return rebateStatus;
	}
	public String getMonth() {
		return month;
	}
	public Member getMember() {
		return member;
	}
	public void setRebateId(int rebateId) {
		this.rebateId = rebateId;
	}
	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}
	public void setPayAmount(int payAmount) {
		this.payAmount = payAmount;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	public void setRebateStatus(int rebateStatus) {
		this.rebateStatus = rebateStatus;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "Rebate [rebateId=" + rebateId + ", applyDate=" + applyDate + ", payAmount=" + payAmount + ", memberId="
				+ memberId + ", payDate=" + payDate + ", rebateStatus=" + rebateStatus + ", month=" + month
				+ ", member=" + member + "]";
	}

	
}
