package com.kh.ti.statistics.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.ti.statistics.model.vo.RevenueStatistics;
import com.kh.ti.statistics.model.vo.TravelStatistics;
import com.kh.ti.statistics.model.vo.UserStatistics;

public interface StatisticsDao {

	UserStatistics genderStatistics(SqlSessionTemplate sqlSession);

	ArrayList ageGroupStatistics(SqlSessionTemplate sqlSession);

	ArrayList travelCountryStatistics(SqlSessionTemplate sqlSession, TravelStatistics ts);

	ArrayList travelTagStatistics(SqlSessionTemplate sqlSession, TravelStatistics ts);
	
	RevenueStatistics paymentStatistics(SqlSessionTemplate sqlSession);
	
	RevenueStatistics paymentYearSearch(SqlSessionTemplate sqlSession, String year);

	RevenueStatistics rebateStatistics(SqlSessionTemplate sqlSession);

	RevenueStatistics rebateYearSearch(SqlSessionTemplate sqlSession, String year);

}
