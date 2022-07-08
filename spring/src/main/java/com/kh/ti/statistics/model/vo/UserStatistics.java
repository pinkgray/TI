package com.kh.ti.statistics.model.vo;

import java.io.Serializable;

public class UserStatistics implements Serializable {
	
	private int femailCount;
	private int mailCount;
	private String ageGroup;
	private int ageCount;
	
	public UserStatistics() {}

	public UserStatistics(int femailCount, int mailCount, String ageGroup, int ageCount) {
		super();
		this.femailCount = femailCount;
		this.mailCount = mailCount;
		this.ageGroup = ageGroup;
		this.ageCount = ageCount;
	}

	public int getFemailCount() {
		return femailCount;
	}

	public void setFemailCount(int femailCount) {
		this.femailCount = femailCount;
	}

	public int getMailCount() {
		return mailCount;
	}

	public void setMailCount(int mailCount) {
		this.mailCount = mailCount;
	}

	public String getAgeGroup() {
		return ageGroup;
	}

	public void setAgeGroup(String ageGroup) {
		this.ageGroup = ageGroup;
	}

	public int getAgeCount() {
		return ageCount;
	}

	public void setAgeCount(int ageCount) {
		this.ageCount = ageCount;
	}

	@Override
	public String toString() {
		return "UserStatistics [femailCount=" + femailCount + ", mailCount=" + mailCount + ", ageGroup=" + ageGroup
				+ ", ageCount=" + ageCount + "]";
	}
	
}
