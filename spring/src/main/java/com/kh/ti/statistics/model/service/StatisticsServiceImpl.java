package com.kh.ti.statistics.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ti.statistics.model.dao.StatisticsDao;
import com.kh.ti.statistics.model.vo.RevenueStatistics;
import com.kh.ti.statistics.model.vo.TravelStatistics;
import com.kh.ti.statistics.model.vo.UserStatistics;

@Service
public class StatisticsServiceImpl implements StatisticsService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private StatisticsDao sd;
	
	//통계 / 회원 - 성별 통계
	@Override
	public UserStatistics genderStatistics() {
		
		return sd.genderStatistics(sqlSession);
	}

	//통계 / 회원 - 연령별 통계
	@Override
	public ArrayList ageGroupStatistics() {
		
		return sd.ageGroupStatistics(sqlSession);
	}
	
	//통계 / 여행 - 나라별 통계
	@Override
	public ArrayList travelCountryStatistics(TravelStatistics ts) {
		
		return sd.travelCountryStatistics(sqlSession, ts);
	}

	//통계 / 여행 - 태그별 통계
	@Override
	public ArrayList travelTagStatistics(TravelStatistics ts) {
		
		return sd.travelTagStatistics(sqlSession, ts);
	}
	
	//통계 / 수익 - 결제금액 통계
	@Override
	public RevenueStatistics paymentStatistics() {
		
		return sd.paymentStatistics(sqlSession);
	}

	//통계 / 수익 - 결제금액 연별 통계조회
	@Override
	public RevenueStatistics paymentYearSearch(String year) {
		
		return sd.paymentYearSearch(sqlSession, year);
	}

	//통계 / 수익 - 환급금액 통계
	@Override
	public RevenueStatistics rebateStatistics() {
		
		return sd.rebateStatistics(sqlSession);
	}

	//통계 / 수익 - 환급액 연별 통계조회
	@Override
	public RevenueStatistics rebateYearSearch(String year) {
		
		return sd.rebateYearSearch(sqlSession, year);
	}

}
