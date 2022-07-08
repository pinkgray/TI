package com.kh.ti.penalty.model.vo;

import java.io.Serializable;

public class PenaltyType implements Serializable{
	private int penaltyId;		//신고종류코드
	private String penaltyName;		//사유명
	private int penalty;		//벌점
	
	public PenaltyType() {}
	
	public PenaltyType(int penaltyId, String penaltyName, int penalty) {
		super();
		this.penaltyId = penaltyId;
		this.penaltyName = penaltyName;
		this.penalty = penalty;
	}
	public int getPenaltyId() {
		return penaltyId;
	}
	public void setPenaltyId(int penaltyId) {
		this.penaltyId = penaltyId;
	}
	public String getPenaltyName() {
		return penaltyName;
	}
	public void setPenaltyName(String penaltyName) {
		this.penaltyName = penaltyName;
	}
	public int getPenalty() {
		return penalty;
	}
	public void setPenalty(int penalty) {
		this.penalty = penalty;
	}
	@Override
	public String toString() {
		return "PenaltyType [penaltyId=" + penaltyId + ", penaltyName=" + penaltyName + ", penalty=" + penalty + "]";
	}
}
