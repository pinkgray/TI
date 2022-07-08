package com.kh.ti.statistics.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.ti.statistics.model.vo.RevenueStatistics;
import com.kh.ti.statistics.model.vo.TravelStatistics;
import com.kh.ti.statistics.model.vo.UserStatistics;

@Service
public class StatisticsDaoImpl implements StatisticsDao {

	//통계 / 회원 - 성별 통계
	@Override
	public UserStatistics genderStatistics(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("Statistics.genderStatistics");
	}

	//통계 / 회원 - 연령별 통계
	@Override
	public ArrayList ageGroupStatistics(SqlSessionTemplate sqlSession) {
		
		return (ArrayList) sqlSession.selectList("Statistics.ageGroupStatistics");
	}
	
	//통계 / 여행 - 나라별 통계
	@Override
	public ArrayList travelCountryStatistics(SqlSessionTemplate sqlSession, TravelStatistics ts) {
		
		return (ArrayList) sqlSession.selectList("Statistics.travelCountryStatistics", ts);
	}

	//통계 / 여행 - 태그별 통계(월)
	@Override
	public ArrayList travelTagStatistics(SqlSessionTemplate sqlSession, TravelStatistics ts) {
		
		return (ArrayList) sqlSession.selectList("Statistics.travelTagStatistics", ts);
	}

	//통계 / 수익 - 결제금액 통계
	@Override
	public RevenueStatistics paymentStatistics(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("Statistics.paymentStatistics");
	}

	//통계 / 수익 - 결제금액 연별 통계조회
	@Override
	public RevenueStatistics paymentYearSearch(SqlSessionTemplate sqlSession, String year) {
		
		return sqlSession.selectOne("Statistics.paymentYearSearch", year);
	}

	//통계 / 수익 - 환급금액 통계
	@Override
	public RevenueStatistics rebateStatistics(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("Statistics.rebateStatistics");
	}

	//통계 / 수익 - 환급액 연별 통계조회
	@Override
	public RevenueStatistics rebateYearSearch(SqlSessionTemplate sqlSession, String year) {
		
		return sqlSession.selectOne("Statistics.rebateYearSearch", year);
	}
	
	

}
