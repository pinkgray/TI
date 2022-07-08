package com.kh.ti.myRequest.model.dao;


import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.common.PageInfo;
import com.kh.ti.myRequest.model.vo.Inquiry;
import com.kh.ti.travelRequest.model.vo.Participation;
import com.kh.ti.travelRequest.model.vo.PlanDay;
import com.kh.ti.travelRequest.model.vo.PlanPlace;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

@Repository
public class MyRequestDaoImpl implements MyRequestDao{

	//설계글 인서트(1단계) - 이선우
	@Override
	public int insertTravelRequestPlan(SqlSessionTemplate sqlSession, TravelRequestPlan tp) {
		return sqlSession.insert("TravelRequest.insertRequestPlan", tp);
	}

	//설계글 각 일자 인서트(2단계) - 이선우
	@Override
	public int insertRequestDay(SqlSessionTemplate sqlSession, ArrayList<PlanDay> dayList) {
		int result2 = 0;
		for(int i = 0; i < dayList.size(); i++) {
			sqlSession.insert("TravelRequest.insertRequestDay", dayList.get(i));
			result2++;
		}
		System.out.println(result2);
		return result2;
	}

	//설계글 각 장소 인서트(3단계) - 이선우
	@Override
	public int insertRequestPlace(SqlSessionTemplate sqlSession, ArrayList<PlanPlace> placeList) {
		int result3 = 0;
		for(int i = 0; i < placeList.size(); i++) {
			sqlSession.insert("TravelRequest.insertRequestPlace", placeList.get(i));
			result3++;
		}
		System.out.println(result3);
		return result3;
	}

	//설계글 의뢰참여 인서트(4단계) - 이선우
	@Override
	public int insertParticipation(SqlSessionTemplate sqlSession, Participation p) {
		return sqlSession.insert("TravelRequest.insertParticipation", p);
	}

	//설계글 불러오기 - 이선우
	@Override
	public ArrayList<TravelRequestPlan> selectRequestPlanList(SqlSessionTemplate sqlSession, TravelRequestPlan trp) {
		return (ArrayList) sqlSession.selectList("TravelRequest.selectRequestPlanList", trp);
	}

	//선택한 설계글 불러오기 - 이선우
	@Override
	public ArrayList<TravelRequestPlan> selectLoadRequestPlan(SqlSessionTemplate sqlSession, int planId) {
		return (ArrayList) sqlSession.selectList("TravelRequest.selectLoadRequestPlan", planId);
	}

	//해당 의뢰글의 채택(설계)글 조회 - 이선우
//	@Override
//	public int selectPlan(SqlSessionTemplate sqlSession, int code) {
//		return sqlSession.selectOne("TravelRequest.selectPlan", code);
//	}

	//의뢰참여 업데이트
	@Override
	public int updateParticipation(SqlSessionTemplate sqlSession, int code) {
		return sqlSession.update("TravelRequest.updateParticipation", code);
	}
	
	//의뢰글 채택상태 업데이트
	@Override
	public int updateRequest(SqlSessionTemplate sqlSession, int code) {
		return sqlSession.update("TravelRequest.updateRequest", code);
	}
	
	//설계글 오픈상태 업데이트
	@Override
	public int updatePlanOpenStatus(SqlSessionTemplate sqlSession, int planId) {
		return sqlSession.update("TravelRequest.updatePlanOpenStatus", planId);
	}


	//채택후 나의 의뢰목록 조회
	@Override
	public ArrayList<TravelRequest> selectMyRequestList(SqlSessionTemplate sqlSession, PageInfo pi, int memberId) {
		//시작값과 종료값의 차이 구하기
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
				
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
				
		return (ArrayList)sqlSession.selectList("TravelRequest.selectMyRequestList", memberId, rowBounds);
	}

	//채택후 나의 의뢰목록 수
	@Override
	public int getRequestCount(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("TravelRequest.selectRequestCount", memberId);
	}

	//마이페이지 나의 설계글 수
	@Override
	public int getPlanCount(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("TravelRequest.selectPlanCount", memberId);
	}

	//마이페이지 나의 설계글 목록 조회
	@Override
	public ArrayList<TravelRequestPlan> selectMyPlanList(SqlSessionTemplate sqlSession, PageInfo pi, int memberId) {
		//시작값과 종료값의 차이 구하기
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
						
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("TravelRequest.selectMyPlanList", memberId, rowBounds);
	}

	//마이페이지 미리작성 글 수
	@Override
	public int getBeforePlanCount(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("TravelRequest.selectBeforePlanCount", memberId);
	}

	//마이페이지 미리작성 글 목록
	@Override
	public ArrayList<TravelRequestPlan> selectBeforePlanList(SqlSessionTemplate sqlSession, PageInfo pi, int memberId) {
		//시작값과 종료값의 차이 구하기
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
								
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		return (ArrayList)sqlSession.selectList("TravelRequest.selectBeforePlanList", memberId, rowBounds);
	}

	//미리작성 설계글 업데이트(1단계)
	@Override
	public int updateBeforePlan(SqlSessionTemplate sqlSession, TravelRequestPlan tp) {
		return sqlSession.update("TravelRequest.updateBeforePlan", tp);
	}

	//미리작성 각 일자 업데이트(2단계) - 이선우
	@Override
	public int updateBeforeDay(SqlSessionTemplate sqlSession, ArrayList<PlanDay> dayList) {
		int result2 = 0;
		int count = 1;
		for(int i = 0; i < dayList.size(); i++) {
			dayList.get(i).setCount(count++);
			sqlSession.update("TravelRequest.updateBeforeDay", dayList.get(i));
			result2++;
			dayList.get(i).setCount(1);
		}
		System.out.println(result2);
		return result2;
	}

	//미리작성 각 장소 업데이트(3단계) - 이선우
	@Override
	public int updateBeforePlace(SqlSessionTemplate sqlSession, ArrayList<PlanPlace> placeList) {
		int result3 = 0;
		int count = 1;
		for(int i = 0; i < placeList.size(); i++) {
			placeList.get(i).setCount(count++);
			sqlSession.update("TravelRequest.updateBeforePlace", placeList.get(i));
			result3++;
			placeList.get(i).setCount(1);
		}
		System.out.println(result3);
		return result3;
	}

	//문의하기
	@Override
	public int insertInquiry(SqlSessionTemplate sqlSession, Inquiry i) {
		return sqlSession.insert("Inquiry.insertInquiry", i);
	}

	//나의 문의글 수
	@Override
	public int getInquiryCount(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("Inquiry.getInquiryCount", memberId);
	}

	//나의 문의글 목록들
	@Override
	public ArrayList<Inquiry> selectInquiryList(SqlSessionTemplate sqlSession, PageInfo pi, int memberId) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("Inquiry.selectInquiryList", memberId, rowBounds);
	}

	//나의 문의글 상세보기
	@Override
	public Inquiry slectMyInquiryDetail(SqlSessionTemplate sqlSession, int inquiryId) {
		return sqlSession.selectOne("Inquiry.selectMyInquiryDetail", inquiryId);
	}
}
