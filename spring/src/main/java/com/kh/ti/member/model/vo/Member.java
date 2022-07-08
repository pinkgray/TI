package com.kh.ti.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Member implements Serializable{
	private int memberId;
	private String email;
	private String password;
	private String userName;
	private String birthday;
	private String gender;
	private String accCode;
	private String accNumber;
	private Date enrollDate;
	private Date secessionDate;
	private Date modifyDate;
	private String enrollStatus;
	private String phone;
	private int userPoint;
	private int userProceeds;
	private String enrollType;
	private int penalty;
	private String memberType;

	//지원 - 수정 나이 필드 생성	  
	private int age; 
	
	
	public Member() {
		// TODO Auto-generated constructor stub
	}

	public Member(int memberId, String email, String password, String userName, String birthday, String gender,
			String accCode, String accNumber, Date enrollDate, Date secessionDate, Date modifyDate, String enrollStatus,
			String phone, int userPoint, int userProceeds, String enrollType, int penalty, String memberType) {
		super();
		this.memberId = memberId;
		this.email = email;
		this.password = password;
		this.userName = userName;
		this.birthday = birthday;
		this.gender = gender;
		this.accCode = accCode;
		this.accNumber = accNumber;
		this.enrollDate = enrollDate;
		this.secessionDate = secessionDate;
		this.modifyDate = modifyDate;
		this.enrollStatus = enrollStatus;
		this.phone = phone;
		this.userPoint = userPoint;
		this.userProceeds = userProceeds;
		this.enrollType = enrollType;
		this.penalty = penalty;
		this.memberType = memberType;
	}

	public Member(int memberId, String email, String password, String userName, Date enrollDate, String enrollStatus,
			String phone, int userPoint, int userProceeds, String enrollType, int penalty, String memberType) {
		super();
		this.memberId = memberId;
		this.email = email;
		this.password = password;
		this.userName = userName;
		this.enrollDate = enrollDate;
		this.enrollStatus = enrollStatus;
		this.phone = phone;
		this.userPoint = userPoint;
		this.userProceeds = userProceeds;
		this.enrollType = enrollType;
		this.penalty = penalty;
		this.memberType = memberType;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAccCode() {
		return accCode;
	}

	public void setAccCode(String accCode) {
		this.accCode = accCode;
	}

	public String getAccNumber() {
		return accNumber;
	}

	public void setAccNumber(String accNumber) {
		this.accNumber = accNumber;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public Date getSecessionDate() {
		return secessionDate;
	}

	public void setSecessionDate(Date secessionDate) {
		this.secessionDate = secessionDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getEnrollStatus() {
		return enrollStatus;
	}

	public void setEnrollStatus(String enrollStatus) {
		this.enrollStatus = enrollStatus;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getUserPoint() {
		return userPoint;
	}

	public void setUserPoint(int userPoint) {
		this.userPoint = userPoint;
	}

	public int getUserProceeds() {
		return userProceeds;
	}

	public void setUserProceeds(int userProceeds) {
		this.userProceeds = userProceeds;
	}

	public String getEnrollType() {
		return enrollType;
	}

	public void setEnrollType(String enrollType) {
		this.enrollType = enrollType;
	}

	public int getPenalty() {
		return penalty;
	}

	public void setPenalty(int penalty) {
		this.penalty = penalty;
	}

	public String getMemberType() {
		return memberType;
	}

	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}
	
	
	//지원 - 수정 나이 필드 생성	
	public int getAge() {
		return age;
	}
	
	
	//지원 - 수정 나이 필드 생성	 
	public void setAge(int age) {
		this.age = age;
	}
	
	//지원 - 수정 나이 필드 생성	 
	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", email=" + email + ", password=" + password + ", userName=" + userName
				+ ", birthday=" + birthday + ", gender=" + gender + ", accCode=" + accCode + ", accNumber=" + accNumber
				+ ", enrollDate=" + enrollDate + ", secessionDate=" + secessionDate + ", modifyDate=" + modifyDate
				+ ", enrollStatus=" + enrollStatus + ", phone=" + phone + ", userPoint=" + userPoint + ", userProceeds="
				+ userProceeds + ", enrollType=" + enrollType + ", penalty=" + penalty + ", memberType=" + memberType
				+ ", age=" + age + "]";
	}

		
	
	
	
		
		
}
