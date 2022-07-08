package com.kh.ti.statistics.model.service;

import java.sql.Date;
import java.util.ArrayList;

import com.kh.ti.statistics.model.vo.RevenueStatistics;
import com.kh.ti.statistics.model.vo.TravelStatistics;
import com.kh.ti.statistics.model.vo.UserStatistics;

public interface StatisticsService {

	UserStatistics genderStatistics();

	ArrayList ageGroupStatistics();

	ArrayList travelCountryStatistics(TravelStatistics ts);

	ArrayList travelTagStatistics(TravelStatistics ts);

	RevenueStatistics paymentStatistics();

	RevenueStatistics paymentYearSearch(String year);

	RevenueStatistics rebateStatistics();

	RevenueStatistics rebateYearSearch(String year);

}
