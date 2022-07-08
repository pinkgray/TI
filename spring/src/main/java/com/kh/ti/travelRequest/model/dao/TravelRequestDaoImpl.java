package com.kh.ti.travelRequest.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.common.PageInfo;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

@Repository
public class TravelRequestDaoImpl implements TravelRequestDao{

	//의뢰하기 신청 - 선우
	@Override
	public int insertRequest(SqlSessionTemplate sqlSession, TravelRequest tr) {
		return sqlSession.insert("TravelRequest.insertRequest", tr);
	}
	
	//의뢰글 목록 수 - 선우
	@Override
	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("TravelRequest.selectListCount");
	}

	//의뢰글 조회 - 선우
	@Override
	public ArrayList<TravelRequest> selectRequestList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		//시작값과 종료값의 차이 구하기
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		
		//페이징처리를 위한 selectList
		return (ArrayList) sqlSession.selectList("TravelRequest.selectRequestList", null, rowBounds);
	}

	//의뢰글 상세보기 - 선우
	@Override
	public TravelRequest selectOneRequest(SqlSessionTemplate sqlSession, int reqNum) {
		return sqlSession.selectOne("TravelRequest.selectOneRequest", reqNum);
	}

	//선택한 설계글 상세보기 - 선우
	@Override
	public ArrayList<TravelRequestPlan> selectOneRequestPlan(SqlSessionTemplate sqlSession, int ptcpId) {
		return (ArrayList) sqlSession.selectList("TravelRequest.selectOneRequestPlan", ptcpId);
	}

}
