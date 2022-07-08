package com.kh.ti.myRequest.model.dao;


import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.common.PageInfo;
import com.kh.ti.myRequest.model.vo.Inquiry;
import com.kh.ti.travelRequest.model.vo.Participation;
import com.kh.ti.travelRequest.model.vo.PlanDay;
import com.kh.ti.travelRequest.model.vo.PlanPlace;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

public interface MyRequestDao {

	int insertTravelRequestPlan(SqlSessionTemplate sqlSession, TravelRequestPlan tp);

	int insertRequestDay(SqlSessionTemplate sqlSession, ArrayList<PlanDay> dayList);

	int insertRequestPlace(SqlSessionTemplate sqlSession, ArrayList<PlanPlace> placeList);

	int insertParticipation(SqlSessionTemplate sqlSession, Participation p);

	ArrayList<TravelRequestPlan> selectRequestPlanList(SqlSessionTemplate sqlSession, TravelRequestPlan trp);

	ArrayList<TravelRequestPlan> selectLoadRequestPlan(SqlSessionTemplate sqlSession, int planId);

	//int selectPlan(SqlSessionTemplate sqlSession, int code);

	int updateParticipation(SqlSessionTemplate sqlSession, int code);
	
	int updateRequest(SqlSessionTemplate sqlSession, int code);

	int getRequestCount(SqlSessionTemplate sqlSession, int memberId);
	
	ArrayList<TravelRequest> selectMyRequestList(SqlSessionTemplate sqlSession, PageInfo pi, int membeId);

	int getPlanCount(SqlSessionTemplate sqlSession, int memberId);

	ArrayList<TravelRequestPlan> selectMyPlanList(SqlSessionTemplate sqlSession, PageInfo pi, int memberId);

	int getBeforePlanCount(SqlSessionTemplate sqlSession, int memberId);

	ArrayList<TravelRequestPlan> selectBeforePlanList(SqlSessionTemplate sqlSession, PageInfo pi, int memberId);

	int updateBeforePlan(SqlSessionTemplate sqlSession, TravelRequestPlan tp);

	int updateBeforeDay(SqlSessionTemplate sqlSession, ArrayList<PlanDay> dayList);

	int updateBeforePlace(SqlSessionTemplate sqlSession, ArrayList<PlanPlace> placeList);

	int insertInquiry(SqlSessionTemplate sqlSession, Inquiry i);

	int getInquiryCount(SqlSessionTemplate sqlSession, int memberId);

	ArrayList<Inquiry> selectInquiryList(SqlSessionTemplate sqlSession, PageInfo pi, int memberId);

	Inquiry slectMyInquiryDetail(SqlSessionTemplate sqlSession, int inquiryId);

	int updatePlanOpenStatus(SqlSessionTemplate sqlSession, int planId);
	
}
