package com.kh.ti.travel.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ti.common.CommonUtils;
import com.kh.ti.member.model.vo.Member;
import com.kh.ti.travel.model.service.TravelService;
import com.kh.ti.travel.model.vo.City;
import com.kh.ti.travel.model.vo.Country;
import com.kh.ti.travel.model.vo.SchFile;
import com.kh.ti.travel.model.vo.Tag;
import com.kh.ti.travel.model.vo.Travel;
import com.kh.ti.travel.model.vo.TrvCity;
import com.kh.ti.travel.model.vo.TrvCompany;
import com.kh.ti.travel.model.vo.TrvCost;
import com.kh.ti.travel.model.vo.TrvDay;
import com.kh.ti.travel.model.vo.TrvSchedule;
import com.kh.ti.travel.model.vo.TrvTag;

@Controller
public class TravelController {

	@Autowired
	private TravelService ts;

	@RequestMapping("selectPublicTrvCount.trv")
	public ModelAndView selectPublicTrvCount(int memberId, ModelAndView mv) {
		int publicTrvCount = ts.selectPublicTrvCount(memberId);
		mv.addObject("publicTrvCount", publicTrvCount);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("showMyTravel.trv")
	public String showMyTravel(HttpSession session, Model model) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		ArrayList<Travel> trvList = ts.selectTrvList(loginUser.getMemberId());
		ArrayList<Travel> privateTrvList = new ArrayList<Travel>();
		ArrayList<Travel> publicTrvList = new ArrayList<Travel>();
		for (int i = 0; i < trvList.size(); i++) {
			if (trvList.get(i).getCompleteDate() == null) {
				privateTrvList.add(trvList.get(i));
			} else {
				publicTrvList.add(trvList.get(i));
			}
		}
		
		ArrayList<Travel> sharedTrvList = ts.selectSharedTrvList(loginUser.getMemberId());
		
		model.addAttribute("privateTrvList", privateTrvList);
		model.addAttribute("publicTrvList", publicTrvList);
		model.addAttribute("sharedTrvList", sharedTrvList);
		return "travel/myTravel";
	}

	@RequestMapping("selectCountryList.trv")
	public ModelAndView selectCountryList(ModelAndView mv) {
		ArrayList<Country> countryList = ts.selectCountryList();
		mv.addObject("countryList", countryList);
		mv.setViewName("jsonView");
		return mv;
	}

	@RequestMapping("selectCityList.trv")
	public ModelAndView selectCityList(ModelAndView mv, int countryId) {
		ArrayList<City> cityList = ts.selectCityList(countryId);
		mv.addObject("cityList", cityList);
		mv.setViewName("jsonView");
		return mv;
	}

	// 새일정작성-민지
	@RequestMapping("insertTravel.trv")
	public String insertTravel(Travel trv, String startDate, String endDate, String trvCity, Model model) {
		System.out.println(trv);
		trv.setStartDate(Date.valueOf(startDate));
		trv.setEndDate(Date.valueOf(endDate));
		String[] strArr = trvCity.split(",");
		System.out.println(trvCity);
		int[] cityArr = new int[strArr.length];
		for (int i = 0; i < strArr.length; i++) {
			cityArr[i] = Integer.parseInt(strArr[i]);
		}
		trv.setTrvCities(cityArr);

		int trvId = ts.insertTravel(trv);
		if (trvId > 0) {
			return "redirect:/selectTravel.trv?trvId=" + trvId;
		} else {
			model.addAttribute("msg", "새 일정 만들기 실패");
			return "common/errorPage";
		}
	}

	// 일정조회-민지
	@RequestMapping("selectTravel.trv")
	public String showTrvEditor(int trvId, Model model) {
		HashMap trvMap = ts.selectTravel(trvId);

		if (!trvMap.isEmpty()) {
			model.addAttribute("trv", trvMap.get("trv"));
			model.addAttribute("trvCityList", trvMap.get("trvCityList"));
			model.addAttribute("trvDayList", trvMap.get("trvDayList"));
			model.addAttribute("allTagList", trvMap.get("allTagList"));
			model.addAttribute("trvTagList", trvMap.get("trvTagList"));
			model.addAttribute("trvCompList", trvMap.get("trvCompList"));
			model.addAttribute("likeySpotList", trvMap.get("likeySpotList"));
			model.addAttribute("recommSpotList", trvMap.get("recommSpotList"));
			return "travel/travelEditor";
		} else {
			model.addAttribute("msg", "일정 정보 불러오기 실패");
			return "common/errorPage";
		}
	}

	// 전체일정정보 수정-민지
	@RequestMapping("updateTravel.trv")
	public String updateTravel(Travel trv, String trvCity, Model model) {
		String[] strArr = trvCity.split(",");
		int[] cityArr = new int[strArr.length];
		for (int i = 0; i < strArr.length; i++) {
			cityArr[i] = Integer.parseInt(strArr[i]);
		}
		trv.setTrvCities(cityArr);

		int result = ts.updateTravel(trv);
		if (result > 0) {
			return "redirect:/selectTravel.trv?trvId=" + trv.getTrvId();
		} else {
			model.addAttribute("msg", "여행 정보 수정 실패!");
			return "common/errorPage";
		}
	}

	// 작성완료처리-민지
	@RequestMapping("completeTravel.trv")
	public String completeTravel(int trvId, int memberId, Model model) {
		System.out.println("trvId : " + trvId);
		System.out.println("memberId : " + memberId);
		int result = ts.completeTravel(trvId);

		if (result > 0) {
			model.addAttribute("memberId", memberId);
			model.addAttribute("reserveType", 10);
			model.addAttribute("code", trvId);
			model.addAttribute("rPoint", 300);
			return "redirect:/pointReserve.po";
		} else {
			model.addAttribute("msg", "일정 작성완료처리 실패!");
			return "common/errorPage";
		}
	}

	// 여행일정 삭제-민지
	@RequestMapping("deleteTravel.trv")
	public String deleteTravel(int trvId, Model model) {
		int result = ts.deleteTravel(trvId);
		if (result > 0) {
			return "redirect:/showMyTravel.trv";
		} else {
			model.addAttribute("msg", "일정 삭제 실패");
			return "common/errorPage";
		}
	}

	// 상세일정추가-민지
	@RequestMapping("insertSch.trv")
	public ModelAndView insertTrvSchedule(TrvSchedule sch, TrvCost cost, int trvId, ModelAndView mv) {
		System.out.println("SCH : " + sch);
		System.out.println("COST : " + cost);

		cost.setCostContent(sch.getSchTitle());

		int schId = ts.insertTrvSchedule(sch, cost);
		
		ArrayList<TrvSchedule> schList = ts.selectSchList(sch.getDayId());
		int dayNumber = ts.selectDayNumber(sch.getDayId());
		
		mv.addObject("schId", schId);
		mv.addObject("schList", schList);
		mv.addObject("dayNumber", dayNumber);
		mv.setViewName("jsonView");
		return mv;
	}


	// 상세일정업데이트-민지
	@RequestMapping("updateSch.trv")
	public ModelAndView updateTrvSchedule(TrvSchedule sch, TrvCost cost, int trvId, ModelAndView mv) {
		System.out.println("sch: " + sch);
		System.out.println("cost: " + cost);
		System.out.println("trvId: " + trvId);
		cost.setCostContent(sch.getSchTitle());
		
		int schId = sch.getSchId();
		TrvSchedule originSch = ts.selectTrvSchedule(schId);
		int originDayId = originSch.getDayId();
		int changeDayId = sch.getDayId();
		System.out.println("originDayId : " + originDayId);
		System.out.println("changeDayId : " + changeDayId);
		TrvCost originCost = ts.selectSchCost(schId);
		
		int result = ts.updateTrvSchedule(sch, cost);
		
		
		ArrayList<TrvSchedule> originSchList = ts.selectSchList(originDayId);
		int originDayNumber = ts.selectDayNumber(originDayId);
		mv.addObject("originSchList", originSchList);
		mv.addObject("originDayNumber", originDayNumber);
		ArrayList<TrvCost> originCostList = ts.selectDayCostList(originDayId);
		mv.addObject("originCostList", originCostList);
		
		
		if(originDayId != changeDayId) {
			ArrayList<TrvSchedule> changeSchList = ts.selectSchList(changeDayId);
			int changeDayNumber = ts.selectDayNumber(changeDayId);
			mv.addObject("changeSchList", changeSchList);
			mv.addObject("changeDayNumber", changeDayNumber);
			ArrayList<TrvCost> changeCostList = ts.selectDayCostList(changeDayId);
			mv.addObject("changeCostList", changeCostList);
		}
		
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 상세일정삭제-민지
	@RequestMapping("deleteSch.trv")
	public ModelAndView deleteSchedule(int schId, int trvId, ModelAndView mv) {

		TrvCost cost = ts.selectSchCost(schId);
		if(cost != null) {
			mv.addObject("costId", cost.getCostId());
		}
		int dayId = ts.deleteTrvSchedule(schId);
		
		ArrayList<TrvSchedule> schList = ts.selectSchList(dayId);
		int dayNumber = ts.selectDayNumber(dayId);
		
		mv.addObject("dayNumber", dayNumber);
		mv.addObject("schList", schList);
		mv.setViewName("jsonView");
		return mv;
	}

	// 상세일정 순서변경-민지
	@RequestMapping("updateSchNumber.trv")
	public ModelAndView updateSchNumber(int dayId, int[] sch, ModelAndView mv) {
		int result = ts.updateSchNumber(dayId, sch);

		ArrayList<TrvSchedule> updList = ts.selectSchList(dayId);
		mv.addObject("updList", updList);
		mv.setViewName("jsonView");
		return mv;
	}

	// 상세일정 날짜 변경-민지
	@RequestMapping("deleteSchNumber.trv")
	public ModelAndView deleteSchNumber(int originDayId, int[] sch, ModelAndView mv) {
		int result = ts.deleteSchNumber(originDayId, sch);
		
		//mv.st
		mv.setViewName("jsonView");
		return mv;
	}

	// 상세일정 날짜 변경-민지
	@RequestMapping("changeSchDay.trv")
	public ModelAndView changeSchDay(TrvSchedule trvSch, int[] sch, ModelAndView mv) {

		System.out.println("sch" + sch);
		TrvSchedule originSch = ts.selectTrvSchedule(trvSch.getSchId());
		int originDayId = originSch.getDayId();
		int originDayNumber = ts.selectDayNumber(originDayId);
		int changeDayId = trvSch.getDayId();
		int changeDayNumber = ts.selectDayNumber(changeDayId);
		mv.addObject("originDayNumber", originDayNumber);
		mv.addObject("changeDayNumber", changeDayNumber);
		
		int result = ts.updateSchDay(trvSch, sch);
		TrvCost cost = ts.selectSchCost(trvSch.getSchId());
		if (cost != null) {
			cost.setDayId(trvSch.getDayId());
			int result1 = ts.updateTrvCost(cost);
			mv.addObject("costId", cost.getCostId());
		}
		
		ArrayList<TrvSchedule> originSchList = ts.selectSchList(originDayId);
		ArrayList<TrvSchedule> changeSchList = ts.selectSchList(trvSch.getDayId());
		mv.addObject("originSchList", originSchList);
		mv.addObject("changeSchList", changeSchList);
		
		mv.setViewName("jsonView");
		return mv;
	}

	

	// 여행테마추가-민지
	@RequestMapping("insertTrvTag.trv")
	public ModelAndView insertTrvTag(TrvTag trvTag, ModelAndView mv) {
		int result = ts.insertTrvTag(trvTag);
		mv.setViewName("jsonView");
		return mv;
	}

	// 여행테마삭제-민지
	@RequestMapping("deleteTrvTag.trv")
	public ModelAndView deleteTrvTag(TrvTag trvTag, ModelAndView mv) {
		int result = ts.deleteTrvTag(trvTag);
		mv.setViewName("jsonView");
		return mv;
	}

	// dayMemo업데이트 - 민지
	@RequestMapping("updateDayMemo.trv")
	public ModelAndView updateDayMemo(TrvDay trvDay, ModelAndView mv) {

		int result = ts.updateDayMemo(trvDay);

		mv.setViewName("jsonView");
		return mv;
	}

	// 상세글 작성-민지
	@RequestMapping("updateSchContent.trv")
	public ModelAndView updateSchContent(TrvSchedule sch, ModelAndView mv) {
		System.out.println(sch);
		int result = ts.updateSchContent(sch);
		TrvSchedule schedule = ts.selectTrvSchedule(sch.getSchId());
		mv.addObject("sch", schedule);
		mv.setViewName("jsonView");
		return mv;
	}

	// 상세글 조회-민지
	@RequestMapping("selectSchContent.trv")
	public ModelAndView selectSchContent(int schId, ModelAndView mv) {

		TrvSchedule sch = ts.selectTrvSchedule(schId);
		if (sch.getSchContent() != null) {
			mv.addObject("content", sch.getSchContent());
		}
		mv.setViewName("jsonView");
		return mv;
	}

	
	// 사진업로드-민지
	@RequestMapping("insertSchFile.trv")
	public ModelAndView insertSchFile(HttpServletRequest request, ModelAndView mv,
			@RequestParam(name = "image", required = false) MultipartFile image, int schId) {

		String root = request.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "\\uploadFiles";
		String originName = image.getOriginalFilename();
		String ext = originName.substring(originName.lastIndexOf("."));
		String changeName = CommonUtils.getRandomString();

		try {
			image.transferTo(new File(filePath + "\\" + changeName + ext));

			SchFile file = new SchFile();
			file.setOriginName(originName);
			file.setChangeName(changeName + ext);
			file.setFilePath(filePath);
			file.setSchId(schId);

			int fileId = ts.insertSchFile(file);

			SchFile schFile = ts.selectSchFile(fileId);
			mv.addObject("changeName", schFile.getChangeName());
			mv.addObject("fileLevel", schFile.getFileLevel());
			mv.addObject("fileId", fileId);
			// mv.addObject("schFile", schFile);

		} catch (Exception e) {
			new File(filePath + "\\" + changeName + ext).delete();
			e.printStackTrace();
		}
		mv.setViewName("jsonView");
		return mv;
	}

	// 대표사진변경-민지
	@RequestMapping("changeFileLevel.trv")
	public ModelAndView changeFileLevel(int fileId, ModelAndView mv) {

		System.out.println("fileId : " + fileId);
		int result = ts.updateSchFileId(fileId);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 사진삭제-민지
	@RequestMapping("deleteSchFile.trv")
	public ModelAndView deleteSchFile(int fileId, HttpServletRequest request, ModelAndView mv) {
		
		SchFile originFile = ts.selectSchFile(fileId);
		int result = ts.deleteSchFile(fileId);
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String filePath = root + "\\uploadFiles";
		new File(filePath + "\\" + originFile.getChangeName()).delete();
	
		mv.setViewName("jsonView");
		return mv;
	}

	// 날씨정보업로드-민지
	@RequestMapping("updateDayWeather.trv")
	public ModelAndView updateDayWeather(TrvDay trvDay, ModelAndView mv) {

		System.out.println("trvDay : " + trvDay);
		int result = ts.updateDayWeather(trvDay);
		int dayNumber = ts.selectDayNumber(trvDay.getDayId());
		
		mv.addObject("dayNumber", dayNumber);
		mv.setViewName("jsonView");
		return mv;
	}

	// 전체예산수정-민지
	@RequestMapping("updateBudget.trv")
	public ModelAndView updateBudget(Travel trv, ModelAndView mv) {
		int result = ts.updateBudget(trv);

		mv.setViewName("jsonView");
		return mv;
	}

	// 가계부 작성-민지
	@RequestMapping("insertCost.trv")
	public ModelAndView insertTrvCost(TrvCost cost, ModelAndView mv) {
		System.out.println(cost);
		int costId = ts.insertTrvCost(cost);
		if (costId > 0) {
			TrvCost trvCost = ts.selectTrvCost(costId);
			mv.addObject("trvCost", trvCost);
		}
		mv.setViewName("jsonView");
		return mv;
	}

	// 가계부수정-민지
	@RequestMapping("updateCost.trv")
	public ModelAndView updateTrvCost(TrvCost cost, ModelAndView mv) {

		// dayId가 0으로 넘온건 일정에 연결된 cost를 수정한 경우
		System.out.println(cost);
		if (cost.getDayId() == 0) {
			TrvCost originCost = ts.selectTrvCost(cost.getCostId());
			cost.setDayId(originCost.getDayId());
		}

		int result = ts.updateTrvCost(cost);
		TrvCost trvCost = ts.selectTrvCost(cost.getCostId());
		mv.addObject("trvCost", trvCost);
		mv.setViewName("jsonView");
		return mv;
	}

	// 가계부삭제-민지
	@RequestMapping("deleteCost.trv")
	public ModelAndView deleteTrvCost(int costId, ModelAndView mv) {
		int result = ts.deleteTrvCost(costId);
		
		mv.setViewName("jsonView");
		return mv;
	}



	// 일정엑셀다운-민지
	@RequestMapping("downloadSch.trv")
	public void downloadSch(int trvId, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ts.selectDownloadSch(trvId, request, response);
	}
	
	//가계부 엑셀다운-민지
	@RequestMapping("downloadCost.trv")
	public void downloadCost(int trvId, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ts.selectDownloadCost(trvId, request, response);
	}

	//구매한 일정으로 새일정 작성
	@RequestMapping("overrideTravel.trv")
	public String overrideTravel(int trvId, HttpSession session, Model model) {

		Member loginUser = (Member)session.getAttribute("loginUser");
		int memberId = loginUser.getMemberId();
		int ovTrvId = ts.insertOverrideTravel(trvId, memberId);
		
		
		return "redirect:selectTravel.trv?trvId=" + ovTrvId;
	}
	
	//구매한 일정으로 새일정 작성 정보 불러오기
	@RequestMapping("selectOvTravel.trv")
	public String selectOvTravel(int trvId, int refId, Model model) {
		
		System.out.println("trvId : " + trvId);
		System.out.println("refId : " + refId);
		HashMap refMap = ts.selectTravel(refId);
		
		
		return "travel/travelEditor";
	}
	

	
	//동행검색
	@RequestMapping("searchCompany.trv")
	public ModelAndView searchCompany(String email, ModelAndView mv) {
		
		System.out.println(email);
		
		Member member = ts.selectCompany(email);
		if(member != null) {
			mv.addObject("member", member);
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 동행추가-민지
	@RequestMapping("insertCompany.trv")
	public ModelAndView insertTrvCompany(int trvId, int memberId, ModelAndView mv) {
		TrvCompany trvComp = new TrvCompany();
		trvComp.setMemberId(memberId);
		trvComp.setTrvId(trvId);
		int result = ts.insertTrvCompany(trvComp);
		
		mv.setViewName("jsonView");
		return mv;
	}

	// 여행동행삭제-민지
	@RequestMapping("deleteCompany.trv")
	public ModelAndView deleteTrvComp(TrvCompany trvComp, ModelAndView mv) {
		int result = ts.deleteTrvComp(trvComp);
		
		mv.setViewName("jsonView");
		return mv;
	}
	

	//상세일정리스트조회 - 민지
	@RequestMapping("selectSchList.trv")
	public ModelAndView selectSchList(int dayId, ModelAndView mv) {
		ArrayList<TrvSchedule> schList = ts.selectSchList(dayId);
		int dayNumber = ts.selectDayNumber(dayId);
		mv.addObject("schList", schList);
		mv.addObject("dayNumber", dayNumber);
		mv.setViewName("jsonView");
		return mv;
	}

	

}
