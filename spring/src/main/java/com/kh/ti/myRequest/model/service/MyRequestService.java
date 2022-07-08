package com.kh.ti.myRequest.model.service;

import java.util.ArrayList;

import com.kh.ti.common.PageInfo;
import com.kh.ti.myRequest.model.vo.Inquiry;
import com.kh.ti.travelRequest.model.vo.Participation;
import com.kh.ti.travelRequest.model.vo.PlanDay;
import com.kh.ti.travelRequest.model.vo.PlanPlace;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

public interface MyRequestService {

	int insertRequestPlan(ArrayList<PlanDay> dayList, ArrayList<PlanPlace> placeList, TravelRequestPlan tp, Participation p);

	ArrayList<TravelRequestPlan> selectRequestPlanList(TravelRequestPlan trp);

	ArrayList<TravelRequestPlan> selectLoadRequestPlan(int planId);

	//int selectPlan(int code);

	int updateRequest(int planId, int code);

	int getRequestCount(int memberId);
	
	ArrayList<TravelRequest> selectMyRequestList(PageInfo pi, int memberId);

	int getPlanCount(int memberId);

	ArrayList<TravelRequestPlan> selectMyPlanList(PageInfo pi, int memberId);

	int getBeforPlanCount(int memberId);

	ArrayList<TravelRequestPlan> selectBeforePlanList(PageInfo pi, int memberId);

	int updateBeforePlan(ArrayList<PlanDay> dayList, ArrayList<PlanPlace> placeList, TravelRequestPlan tp);

	int insertBeforePlan(ArrayList<PlanDay> dayList, ArrayList<PlanPlace> placeList, TravelRequestPlan tp);

	int insertInquiry(Inquiry i);

	int getInquiryCount(int memberId);

	ArrayList<Inquiry> selectInquiryList(PageInfo pi, int memberId);

	Inquiry selectMyInquiryDetail(int inquiryId);

}
