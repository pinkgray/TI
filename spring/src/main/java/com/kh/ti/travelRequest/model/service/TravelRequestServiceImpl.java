package com.kh.ti.travelRequest.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.kh.ti.common.PageInfo;
import com.kh.ti.travelRequest.model.dao.TravelRequestDao;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

@Service
public class TravelRequestServiceImpl implements TravelRequestService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private TravelRequestDao trd;
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	//의뢰하기 신청
	@Override
	public int insertRequest(TravelRequest tr) {
		return trd.insertRequest(sqlSession, tr);
	}

	//의뢰글 목록 수
	@Override
	public int getListCount() {
		return trd.getListCount(sqlSession);
	}
	
	//의뢰글 조회
	@Override
	public ArrayList<TravelRequest> selectRequestList(PageInfo pi) {
		return trd.selectRequestList(sqlSession, pi);
	}

	//의뢰글 상세보기
	@Override
	public TravelRequest selectOneRequest(int reqNum) {
		return trd.selectOneRequest(sqlSession, reqNum);
	}

	//선택한 설계글 상세보기
//	@Override
//	public ArrayList<TravelRequestPlan> selectOneRequestPlan(int code) {
//		return trd.selectOneRequestPlan(sqlSession, code);
//	}
	
	//선택한 설계글 상세보기
	@Override
	public ArrayList<TravelRequestPlan> selectOneRequestPlan(int ptcpId) {
		return trd.selectOneRequestPlan(sqlSession, ptcpId);
	}

}
