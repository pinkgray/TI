package com.kh.ti.travel.model.vo;

public class TrvCompany implements java.io.Serializable{

	private int memberId;
	private String email;
	private String userName;
	private int trvId;
	
	public TrvCompany() {}

	public TrvCompany(int memberId, String email, String userName, int trvId) {
		super();
		this.memberId = memberId;
		this.email = email;
		this.userName = userName;
		this.trvId = trvId;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getTrvId() {
		return trvId;
	}

	public void setTrvId(int trvId) {
		this.trvId = trvId;
	}

	@Override
	public String toString() {
		return "TrvCompany [memberId=" + memberId + ", email=" + email + ", userName=" + userName + ", trvId=" + trvId
				+ "]";
	}

	

	
	
}
