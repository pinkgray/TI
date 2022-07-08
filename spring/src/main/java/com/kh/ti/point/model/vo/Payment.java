package com.kh.ti.point.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Payment implements Serializable{
	//결제내역
	private int paymentId;		//결제코드
	private String tid;			//거래번호
	private int memberId;		//회원코드
	private int payAmount;		//결제금액
	private Date paymentDate;	//결제일
	private String month;		//검색 월
	private String email;
	private String userName;
	private String birthday;
	private String accCode;
	private String accNumber;
	private String enrollStatus;
	private String phone;
	private int userPoint;
	private int userProceeds;
	public Payment() {}
	public Payment(int paymentId, String tid, int memberId, int payAmount, Date paymentDate, String month, String email,
			String userName, String birthday, String accCode, String accNumber, String enrollStatus, String phone,
			int userPoint, int userProceeds) {
		super();
		this.paymentId = paymentId;
		this.tid = tid;
		this.memberId = memberId;
		this.payAmount = payAmount;
		this.paymentDate = paymentDate;
		this.month = month;
		this.email = email;
		this.userName = userName;
		this.birthday = birthday;
		this.accCode = accCode;
		this.accNumber = accNumber;
		this.enrollStatus = enrollStatus;
		this.phone = phone;
		this.userPoint = userPoint;
		this.userProceeds = userProceeds;
	}
	public int getPaymentId() {
		return paymentId;
	}
	public String getTid() {
		return tid;
	}
	public int getMemberId() {
		return memberId;
	}
	public int getPayAmount() {
		return payAmount;
	}
	public Date getPaymentDate() {
		return paymentDate;
	}
	public String getMonth() {
		return month;
	}
	public String getEmail() {
		return email;
	}
	public String getUserName() {
		return userName;
	}
	public String getBirthday() {
		return birthday;
	}
	public String getAccCode() {
		return accCode;
	}
	public String getAccNumber() {
		return accNumber;
	}
	public String getEnrollStatus() {
		return enrollStatus;
	}
	public String getPhone() {
		return phone;
	}
	public int getUserPoint() {
		return userPoint;
	}
	public int getUserProceeds() {
		return userProceeds;
	}
	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public void setPayAmount(int payAmount) {
		this.payAmount = payAmount;
	}
	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public void setAccCode(String accCode) {
		this.accCode = accCode;
	}
	public void setAccNumber(String accNumber) {
		this.accNumber = accNumber;
	}
	public void setEnrollStatus(String enrollStatus) {
		this.enrollStatus = enrollStatus;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setUserPoint(int userPoint) {
		this.userPoint = userPoint;
	}
	public void setUserProceeds(int userProceeds) {
		this.userProceeds = userProceeds;
	}
	@Override
	public String toString() {
		return "Payment [paymentId=" + paymentId + ", tid=" + tid + ", memberId=" + memberId + ", payAmount="
				+ payAmount + ", paymentDate=" + paymentDate + ", month=" + month + ", email=" + email + ", userName="
				+ userName + ", birthday=" + birthday + ", accCode=" + accCode + ", accNumber=" + accNumber
				+ ", enrollStatus=" + enrollStatus + ", phone=" + phone + ", userPoint=" + userPoint + ", userProceeds="
				+ userProceeds + "]";
	}
}