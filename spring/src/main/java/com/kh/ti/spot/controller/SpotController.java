package com.kh.ti.spot.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ti.common.PageInfo;
import com.kh.ti.common.Pagination;
import com.kh.ti.member.model.vo.Member;
import com.kh.ti.spot.model.service.SpotService;
import com.kh.ti.spot.model.vo.AdminSpotList;
import com.kh.ti.spot.model.vo.Likey;
import com.kh.ti.spot.model.vo.SpotFile;
import com.kh.ti.spot.model.vo.SpotList;
import com.kh.ti.spot.model.vo.SpotReviews;
import com.kh.ti.travel.model.vo.City;
import com.kh.ti.travel.model.vo.Country;

@Controller
public class SpotController {
	
	@Autowired
	private SpotService ss;
	
	//메인화면으로 가는 용 메소드 -- 세령
	@RequestMapping("showIndex.me")
	public String showIndexPage() {
		return "redirect:index.jsp";
	}
	
	
	//엑셀로여행지추가용메소드 - 세령
	@ResponseBody
	@RequestMapping("insertSpotExcel.sp")
	public ModelAndView insertSpotFromExcel(HttpServletRequest  request,
			@RequestParam(name="excelFile", required=false) MultipartFile excelFile) {
       // MultipartFile excelFile = request.getFile("excelFile");
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택해 주세요");
        }
 
        File destFile = new File("D:\\"+excelFile.getOriginalFilename());
        try {
            excelFile.transferTo(destFile);
        } catch (IllegalStateException | IOException e) {
            throw new RuntimeException(e.getMessage(),e);
 
        }
        
        ss.insertMassiveArticleInBoard(destFile);
        
        //FileUtils.deleteFile(destFile.getAbsolutePath());
        destFile.delete();
        
        ModelAndView view = new ModelAndView();
        view.setViewName("redirect:/selectAllSpotAdmin.sp?currentPage=1");
		return view;
	}
	
	//관리자 입력폼으로 여행지추가용 메소드 --세령
	@RequestMapping("showInserOneSpot.sp")
	public String showAdminAddOneSpot(Model model) {
		ArrayList<Country> countList = ss.selectCountryListForAdmin();
		ArrayList<City> cityList = ss.selectCityListForAdmin();
		
		model.addAttribute("countryList", countList);
		model.addAttribute("cityList", cityList);
		return "admin/spot/adminAddOneSpot";
	}
	
	//입력폼으로여행지추가용메소드
	@RequestMapping("insertOneSpot.sp")
	public String insertSpotFromForm(@ModelAttribute SpotList spotList) {
		System.out.println(spotList.toString());
		int result = ss.insertSpotList(spotList);
		return "redirect:/selectAllSpotAdmin.sp?currentPage=1";
	}
	
	//관리자여행지전체조회용메소드 --세령
	@RequestMapping("selectAllSpotAdmin.sp")
	public String selectAllSpotListForAdmin(Model model, @RequestParam("currentPage") int currentPage) {
		int listCount = ss.getSpotListCount();
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<AdminSpotList> spotList = ss.selectAllSpot(pi);
		model.addAttribute("spotList", spotList);
		model.addAttribute("listCount", listCount);
		model.addAttribute("pi", pi);
		return "admin/spot/adminSpotList";
	}
	
	//관리자여행지조건조회용메소드
	@RequestMapping("selectConditionSpotAdmin.sp")
	public String selectConditionSpotListForAdmin() {
		return "admin/spot/adminSpotList";
	}
	
	//관리자여행지상세보기용메소드 --세령
	@RequestMapping("selectSpotInfoAdmin.sp")
	public String selectSpotDetailInfoForAdmin(@RequestParam("spotId") int spotId, Model model) {
		SpotList spotList = ss.selectSpotListOne(spotId);
		ArrayList<SpotFile> spotFile = ss.selectSpotFile(spotId);
		City city = ss.selectCityOne(spotId);
		Country country = null;
		if(spotList != null) {
			country = ss.selectCountryOneInfo(city.getCityId());
		}

		model.addAttribute("spotList", spotList);
		model.addAttribute("spotFile", spotFile);
		model.addAttribute("city", city);
		model.addAttribute("country", country);
		return "admin/spot/adminSpotDetail";
	}
	
	//여행지수정용메소드
	@RequestMapping("updateSpotInfo.sp")
	public String updateSpotInfo() {
		return null;
	}
	
	//여행지정보삭제용메소드
	@RequestMapping("deleteOneSpot.sp")
	public String updateOneSpotStatusN(@RequestParam("spotIds") String spotIds, Model model) {
		ArrayList<Integer> spotIdArr = new ArrayList<Integer>();
		String[] arr = spotIds.split(",");
		for(int i = 0; i < arr.length; i++) {
			int a = Integer.parseInt(arr[i]);
			spotIdArr.add(a);
		}
		
		int result = ss.updateSpotStatus(spotIdArr);
		model.addAttribute("msg", "총 " + result + "개의 여행지가 삭제 되었습니다.");
		return "forward:selectAllSpotAdmin.sp?currentPage=1";
	}
	
	//사용자여행지전체조회용메소드 --세령
	@RequestMapping("selectAllSpotUser.sp")
	public String selectAllSpotFromUser(Model model, @RequestParam("condition") String condition) {
		ArrayList<Country> countryList = null;
		ArrayList<HashMap> cityMap = null;
		if(condition.equals("all")) { //주요도시
			countryList = ss.selectCountryList();
			cityMap = ss.selectCityMap();
		} else { //대륙별 조회
			countryList = ss.selectCountryList(condition);
			cityMap = ss.selectCityMap(condition);
		}
		
		model.addAttribute("nowContinent", condition);
		model.addAttribute("countryList", countryList);
		model.addAttribute("cityMap", cityMap);
 		return "spot/spotHome";
	}
	
	//사용자여행지조건조회용메소드
	@RequestMapping("selectConditionSpotUser.sp")
	public String  selectConditionSpotFromUser(@RequestParam("countryId") int countryId, @RequestParam("condition") String condition,
											   Model model) {
		ArrayList<HashMap> cityMap = ss.selectConditionSpotFromUser(countryId);
		ArrayList<Country> countryList = ss.selectCountryList(condition);
		model.addAttribute("nowContinent", condition);
		model.addAttribute("countryList", countryList);
		model.addAttribute("cityMap", cityMap);
		return "spot/spotHome";
	}
	
	//사용자여행지상세보기용메소드 --세령
	@RequestMapping("selectSpotInfoUser.sp")
	public String selectSpotInfoFromUser(@RequestParam("cityId") int cityId, Model model,
										@RequestParam("currentPage") int currentPage) {
		
		ArrayList<HashMap> spotList = ss.selectSpotList(cityId);
		Country countryInfo = ss.selectCountryOneInfo(cityId);
		ArrayList<SpotFile> cityFile = ss.selectCityFile(cityId);
		City city = ss.selectCity(cityId);
		
		model.addAttribute("spotList", spotList);
		model.addAttribute("countryInfo", countryInfo);
		model.addAttribute("cityFile", cityFile);
		model.addAttribute("city", city);
		return "spot/spotInfoPage";
	}
	
	//명소상세보기용메소드
	@RequestMapping("selectSpotDetailInfo.sp")
	public String selectSpotDetailInfo(@RequestParam("spotId") int spotId, Model model) {
		City city = ss.selectCityOne(spotId);
		SpotList spotList = ss.selectSpotListOne(spotId);
		ArrayList<HashMap> spotReviews = ss.selectSpotReviews(spotId);
		ArrayList<SpotFile> spotFile = ss.selectSpotFile(spotId);
		
		model.addAttribute("city", city);
		model.addAttribute("spotList", spotList);
		model.addAttribute("spotReviews", spotReviews);
		model.addAttribute("spotFile", spotFile);
		
		return "spot/spotDetailPage";
	}
	
	//사용자명소리뷰등록용메소드
	@RequestMapping("insertSpotReview.sp")
	public String insertSpotReview(@ModelAttribute SpotReviews spotReviews, Model model) {
		int spotReviewId = ss.insertSpotReviews(spotReviews);
		String path = "";
		if(spotReviewId > 0) {
			//포인트 적립 메소드로 전송
			path = "redirect:pointReserve.po?" +
					"memberId=" + spotReviews.getMemberId() + 
					"&code=" + spotReviewId + 
					"&reserveType=30&rPoint=10";	
			model.addAttribute("msg", "리뷰가 등록되었습니다.");
		} else {
			//에러 메세지 전송
			model.addAttribute("msg", "댓글 등록에 실패했습니다.");
			path = "redirect:selectSpotDetailInfo.sp?spotId=" + spotReviews.getSpotId();
		}
		return path;
	}
	
	//여행지 리뷰 수정용메소드 - 세령
	@RequestMapping("updateSpotReview.sp")
	public void updateSpotReview(@RequestParam("spotReviewId") int spotReviewId, @RequestParam("grade") int grade, 
								 @RequestParam("content") String content, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		
		SpotReviews spotReviews = new SpotReviews();
		spotReviews.setSpotReviewId(spotReviewId);
		spotReviews.setGrade(grade);
		spotReviews.setReviewContent(content);
		
		String msg = ss.updateSpotReview(spotReviews);
		
		try {
			response.getWriter().print(msg);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	//여행지 리뷰 삭제용메소드 - 세령
	@RequestMapping("deleteSpotReview.sp")
	public String deleteSpotReview(@RequestParam("spotReviewId") int spotReviewId, @RequestParam("spotId") int spotId, Model model) {
		String msg = ss.deleteSpotReview(spotReviewId);
		model.addAttribute("msg", msg);
		return "redirect:selectSpotDetailInfo.sp?spotId=" + spotId;
	}
	
	//관리자명소리뷰전체조회용메소드
	@RequestMapping("selectAllSpotReviewAdmin.sp")
	public String selectAllSpotReviewForAdmin() {
		return "admin/spot/adminSpotReviewList";
	}
	
	//여행지지도마커표시용메소드
	@RequestMapping("selectAllSpotPointMap.sp")
	public String selectAllSpotAddressForMap() {
		return null;
	}
	
	//명소지도마커표시용메소드
	@RequestMapping("selectOneSpotPointMap.sp")
	public String selectOneSpotAddressForMap() {
		return null;
	}
	
	//명소좋아요추가용메소드
	@RequestMapping("insertLikeySpot.sp")
	public void insertLikeySpot(@RequestParam("spotId") int spotId, HttpServletResponse response, HttpServletRequest request) {
		response.setCharacterEncoding("UTF-8");
		
		Likey likey = new Likey();
		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
		String msg = "";
		
		if(loginUser != null) {
			likey.setMemberId(loginUser.getMemberId());
			likey.setSpotId(spotId);
			msg = ss.insertSpotLikey(likey);
			
		} else {
			msg = "회원가입이 필요한 서비스 입니다.";
		} //end if

		try {
			response.getWriter().print(msg);
		} catch (IOException e) {
			e.printStackTrace();
		} //end try
	}
	
	//명소좋아요전체조회용메소드
	@RequestMapping("selectAllLikeySpot.sp")
	public String selectAllLikeySpot(HttpServletRequest request, Model model) {
		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
		
		ArrayList<HashMap> countryList = ss.selectMyLikeyCountryList(loginUser.getMemberId());
		ArrayList<HashMap> spotList = ss.selectMyLikeySpotList(loginUser.getMemberId());
		
		model.addAttribute("countryList", countryList);
		model.addAttribute("spotList", spotList);
		
		return "spot/myLikeySpotList";
	}
	
	//명소좋아요조건조회용메소드
	@RequestMapping("selectConditionLikeySpot.sp")
	public String selectConditionLikeySpot() {
		return null;
	}
	
	//명소좋아요삭제용메소드
	@RequestMapping("deleteLikeySpot.sp")
	public String deleteLikeySpot() {
		return null;
	}
	
} //end class
