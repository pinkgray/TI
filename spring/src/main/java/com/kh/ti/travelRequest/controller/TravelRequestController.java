package com.kh.ti.travelRequest.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
//의뢰 및 설계
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ti.common.PageInfo;
import com.kh.ti.common.Pagination;
import com.kh.ti.travelRequest.model.service.TravelRequestService;
import com.kh.ti.travelRequest.model.vo.TravelRequest;
import com.kh.ti.travelRequest.model.vo.TravelRequestPlan;

@Controller
@SessionAttributes("loginUser")
public class TravelRequestController {
	
	@Autowired
	private TravelRequestService trs;
	//여행 의뢰 게시판 - 이선우
	@RequestMapping("travelRequest.tr")
	public ModelAndView selectTravelRequest(HttpServletRequest request, HttpServletResponse response
			, ModelAndView mv) {
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//전체 목록 조회
		int listCount = trs.getListCount();
		System.out.println("의뢰글 수 : " + listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println("pageInfo : " + pi);
		
		ArrayList<TravelRequest> list = trs.selectRequestList(pi);
		System.out.println("의뢰글 목록 : " + list);
		
		//list, pi=> jsp전달
		mv.addObject("list", list);
		mv.addObject("pi", pi);
		
		mv.setViewName("travelRequest/travelRequest");
		
		return mv;
	}
	
	//의뢰하기폼 - 이선우
	@RequestMapping("showRequestForm.tr")
	public String showRequestForm() {
		
		return "travelRequest/request";
	}
	
	//의뢰하기 - 이선우
	@RequestMapping("insertRequest.tr")
	public String insertRequest(@ModelAttribute TravelRequest tr, Model model) {
		System.out.println(tr);
		
		int result = trs.insertRequest(tr);
		
		if(result > 0) {
			return "redirect:travelRequest.tr";
		} else {
			return "errorPage";
		}

	}
	
	//의뢰글 상세보기 - 이선우
	@RequestMapping("requestDetail.tr")
	public String selectRequestDetail(@RequestParam("reqId")String reqId, 
									  @RequestParam("userName")String userName, Model model) {
		int reqNum = Integer.parseInt(reqId);
		System.out.println("의뢰글 번호 : " + reqNum);
		System.out.println("의뢰자 이름 : " + userName);
		
		TravelRequest tr = trs.selectOneRequest(reqNum);
		System.out.println(tr);
		
		if(tr != null) {
			model.addAttribute("tr", tr);
			model.addAttribute("userName", userName);
			return "travelRequest/requestDetail";
		} else {
			model.addAttribute("msg", "의뢰글 상세조회 오류");
			return "common/errorPage";
		}
	}
	
	//설계해주기 - 이선우
	@RequestMapping("showrequestStartForm")
	public String showRequestStartForm(@RequestParam("reqId")int reqId,
									   @RequestParam("userName")String userName, Model model) {
		System.out.println(reqId);
		model.addAttribute("reqId", reqId);
		model.addAttribute("userName", userName);
		return "travelRequest/requestStart";
	}
	
	//설계글 상세보기 - 이선우
	@RequestMapping("requestPlan.tr")
	public String slelctRequestPlan(@RequestParam("ptcpId")int ptcpId,
									Model model) {
		
		System.out.println("참여글 번호 : " + ptcpId);
		ArrayList<TravelRequestPlan> trp = trs.selectOneRequestPlan(ptcpId);
		System.out.println("조회 결과 : " + trp);
		
		model.addAttribute("trp", trp);
		return "travelRequest/requestPlan";
	}
}
