package com.kh.ti.statistics.controller;

import java.sql.Date;
import java.util.ArrayList;

import javax.swing.text.html.HTML;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.ti.statistics.model.service.StatisticsService;
import com.kh.ti.statistics.model.vo.RevenueStatistics;
import com.kh.ti.statistics.model.vo.TravelStatistics;
import com.kh.ti.statistics.model.vo.UserStatistics;

@Controller
public class StatisticsController {
	
	@Autowired
	private StatisticsService ss;
	
	//통계 / 회원 - 성별 통계
	@RequestMapping("genderStatistics.sta")
	public String genderStatistics(Model model) {
		
		UserStatistics user = ss.genderStatistics();
		
		model.addAttribute("user", user);
		
		return "admin/statistics/adminGenderStatistics";
	}
	
	//통계 / 회원 - 연령별 통계
	@RequestMapping("ageGroupStatistics.sta")
	public String ageGroupStatistics(Model model) {
		
		ArrayList userList = ss.ageGroupStatistics();
		
		model.addAttribute("user", userList);
		
		return "admin/statistics/adminAgeGroupStatistics";
	}
	
	@RequestMapping("travelCountryStatisticsView.sta")
	public String travelCountryStatisticsView(Model model) {
		
		return "admin/statistics/adminTravelCountryStatistics";
	}
	
	//통계 / 여행 - 나라별 통계(월)
	@RequestMapping("travelCountryMonthStatistics.sta")
	public ResponseEntity travelCountryStatistics(String month) {
		
		TravelStatistics ts = new TravelStatistics();
		ts.setMonth(month);
		
		ArrayList countryList = ss.travelCountryStatistics(ts);
		
		return new ResponseEntity(countryList, HttpStatus.OK);
	}
	
	@RequestMapping("travelTagStatisticsView.sta")
	public String travelTagStatisticsView(Model model) {
		
		return "admin/statistics/adminTravelTagStatistics";
	}
	
	//통계 / 여행 - 태그별 통계(월)
	@RequestMapping("travelTagStatistics.sta")
	public ResponseEntity travelTagStatistics(String month) {
		
		TravelStatistics ts = new TravelStatistics();
		ts.setMonth(month);
		
		ArrayList tagList = ss.travelTagStatistics(ts);
		
		return new ResponseEntity(tagList, HttpStatus.OK);
	}

	//통계 / 수익 - 결제금액 통계
	@RequestMapping("paymentStatistics.sta")
	public String paymentStatistics(Model model) {
		
		RevenueStatistics rs = ss.paymentStatistics();
		
		model.addAttribute("rs", rs);
		
		return "admin/statistics/adminPaymentStatistics";
	}
	
	//통계 / 수익 - 결제금액 연별 통계조회
	@RequestMapping("paymentYearSearch.sta")
	public ResponseEntity paymentYearSearch(String year) {
		
		RevenueStatistics rs = ss.paymentYearSearch(year);
		
		return new ResponseEntity(rs, HttpStatus.OK);
	}
	
	//통계 / 수익 - 환급금액 통계
	@RequestMapping("rebateStatistics.sta")
	public String rebateStatistics(Model model) {
		
		RevenueStatistics rs = ss.rebateStatistics();
		
		model.addAttribute("rs", rs);
		
		return "admin/statistics/adminRebateStatistics";
	}
	
	//통계 / 수익 - 환급액 연별 통계조회
	@RequestMapping("rebateYearSearch.sta")
	public ResponseEntity rebateYearSearch(String year) {
		
		RevenueStatistics rs = ss.rebateYearSearch(year);
		
		return new ResponseEntity(rs, HttpStatus.OK);
	}
}
