package com.kh.ti.myRequest.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ti.common.PageInfo;
import com.kh.ti.myRequest.model.dao.MyRequestDao;
import com.kh.ti.myRequest.model.vo.Inquiry;
import com.kh.ti.travelRequest.model.vo.Participation;
import com.kh.ti.travelRequest.model.vo.PlanDay;
import com.kh.ti.travelRequest.model.vo.PlanPlace;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

@Service
public class MyRequestServiceImpl implements MyRequestService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private MyRequestDao mrd;
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Override
	public int insertRequestPlan(ArrayList<PlanDay> dayList, ArrayList<PlanPlace> placeList,
								 TravelRequestPlan tp, Participation p) {
		int result = 0;
		
		//설계글 인서트(1단계) - 이선우
		int result1 = mrd.insertTravelRequestPlan(sqlSession, tp);
		//설계글 각 일자 인서트(2단계) - 이선우
		int result2 = mrd.insertRequestDay(sqlSession, dayList);
		//설계글 각 장소 인서트(3단계) - 이선우
		int result3 = mrd.insertRequestPlace(sqlSession, placeList);
		//설계글 의뢰참여 인서트(4단계) - 이선우
		int result4 = mrd.insertParticipation(sqlSession, p);
		
		if(result1 > 0 && result2 == dayList.size() && result3 == placeList.size() && result4 > 0) {
			result = 1;
		} else {
			result = 0;
		}
		
		return result;
	}

	//설계글 불러오기 - 이선우
	@Override
	public ArrayList<TravelRequestPlan> selectRequestPlanList(TravelRequestPlan trp) {
		return mrd.selectRequestPlanList(sqlSession, trp);
	}
	

	//선택한 설계글 불러오기 - 이선우
	@Override
	public ArrayList<TravelRequestPlan> selectLoadRequestPlan(int planId) {
		return mrd.selectLoadRequestPlan(sqlSession, planId);
	}

	//해당 의뢰글의 설계글 조회 - 이선우
//	@Override
//	public int selectPlan(int code) {
//		return mrd.selectPlan(sqlSession, code);
//	}

	//의뢰글 채택상태 업데이트 - 이선우
	@Override
	public int updateRequest(int planId, int code) {
		int result = 0;
		//참여(설계)글 채택상태 업데이트
		int result1 = mrd.updateParticipation(sqlSession, planId);
		//의뢰글 채택상태 업데이트
		int result2 = mrd.updateRequest(sqlSession, code);
		//설계글 오픈상태 업데이트
		int result3 = mrd.updatePlanOpenStatus(sqlSession, planId);
		
		if(result1 > 0 && result2 > 0 && result3 > 0) {
			result = 1;
		} else {
			result = 0;
		}

		return result;
	}

	//채택후 나의 의뢰 목록수
	@Override
	public int getRequestCount(int memberId) {
		return mrd.getRequestCount(sqlSession, memberId);
	}
	
	//채택후 나의의뢰 리스트 조회
	@Override
	public ArrayList<TravelRequest> selectMyRequestList(PageInfo pi, int memberId) {
		return mrd.selectMyRequestList(sqlSession, pi, memberId);
	}

	//마이페이지 나의 설계글 수
	@Override
	public int getPlanCount(int memberId) {
		return mrd.getPlanCount(sqlSession, memberId);
	}

	//마이페이지 나의 설계글 조회
	@Override
	public ArrayList<TravelRequestPlan> selectMyPlanList(PageInfo pi, int memberId) {
		return mrd.selectMyPlanList(sqlSession, pi, memberId);
	}

	//마이페이지 미리작성 글 수
	@Override
	public int getBeforPlanCount(int memberId) {
		return mrd.getBeforePlanCount(sqlSession, memberId);
	}

	//마이페이지 미리작성 글 조회
	@Override
	public ArrayList<TravelRequestPlan> selectBeforePlanList(PageInfo pi, int memberId) {
		return mrd.selectBeforePlanList(sqlSession, pi, memberId);
	}

	//미리작성 불러온글 업데이트
	@Override
	public int updateBeforePlan(ArrayList<PlanDay> dayList, ArrayList<PlanPlace> placeList, 
							TravelRequestPlan tp) {
		int result = 0;
		
		//설계글 업데이트(1단계) - 이선우
		int result1 = mrd.updateBeforePlan(sqlSession, tp);
		//설계글 각 일자 업데이트(2단계) - 이선우
		int result2 = mrd.updateBeforeDay(sqlSession, dayList);
		//설계글 각 장소 업데이트(3단계) - 이선우
		int result3 = mrd.updateBeforePlace(sqlSession, placeList);
		
		if (/* result1 > 0 && */ result2 == dayList.size()/* && result3 == placeList.size() */) {
			result = 1;
		} else {
			result = 0;
		}
		
		return result;
	}

	//미리작성 인서트
	@Override
	public int insertBeforePlan(ArrayList<PlanDay> dayList, ArrayList<PlanPlace> placeList, TravelRequestPlan tp) {
		int result = 0;
		
		//설계글 인서트(1단계) - 이선우
		int result1 = mrd.insertTravelRequestPlan(sqlSession, tp);
		//설계글 각 일자 인서트(2단계) - 이선우
		int result2 = mrd.insertRequestDay(sqlSession, dayList);
		//설계글 각 장소 인서트(3단계) - 이선우
		int result3 = mrd.insertRequestPlace(sqlSession, placeList);
		
		if(result1 > 0 && result2 == dayList.size() && result3 == placeList.size()) {
			result = 1;
		} else {
			result = 0;
		}
		
		return result;
	}

	//문의하기
	@Override
	public int insertInquiry(Inquiry i) {
		return mrd.insertInquiry(sqlSession, i);
	}

	//나의 문의글 수
	@Override
	public int getInquiryCount(int memberId) {
		return mrd.getInquiryCount(sqlSession, memberId);
	}

	//나의 문의글 목록들
	@Override
	public ArrayList<Inquiry> selectInquiryList(PageInfo pi, int memberId) {
		return mrd.selectInquiryList(sqlSession, pi, memberId);
	}

	//나의 문의글 상세보기
	@Override
	public Inquiry selectMyInquiryDetail(int inquiryId) {
		return mrd.slectMyInquiryDetail(sqlSession, inquiryId);
	}
}
