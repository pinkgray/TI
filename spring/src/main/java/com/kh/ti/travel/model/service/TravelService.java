package com.kh.ti.travel.model.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import com.kh.ti.member.model.vo.Member;
import com.kh.ti.travel.model.vo.City;
import com.kh.ti.travel.model.vo.Country;
import com.kh.ti.travel.model.vo.SchFile;
import com.kh.ti.travel.model.vo.Tag;
import com.kh.ti.travel.model.vo.Travel;
import com.kh.ti.travel.model.vo.TrvCompany;
import com.kh.ti.travel.model.vo.TrvCost;
import com.kh.ti.travel.model.vo.TrvDay;
import com.kh.ti.travel.model.vo.TrvSchedule;
import com.kh.ti.travel.model.vo.TrvTag;

public interface TravelService {


	ArrayList<Travel> selectTrvList(int memberId);
	
	int insertTravel(Travel trv);
	
	HashMap selectTravel(int trvId);
	
	ArrayList<Country> selectCountryList();
	
	ArrayList<City> selectCityList(int countryId);

	int updateTravel(Travel trv);
	
	int completeTravel(int trvId);

	int deleteTravel(int trvId);
	
	int selectDayNumber(int dayId);
	

	int selectSchNumber(ArrayList<TrvSchedule> schList, String startTime);

	int insertTrvSchedule(TrvSchedule sch, TrvCost cost);

	int updateTrvSchedule(TrvSchedule sch, TrvCost cost);

	ArrayList<TrvCost> selectDayCostList(int dayId);

	ArrayList<TrvSchedule> selectSchList(int dayId);
	
	int updateSchNumber(int dayId, int[] sch);

	int deleteSchNumber(int originDayId, int[] sch);

	int updateSchDay(TrvSchedule trvSch, int[] sch);
	
	int deleteTrvSchedule(int schId);

	int updateDayMemo(TrvDay trvDay);

	int updateDayWeather(TrvDay trvDay);
	
	

	int insertTrvTag(TrvTag trvTag);

	int deleteTrvTag(TrvTag trvTag);	
	
	
	
	

	TrvSchedule selectTrvSchedule(int schId);
	
	int updateSchContent(TrvSchedule sch);

	int insertSchFile(SchFile schFile);

	SchFile selectSchFile(int fileId);

	int updateSchFileId(int fileId);

	int deleteSchFile(int fileId);
	
	
	

	int updateBudget(Travel trv);
	
	TrvCost selectSchCost(int schId);
	
	int insertTrvCost(TrvCost cost);

	TrvCost selectTrvCost(int costId);
	
	int updateTrvCost(TrvCost cost);

	int deleteTrvCost(int costId);


	
	
	
	
	
	
	
	


	
	HashMap selectSpotList(Travel trv);


	

	void selectDownloadSch(int trvId, HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException, IOException;

	void selectDownloadCost(int trvId, HttpServletRequest request, HttpServletResponse response) throws IOException;

	int insertOverrideTravel(int trvId, int memberId);

	Member selectCompany(String email);

	int insertTrvCompany(TrvCompany trvComp);

	int deleteTrvComp(TrvCompany trvComp);

	ArrayList<Travel> selectSharedTrvList(int memberId);

	int selectPublicTrvCount(int memberId);



















}
