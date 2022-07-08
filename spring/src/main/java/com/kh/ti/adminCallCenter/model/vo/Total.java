package com.kh.ti.adminCallCenter.model.vo;

import java.io.Serializable;
import java.util.ArrayList;

import com.kh.ti.travel.model.vo.Travel;
import com.kh.ti.travelBoard.model.vo.TourReview;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

public class Total implements Serializable{
	private int row;
	private ArrayList<TravelRequest> trvRequest;	//의뢰글
	private ArrayList<TravelRequestPlan> trvPlan;	//설계글
	private ArrayList<TourReview> review;			//리뷰
	private ArrayList<Travel>	travel;				//일정글
	
	public Total() {}

	public Total(int row, ArrayList<TravelRequest> trvRequest, ArrayList<TravelRequestPlan> trvPlan,
			ArrayList<TourReview> review, ArrayList<Travel> travel) {
		super();
		this.row = row;
		this.trvRequest = trvRequest;
		this.trvPlan = trvPlan;
		this.review = review;
		this.travel = travel;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public ArrayList<TravelRequest> getTrvRequest() {
		return trvRequest;
	}

	public void setTrvRequest(ArrayList<TravelRequest> trvRequest) {
		this.trvRequest = trvRequest;
	}

	public ArrayList<TravelRequestPlan> getTrvPlan() {
		return trvPlan;
	}

	public void setTrvPlan(ArrayList<TravelRequestPlan> trvPlan) {
		this.trvPlan = trvPlan;
	}

	public ArrayList<TourReview> getReview() {
		return review;
	}

	public void setReview(ArrayList<TourReview> review) {
		this.review = review;
	}

	public ArrayList<Travel> getTravel() {
		return travel;
	}

	public void setTravel(ArrayList<Travel> travel) {
		this.travel = travel;
	}

	@Override
	public String toString() {
		return "Total [row=" + row + ", trvRequest=" + trvRequest + ", trvPlan=" + trvPlan + ", review=" + review
				+ ", travel=" + travel + "]";
	}
}
