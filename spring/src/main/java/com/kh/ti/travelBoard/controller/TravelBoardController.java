package com.kh.ti.travelBoard.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ti.common.PageInfo;
import com.kh.ti.common.Pagination;
import com.kh.ti.member.model.vo.Member;
import com.kh.ti.point.model.vo.ReservePoint;
import com.kh.ti.point.model.vo.UsePoint;
import com.kh.ti.travel.model.vo.SchFile;
import com.kh.ti.travelBoard.model.service.TravelBoardService;
import com.kh.ti.travelBoard.model.vo.Gallary;
import com.kh.ti.travelBoard.model.vo.Likey;
import com.kh.ti.travelBoard.model.vo.TourReview;
import com.kh.ti.travelBoard.model.vo.TravelBoard;
import com.kh.ti.travelBoard.model.vo.TrvBoardSch;
import com.kh.ti.travelBoard.model.vo.TrvDaySchedule;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class TravelBoardController {
	
	@Autowired
	private TravelBoardService tbs;
	
	//여행일정 리스트 조회 - 예랑
	@RequestMapping("travelList.tb")
	public String travelList(HttpServletRequest request, Model model) {
		
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		TravelBoard tb = new TravelBoard();
		
		//전체 목록 조회(페이징용)
		HashMap pageMap = new HashMap();
		pageMap.put("tb", tb);
		
		int listCount = tbs.getListCount(pageMap);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		//일정 리스트 조회
		HashMap tbMap = tbs.travelList(pi, tb);
		
		model.addAttribute("tbList", tbMap.get("tbList"));
		model.addAttribute("tagList", tbMap.get("tagList"));
		model.addAttribute("cityList", tbMap.get("cityList"));
		model.addAttribute("pi", pi);
		
		return "travelBoard/travelList";
	}
	
	//여행일정 리스트 검색 - 예랑
	@RequestMapping("searchTravelList.tb")
	public String searchTravelList(String orderBy, String searchCondition, String searchContent, Model model, HttpServletRequest request) {
		
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		TravelBoard tb = new TravelBoard();
		
		//검색어 선택
		if(searchContent != null) {
			switch (searchCondition) {
			case "trvTitle": tb.setTrvTitle(searchContent); break;
			case "userName": tb.setUserName(searchContent); break;
			}
		}
		
		//order by 선택
		switch (orderBy) {
			case "completeDate" : tb.setLikeyCount(0); tb.setBuyCount(0); break;
			case "likeyCount" : tb.setLikeyCount(-1); break;
			case "buyCount" : tb.setBuyCount(-1); break;
		}
		
		//전체 목록 조회(페이징용)
		HashMap pageMap = new HashMap();
		pageMap.put("tb", tb);
		
		int listCount = tbs.getListCount(pageMap);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		//일정 리스트 조회
		HashMap tbMap = tbs.travelList(pi, tb);
		
		model.addAttribute("tbList", tbMap.get("tbList"));
		model.addAttribute("tagList", tbMap.get("tagList"));
		model.addAttribute("cityList", tbMap.get("cityList"));
		model.addAttribute("pi", pi);
		
		return "travelBoard/travelList";
	}
	
	//여행일정 리스트 태그 검색 - 예랑
	@RequestMapping("searchTagTravelList.tb")
	public String searchTagTravelList(String trvTags, String cityTags, Model model, HttpServletRequest request) {
		
		TravelBoard tb = new TravelBoard();
		
		if(!trvTags.equals("")) {
			ArrayList<String> trvTag = new ArrayList<String>(Arrays.asList(trvTags.split(",")));
			tb.setTrvTags((ArrayList) trvTag);
		}
		
		if(!cityTags.equals("")) {
			ArrayList<String> cityTag = new ArrayList<String>(Arrays.asList(cityTags.split(",")));
			tb.setTrvCities((ArrayList) cityTag);
		}
		
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//전체 목록 조회(페이징용)
		HashMap pageMap = new HashMap();
		pageMap.put("tb", tb);
		
		int listCount = tbs.getListCount(pageMap);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		//일정 리스트 조회
		HashMap tbMap = tbs.travelList(pi, tb);
		
		model.addAttribute("tbList", tbMap.get("tbList"));
		model.addAttribute("tagList", tbMap.get("tagList"));
		model.addAttribute("cityList", tbMap.get("cityList"));
		model.addAttribute("pi", pi);
		
		return "travelBoard/travelList";
	}
	
	//여행일정 상세 조회 - 예랑
	@RequestMapping("travelDetailForm.tb")
	public String travelDetailForm(int trvId, Model model, HttpServletRequest request) {
		
		//여행일정 전체 정보 조회용
		TravelBoard tb = new TravelBoard();
		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
		
		if(loginUser != null) {
			tb.setMemberId(loginUser.getMemberId());
		}
		tb.setTrvId(trvId);
		
		HashMap tbMap = tbs.travelDetailForm(tb);
		model.addAttribute("detailTb", tbMap.get("detailTb"));
		
		//상세 스케쥴 조회
		ArrayList detailDay = tbs.selectTravelDetailDays(tb);
		model.addAttribute("detailDay", detailDay);
		
		//가계부 정보 조회
		HashMap trvCost = tbs.selectTravelCost(trvId);
		model.addAttribute("allCost", trvCost.get("allCost"));
		
		//리뷰 정보 조회
		TourReview tr = new TourReview();
		
		if(loginUser != null) {
			tr.setMemberId(loginUser.getMemberId());
		}
		tr.setTrvId(trvId);
		
		//리뷰 목록 조회(페이징용)
		HashMap pageMap = new HashMap();
		pageMap.put("tr", tr);
		
		int listCount = tbs.getListCount(pageMap);
		PageInfo pi = Pagination.getPageInfo(1, listCount);
		
		//리뷰 리스트 조회
		ArrayList<TourReview> trList = tbs.tourReviewList(pi, tr);
		model.addAttribute("trList", trList);
		model.addAttribute("pi", pi);
		
		//갤러리 조회
		TrvDaySchedule sch = new TrvDaySchedule();
		sch.setTrvId(trvId);
		ArrayList gallary = tbs.travelDetailGallery(sch);
		model.addAttribute("gallary", gallary);
		
		return "travelBoard/travelDetail";
	}
	
	//여행상세일정 조회
	@RequestMapping("selectSchContent.tb")
	public ResponseEntity selectSchContent(int schId) {
		
		TrvBoardSch sch = tbs.selectSchContent(schId);
		
		return new ResponseEntity(sch, HttpStatus.OK);
	}
	
	//여행일정 구매리뷰 조회용
	@RequestMapping("selectTourReview.tb")
	public ResponseEntity selectTourReview(int trvId, int currentPage, HttpServletRequest request) {
		
		if(currentPage == 0) {
			currentPage = 1;
		}
		
		TourReview tr = new TourReview();
		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
		
		if(loginUser != null) {
			tr.setMemberId(loginUser.getMemberId());
		}
		tr.setTrvId(trvId);
		
		//전체 목록 조회(페이징용)
		HashMap pageMap = new HashMap();
		pageMap.put("tr", tr);
		
		int listCount = tbs.getListCount(pageMap);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		//리뷰 리스트 조회
		ArrayList<TourReview> trList = tbs.tourReviewList(pi, tr);
		
		return new ResponseEntity(trList, HttpStatus.OK);
	}
	
	//여행일정 삭제 - 예랑
	@RequestMapping("travelDelete.tb")
	public String travelDelete(Model model, int trvId) {
		
		int result = tbs.travelDelete(trvId);
		
		if(result > 0) {
			return "redirect:/travelList.tb";
		}else {
			model.addAttribute("msg", "일정 삭제 실패");
			return "common/errorPage";
		}
	}
	
	//여행일정 좋아요 - 예랑
	@RequestMapping("travelLikeyInsert.tb")
	public ModelAndView travelLikeyInsert(ModelAndView mv, int trvId, int memberId) {
		
		Likey likey = new Likey();
		likey.setTrvId(trvId);
		likey.setMemberId(memberId);
		
		tbs.travelLikeyInsert(likey);
		
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	//여행일정 좋아요 취소 - 예랑
	@RequestMapping("travelLikeyDelete.tb")
	public ModelAndView travelLikeyDelete(ModelAndView mv, int trvId, int memberId) {
		
		Likey likey = new Likey();
		likey.setTrvId(trvId);
		likey.setMemberId(memberId);
		
		tbs.travelLikeyDelete(likey);
		
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	//여행일정 상세 / 가계부 / 가계부 다운로드 - 예랑
	@RequestMapping("costDownload.tb")
	public void costDownload(int trvId, HttpServletRequest request, HttpServletResponse response) throws IOException {
		tbs.costDownload(trvId, request, response);
	}
	
	//여행일정 상세 / 리뷰 작성 - 예랑
	@RequestMapping("insertReview.tb")
	public ResponseEntity insertReview(int trvId, int memberId, int grade, String reviewContent) {
		
		TourReview tr = new TourReview();
		tr.setTrvId(trvId);
		tr.setMemberId(memberId);
		tr.setGrade(grade);
		tr.setReviewContent(reviewContent);
		
		int reviewId = tbs.insertReview(tr);
		
		ReservePoint rp = null;
		
		if(reviewId > 0) {
			rp = new ReservePoint();
			rp.setMemberId(memberId);
			rp.setReviewId(reviewId);
			rp.setReserveType(20);
			rp.setReservePoint(50);
		}
		
		return new ResponseEntity(rp, HttpStatus.OK);
	}
	
	//자신이 작성한 여행일정 리뷰 검색
	@RequestMapping("myTourReviewSearch.tb")
	public ResponseEntity myTourReviewSearch(int trvId, int memberId) {
		
		TourReview tr = new TourReview();
		tr.setTrvId(trvId);
		tr.setMemberId(memberId);
		
		TourReview myReview = tbs.myTourReviewSearch(tr);
		
		return new ResponseEntity(myReview, HttpStatus.OK);
	}
	
	//자신이 작성한 여행일정 리뷰 수정
	@RequestMapping("myTourReviewUpdate.tb")
	public ModelAndView myTourReviewUpdate(int reviewId, int grade, String reviewContent, ModelAndView mv) {
		
		TourReview tr = new TourReview();
		tr.setReviewId(reviewId);
		tr.setGrade(grade);
		tr.setReviewContent(reviewContent);
		
		int result = tbs.myTourReviewUpdate(tr);
		
		String msg = "";
		if(result > 0) {
			msg = "리뷰수정 성공";
		}else {
			msg = "리뷰수정 실패";
		}
		
		mv.setViewName("jsonView");
		mv.addObject(msg);
		
		return mv;
	}
	
	//여행일정 상세 / 리뷰 삭제 - 예랑
	@RequestMapping("deliteReview.tb")
	public ModelAndView deliteReview(int reviewId, int memberId, ModelAndView mv) {
		
		TourReview tr = new TourReview();
		tr.setReviewId(reviewId);
		tr.setMemberId(memberId);
		
		int result = tbs.deliteReview(tr);
		
		String msg = "";
		if(result > 0) {
			msg = "리뷰삭제 성공";
		}else {
			msg = "리뷰삭제 실패";
		}
		
		mv.setViewName("jsonView");
		mv.addObject(msg);
		
		return mv;
	}
	
	//마이페이지 / 구매한 일정 보기 - 예랑
	@RequestMapping("myBuyTravelListView.tb")
	public String myBuyTravelListView(Model model, HttpServletRequest request) {
		
		int memberId = ((Member) request.getSession().getAttribute("loginUser")).getMemberId();
		
		HashMap tbMap = tbs.myBuyTravelListView(memberId);
		
		model.addAttribute("tbList", tbMap.get("tbList"));
		
		return "travelBoard/myBuyTravelList";
	}
	
	//마이페이지 / 좋아요 / 여행일정 좋아요 보기 - 예랑
	@RequestMapping("myLikeyTravelListView.tb")
	public String myLikeyTravelListView(Model model, HttpServletRequest request) {
		
		int memberId = ((Member) request.getSession().getAttribute("loginUser")).getMemberId();
		
		HashMap tbMap = tbs.myLikeyTravelListView(memberId);
		
		model.addAttribute("tbList", tbMap.get("tbList"));
		
		return "travelBoard/myLikeyTravelList";
	}
	
	//마이페이지 / 좋아요, 구매수 카운트 조회 - 예랑
	@RequestMapping("selectMyCount.tb")
	public ResponseEntity selectMyCount(int memberId) {
		
		TravelBoard tb = tbs.selectMyCount(memberId);
		
		return new ResponseEntity(tb, HttpStatus.OK);
	}
	
}
