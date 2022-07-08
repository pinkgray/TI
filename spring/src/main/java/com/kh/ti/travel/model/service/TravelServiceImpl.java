package com.kh.ti.travel.model.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ti.common.CommonUtils;
import com.kh.ti.member.model.vo.Member;
import com.kh.ti.spot.model.vo.SpotList;
import com.kh.ti.travel.model.dao.TravelDao;
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

@Service
public class TravelServiceImpl implements TravelService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private TravelDao td;
	
	
	
	
//------------travel--------------------------------------------------------------------------
	@Override
	public int selectPublicTrvCount(int memberId) {
		return td.selectPublicTrvCount(sqlSession, memberId);
	}
	
	@Override
	public ArrayList<Travel> selectTrvList(int memberId) {
		ArrayList<Travel> trvList = td.selectTrvList(sqlSession, memberId);
		for(int i = 0; i < trvList.size(); i++) {
			int trvId = trvList.get(i).getTrvId();
			ArrayList<TrvCity> trvCityList = td.selectTrvCityList(sqlSession, trvId);
			trvList.get(i).setTrvCityList(trvCityList);
			ArrayList<TrvTag> trvTagList = td.selectTrvTagList(sqlSession, trvId);
			trvList.get(i).setTrvTagList(trvTagList);
			SchFile mainImage = td.selectTrvMainImage(sqlSession, trvId);
			trvList.get(i).setMainImage(mainImage);
		}
		return trvList;
	}
	
	@Override
	public int insertTravel(Travel trv) {
		int result = 0;
		int result1 = td.insertTravel(sqlSession, trv);
		int result2 = 0;
		int result3 = 0;
		int trvId = td.selectTrvId(sqlSession);
		int[] trvCities = trv.getTrvCities();
		
		for(int i = 0; i < trvCities.length; i++) { 
			int cityId = trvCities[i];
			City city = td.selectCity(sqlSession, cityId); 
			TrvCity trvCity = new TrvCity(); 
			trvCity.setCityId(city.getCityId());
			trvCity.setTrvId(trvId);
			result2 += td.insertTrvCity(sqlSession, trvCity); 
		}
		
		Date startDate = trv.getStartDate();
		Date endDate = trv.getEndDate();
		int days = (int)((endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24)) + 1;
		
		for(int i = 0; i < days; i++) { 
			TrvDay trvDay = new TrvDay();
			trvDay.setTrvId(trvId); 
			trvDay.setDayNumber(i + 1); 
			Date date = new Date(startDate.getTime() + (1000 * 60 * 60 * 24) * i);
			trvDay.setDayDate(date); 
			result3 += td.insertTrvDay(sqlSession, trvDay); 
		}
		
		if(result1 > 0 && result2 == trvCities.length && result3 == days) {
			result = trvId;
		}
		return result;
	}
	
	@Override
	public HashMap selectTravel(int trvId) {
		HashMap trvMap = new HashMap();
		Travel trv = td.selectTravel(sqlSession, trvId);
		ArrayList<TrvCity> trvCityList = td.selectTrvCityList(sqlSession, trvId);
		ArrayList<TrvDay> trvDayList = td.selectTrvDayList(sqlSession, trvId);
		for(int i = 0; i < trvDayList.size(); i++) {
			int dayId = trvDayList.get(i).getDayId();
			ArrayList<TrvCost> costList = td.selectCostList(sqlSession, dayId);
			trvDayList.get(i).setCostList(costList);
			ArrayList<TrvSchedule> schList = td.selectSchList(sqlSession, dayId);
			for(int j = 0; j < schList.size(); j++) {
				int schId = schList.get(j).getSchId();
				TrvCost cost = td.selectSchCost(sqlSession, schId);
				schList.get(j).setTrvCost(cost);
				
				ArrayList<SchFile> fileList = td.selectSchFileList(sqlSession, schId);
				schList.get(j).setFileList(fileList);
				
			}
			trvDayList.get(i).setSchList(schList);
		}
		
		ArrayList<Tag> allTagList = td.selectTagList(sqlSession);
		ArrayList<TrvTag> trvTagList = td.selectTrvTagList(sqlSession, trvId);
		ArrayList<TrvCompany> trvCompList = td.selectTrvCompList(sqlSession, trvId);
		ArrayList<HashMap> likeySpotList = td.selectLikeySpotList(sqlSession, trv);
		ArrayList<HashMap> recommSpotList = td.selectRecommSpotList(sqlSession, trv);
		trvMap.put("trv", trv);
		trvMap.put("trvCityList", trvCityList);
		trvMap.put("trvDayList", trvDayList);
		trvMap.put("allTagList", allTagList);
		trvMap.put("trvTagList", trvTagList);
		trvMap.put("trvCompList", trvCompList);
		trvMap.put("likeySpotList", likeySpotList);
		trvMap.put("recommSpotList", recommSpotList);
		return trvMap;
	}

	@Override
	public ArrayList<Country> selectCountryList() {
		return td.selectCountryList(sqlSession);
	}

	@Override
	public ArrayList<City> selectCityList(int countryId) {
		return td.selectCityList(sqlSession, countryId);
	}


	@Override
	public int updateTravel(Travel trv) {
		int result = td.updateTravel(sqlSession, trv);
		int[] trvCities = trv.getTrvCities();
		int duplicated = 0;
		ArrayList<TrvCity> trvCityList = td.selectTrvCityList(sqlSession, trv.getTrvId());
		for(int j = 0; j < trvCityList.size(); j++) {
			for(int i = 0; i < trvCities.length; i++) { 
				if(trvCityList.get(j).getCityId() == trvCities[i]) {
					duplicated++;
				}
			}
			if(duplicated == 0) {
				td.deleteTrvCity(sqlSession, trvCityList.get(j));
			}
			duplicated = 0;
		}
		duplicated = 0;
		for(int i = 0; i < trvCities.length; i++) { 
			for(int j = 0; j < trvCityList.size(); j++) {
				if(trvCities[i] == trvCityList.get(j).getCityId()) {
					duplicated++;
				};
			}
			if(duplicated == 0) {
				TrvCity trvCity = new TrvCity();
				trvCity.setTrvId(trv.getTrvId());
				trvCity.setCityId(trvCities[i]);
				td.insertTrvCity(sqlSession, trvCity);
			}
			duplicated = 0;
		}
		
		ArrayList<TrvDay> trvDayList = td.selectTrvDayList(sqlSession, trv.getTrvId());
		Date startDate = trv.getStartDate();
		Date endDate = trv.getEndDate();
		int days = (int)((endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24)) + 1;
		
		if(trvDayList.get(0).getDayDate() != startDate || trvDayList.get(trvDayList.size() - 1).getDayDate() != endDate) {
			if(trvDayList.size() > days) {
				for(int i = 0; i < trvDayList.size(); i++) {
					if(i < days) {
						TrvDay trvDay = new TrvDay();
						Date date = new Date(startDate.getTime() + (1000 * 60 * 60 * 24) * i);
						trvDay.setTrvId(trv.getTrvId()); 
						trvDay.setDayNumber(i + 1);
						trvDay.setDayDate(date);
						td.updateTrvDay(sqlSession, trvDay);
					}else {
						td.deleteTrvDay(sqlSession, trvDayList.get(i));
					}
				}
			}else if (trvDayList.size() < days) {
				for(int i = 0; i < days; i++) {
					if(i < trvDayList.size()) {
						TrvDay trvDay = new TrvDay();
						Date date = new Date(startDate.getTime() + (1000 * 60 * 60 * 24) * i);
						trvDay.setTrvId(trv.getTrvId()); 
						trvDay.setDayNumber(i + 1);
						trvDay.setDayDate(date);
						td.updateTrvDay(sqlSession, trvDay);
					}else {
						TrvDay trvDay = new TrvDay();
						Date date = new Date(startDate.getTime() + (1000 * 60 * 60 * 24) * i);
						trvDay.setTrvId(trv.getTrvId()); 
						trvDay.setDayNumber(i + 1);
						trvDay.setDayDate(date);
						td.insertTrvDay(sqlSession, trvDay);
					}
				}
			}
		}
		return result;
	}
	
	@Override
	public int completeTravel(int trvId) {
		return td.completeTravel(sqlSession, trvId);
	}

	@Override
	public int deleteTravel(int trvId) {
		return td.deleteTravel(sqlSession, trvId);
	}
	
	
	
//----------------schedule------------------------------------------------------
	@Override
	public int selectSchNumber(ArrayList<TrvSchedule> schList, String startTime) {
		int difference = 1440;
		int number = 0;
		int hour = Integer.parseInt(startTime.substring(0, startTime.indexOf(":")));
		int minute = Integer.parseInt(startTime.substring(startTime.indexOf(":") + 1));
		
		for(int i = 0; i < schList.size(); i++) {
			String start = schList.get(i).getStartTime();
			System.out.println(start);
			if(start != null) {
				int hr = Integer.parseInt(start.substring(0, startTime.indexOf(":")));
				int min = Integer.parseInt(start.substring(startTime.indexOf(":") + 1));
				int diff = (hour * 60 + minute) - (hr * 60 + min);
				if(diff > 0 && diff < difference) {
					difference = diff;
					number = schList.get(i).getSchNumber() + 1;
				}
			}
		}
		
		if(number == 0) number = 1;
		
		for(int i = 0; i < schList.size(); i++) {
			if(schList.get(i).getSchNumber() >= number) {
				schList.get(i).setSchNumber(schList.get(i).getSchNumber() + 1);
				int result = td.updateSchNumber(sqlSession, schList.get(i));
			}
		}
		
		return number;
	}

	
	
	@Override
	public int insertTrvSchedule(TrvSchedule sch, TrvCost cost) {

		int count = td.selectSchCount(sqlSession, sch.getDayId());
		if(sch.getIsTimeset() != null) {
			sch.setIsTimeset("N");
			sch.setSchNumber(count + 1);
		}else {
			sch.setIsTimeset("Y");
			if(count > 0) {
				ArrayList<TrvSchedule> schList = td.selectSchList(sqlSession, sch.getDayId());
				int number = selectSchNumber(schList, sch.getStartTime());
				sch.setSchNumber(number);
				System.out.println("number : " + number);
			}else {
				sch.setSchNumber(count + 1);
			}
		}
		
		
		int result = td.insertTrvSchedule(sqlSession, sch);
		
		int schId = td.selectSchId(sqlSession);
		if(cost.getCostAmount() != 0.0) {
			cost.setSchId(schId);
			int result2 = td.insertSchCost(sqlSession, cost);
		}
		
		return schId;
	}
	
	@Override
	public int selectDayNumber(int dayId) {
		return td.selectDayNumber(sqlSession, dayId);
	}

	@Override
	public int updateTrvSchedule(TrvSchedule sch, TrvCost cost) {
		int result = 0;
		if(sch.getIsTimeset() != null) {
			sch.setIsTimeset("N");
		}else {
			sch.setIsTimeset("Y");
		}
		int dayId = sch.getDayId();
		String startTime = sch.getStartTime();
		
		int count = td.selectSchCount(sqlSession, sch.getDayId());
		TrvSchedule originSch = td.selectTrvSchedule(sqlSession, sch.getSchId());
		int originDayId = originSch.getDayId();
		int originSchNumber = originSch.getSchNumber();
		String originStartTime = originSch.getStartTime();
		ArrayList<TrvSchedule> schList = td.selectSchList(sqlSession, dayId);
		
		if(dayId != originDayId) {	//날짜 변경됐을 때
			ArrayList<TrvSchedule> originSchList = td.selectSchList(sqlSession, originDayId);
			for(int i = 0; i < originSchList.size(); i++) {  //기존day의 schList에서 schNumber 재조정
				if(originSchList.get(i).getSchNumber() > originSchNumber) {
					originSchList.get(i).setSchNumber(originSchList.get(i).getSchNumber() - 1);
					td.updateSchNumber(sqlSession, originSchList.get(i));
				}
			}
			
			if(schList != null) {   //새로운 day의 schList에서 들어갈 자리를 찾기
				if(sch.getIsTimeset() == "N") { //시간정보없음
					sch.setSchNumber(count + 1);
				}else { //시간지정
					int number = selectSchNumber(schList, startTime);
					sch.setSchNumber(number);
				}
			}else {
				sch.setSchNumber(1);
			}
			
		
		}else {	//날짜 그대로일때
			
			if(startTime.equals(originStartTime)) {  //startTime이 그대로일때
				System.out.println("startTime그대로");
				sch.setSchNumber(originSchNumber);
				
			}else {  //startTime이 변했을 때
				System.out.println("startTime바뀜");
				//schList에서 기존의 sch제거, 나머지 sch의 schNumber재조정
				for(int i = 0; i < schList.size(); i++) {
					if(schList.get(i).getSchNumber() == originSchNumber) {
						schList.remove(i);
						System.out.println("removed");
					}
				}
				for(int i = 0; i < schList.size(); i++) {
					if(schList.get(i).getSchNumber() > originSchNumber) {
						schList.get(i).setSchNumber(schList.get(i).getSchNumber() - 1);
						System.out.println(schList.get(i).getSchNumber());
						td.updateSchNumber(sqlSession, schList.get(i));
					}
				}
				
				if(sch.getIsTimeset() == "N") {  //시간정보없음
					sch.setSchNumber(count);
					for(int i = 0; i < schList.size(); i++) {
						result += td.updateSchNumber(sqlSession, schList.get(i));
					}

				}else {  //시간지정
					int number = selectSchNumber(schList, startTime);
					sch.setSchNumber(number);
				}
			}
		}
		
		result += td.updateTrvSchedule(sqlSession, sch);

		int result2 = 0;
		TrvCost originCost = td.selectSchCost(sqlSession, sch.getSchId());
		if(originCost == null) {
			if(cost.getCostAmount() != 0.0) {
				result += td.insertSchCost(sqlSession, cost);
			}
		}else {
			cost.setCostId(originCost.getCostId());
			if(cost.getCostAmount() == 0.0) {
				result += td.deleteTrvCost(sqlSession, cost.getCostId());
			}else {
				result += td.updateTrvCost(sqlSession, cost);
			}
		}
		return result;
	}
	

	@Override
	public ArrayList<TrvCost> selectDayCostList(int dayId) {
		return td.selectDayCostList(sqlSession, dayId);
	}


	@Override
	public int deleteTrvSchedule(int schId) {
		
		TrvSchedule sch = td.selectTrvSchedule(sqlSession, schId);
		int schNumber = sch.getSchNumber();
		int dayId = sch.getDayId();
		
		TrvCost cost = td.selectSchCost(sqlSession, schId);
		
		int result = td.deleteTrvSchedule(sqlSession, schId);
		int result1 = 0;
		ArrayList<TrvSchedule> schList = td.selectSchList(sqlSession, dayId);
		for(int i = 0; i < schList.size(); i++) {
			if(schList.get(i).getSchNumber() > schNumber) {
				schList.get(i).setSchNumber(schList.get(i).getSchNumber() - 1);
				result1 += td.updateSchNumber(sqlSession, schList.get(i));
			}
		}
		return dayId;
	}

	
	
	@Override
	public int updateSchNumber(int dayId, int[] sch) {
		int result = 0;
		ArrayList<TrvSchedule> schList = td.selectSchList(sqlSession, dayId);
		
		for(int i = 0; i < sch.length; i++) {
			for(int j = 0; j < schList.size(); j++) {
				if(schList.get(j).getSchId() == sch[i]) {
					schList.get(j).setSchNumber(i + 1);
					result += td.updateSchNumber(sqlSession, schList.get(j));
					break;
				}
			}
			
			
		}
		
		
		ArrayList<TrvSchedule> updList = td.selectSchList(sqlSession, dayId);
		for(int i = 0; i < updList.size(); i++) {
			System.out.println(updList.get(i));
			String startTime = updList.get(i).getStartTime();
			if(i > 0) {
				if(startTime != null) {
					int hour = Integer.parseInt(startTime.substring(0, startTime.indexOf(":")));
					int minute = Integer.parseInt(startTime.substring(startTime.indexOf(":") + 1));
					int time = hour * 60 + minute;
					String start = updList.get(i - 1).getStartTime();
					if(start != null) {
						int hr = Integer.parseInt(start.substring(0, start.indexOf(":")));
						int min = Integer.parseInt(start.substring(start.indexOf(":") + 1));
						int tm = hr * 60 + min;
						if(time < tm) {
							updList.get(i).setStartTime(null);
							updList.get(i).setEndTime(null);
							System.out.println("startTime, endtime null로 바꿈");
							int result1 = td.deleteSchTime(sqlSession, updList.get(i));
						}
					}
				}
			}
		}
		
		return result;
	}


	@Override
	public int deleteSchNumber(int originDayId, int[] sch) {
		int result = 0;
		ArrayList<TrvSchedule> schList = td.selectSchList(sqlSession, originDayId);
		for(int i = 0; i < sch.length; i++) {
			for(int j = 0; j < schList.size(); j++) {
				if(schList.get(j).getSchId() == sch[i]) {
					schList.get(j).setSchNumber(i + 1);
					result += td.updateSchNumber(sqlSession, schList.get(j));
					break;
				}
			}
		}
				
		return result;
	}

	
	@Override
	public int updateSchDay(TrvSchedule trvSch, int[] sch) {
		
		int result = td.updateSchDay(sqlSession, trvSch);
		
		ArrayList<TrvSchedule> schList = td.selectSchList(sqlSession, trvSch.getDayId());
		
		for(int i = 0; i < sch.length; i++) {
			for(int j = 0; j < schList.size(); j++) {
				if(schList.get(j).getSchId() == sch[i]) {
					schList.get(j).setSchNumber(i + 1);
					result += td.updateSchNumber(sqlSession, schList.get(j));
					break;
				}
			}
		}
		
		ArrayList<TrvSchedule> updList = td.selectSchList(sqlSession, trvSch.getDayId());
		for(int i = 0; i < updList.size(); i++) {
			System.out.println(updList.get(i));
			String startTime = updList.get(i).getStartTime();
			if(i > 0) {
				if(startTime != null) {
					int hour = Integer.parseInt(startTime.substring(0, startTime.indexOf(":")));
					int minute = Integer.parseInt(startTime.substring(startTime.indexOf(":") + 1));
					int time = hour * 60 + minute;
					String start = updList.get(i - 1).getStartTime();
					if(start != null) {
						int hr = Integer.parseInt(start.substring(0, start.indexOf(":")));
						int min = Integer.parseInt(start.substring(start.indexOf(":") + 1));
						int tm = hr * 60 + min;
						if(time < tm) {
							updList.get(i).setStartTime(null);
							updList.get(i).setEndTime(null);
							result += td.deleteSchTime(sqlSession, updList.get(i));
						}
					}
				}
			}
		}
		return result;
	}
	
	
	@Override
	public ArrayList<TrvSchedule> selectSchList(int dayId) {
		 ArrayList<TrvSchedule> schList = td.selectSchList(sqlSession, dayId);
		 for(int i = 0; i < schList.size(); i++) {
			 TrvCost cost = td.selectSchCost(sqlSession, schList.get(i).getSchId());
			 schList.get(i).setTrvCost(cost);
		 }
		 return schList;
	}

	
	
	
	
	@Override
	public int updateDayMemo(TrvDay trvDay) {
		return td.updateTrvDayMemo(sqlSession, trvDay);
	}


	@Override
	public int updateDayWeather(TrvDay trvDay) {
		return td.updateTrvDayWeather(sqlSession, trvDay);
	}

	
	

	
//----------------tag---------------------------------------------------------------	
	@Override
	public int insertTrvTag(TrvTag trvTag) {
		return td.insertTag(sqlSession, trvTag);
	}	

	@Override
	public int deleteTrvTag(TrvTag trvTag) {
		int result = td.deleteTrvTag(sqlSession, trvTag);
		return 0;
	}	
	
	
//------content-----------------------------------------------------------------
	
	
	@Override
	public int updateSchContent(TrvSchedule sch) {
		return td.updateSchContent(sqlSession, sch);
	}

	@Override
	public TrvSchedule selectTrvSchedule(int schId) {
		return td.selectTrvSchedule(sqlSession, schId);
	}

	
	
	@Override
	public int insertSchFile(SchFile schFile) {
		
		int count = td.selectSchFileCount(sqlSession, schFile.getSchId());
		System.out.println("count: " + count);
		if(count == 0) {
			schFile.setFileLevel(0);
		}else {
			schFile.setFileLevel(1);
		}
		int result = td.insertSchFile(sqlSession, schFile);
		int fileId = 0;
		if(result > 0) {
			fileId = td.selectFileId(sqlSession);
			System.out.println("fileId : " + fileId);
		}
		
		return fileId;
	}
	
	@Override
	public SchFile selectSchFile(int fileId) {
		return td.selectSchFile(sqlSession, fileId);
		
	}
	
	
	@Override
	public int updateSchFileId(int fileId) {
		
		SchFile schFile = td.selectSchFile(sqlSession, fileId);
		int schId = schFile.getSchId();
		int result1 = td.updateTrvFileLevel(sqlSession, schId);
		
		int result = td.updateSchFileLevel(sqlSession, fileId);
		
		return result;
	}


	@Override
	public int deleteSchFile(int fileId) {
		int result = td.deleteSchFile(sqlSession, fileId);
		return result;
	}

	
	
//-----------cost--------------------------------------------------------------	
	@Override
	public int updateBudget(Travel trv) {
		return td.updateBudget(sqlSession, trv);
	}


	
	@Override
	public TrvCost selectSchCost(int schId) {
		return td.selectSchCost(sqlSession, schId);
	}
	
	@Override
	public TrvCost selectTrvCost(int costId) {
		return td.selectTrvCost(sqlSession, costId);
	}


	@Override
	public int insertTrvCost(TrvCost cost) {
		int costId = 0;
		int result = td.insertTrvCost(sqlSession, cost);
		if(result > 0) {
			costId = td.selectCostId(sqlSession);
		}
		return costId;
	}

	
	@Override
	public int updateTrvCost(TrvCost cost) {
		return td.updateTrvCost(sqlSession, cost);
	}

	@Override
	public int deleteTrvCost(int costId) {
		int result = td.deleteTrvCost(sqlSession, costId);
		return 0;
	}
	
	
	
//-------------excelDown-------------------------------------------------------------
	@Override
	public void selectDownloadSch(int trvId, HttpServletRequest request, HttpServletResponse response) throws IOException {
		SXSSFWorkbook wb = new SXSSFWorkbook();
		SXSSFSheet sheet = wb.createSheet("schedule");
		for(int i = 0; i <= 7; i++) {
			sheet.trackColumnForAutoSizing(i);
		}
		
		OutputStream fileOut = response.getOutputStream();
		ArrayList<HashMap> schList = td.selectDownloadSch(sqlSession, trvId);
		Map<String, CellStyle> styles = CommonUtils.createStyles(wb);
			
		Row title = sheet.createRow(0);
		title.createCell(0).setCellValue("TITLE : ");
		Cell titleCell = title.createCell(1);
		titleCell.setCellValue(schList.get(0).get("trvTitle").toString());
		titleCell.setCellStyle(styles.get("cell_b"));
		title.createCell(5).setCellValue("AUTHOR : ");
		title.createCell(6).setCellValue(schList.get(0).get("userName").toString());
		Row header = sheet.createRow(2);
		header.setHeightInPoints(20f);
			
		for (int i = 1; i <= 7; i++) {
			Cell cell = header.createCell(i);
	        switch(i) {
	            case 1: cell.setCellValue("DAY");break;
	            case 2: cell.setCellValue("날짜");break;
	            case 3: cell.setCellValue("시작시간");break;
	            case 4: cell.setCellValue("종료시간");break;
	            case 5: cell.setCellValue("일정제목");break;
	            case 6: cell.setCellValue("장소명");break;
	            case 7: cell.setCellValue("교통정보");break;
	        }
	        cell.setCellStyle(styles.get("header"));
	    }
			
		for(int i = 0; i < schList.size(); i++) {
			HashMap schMap = schList.get(i);
			Row row = sheet.createRow(i + 3);
				
			row.createCell(1).setCellValue(schMap.get("dayNumber").toString());
			row.createCell(2).setCellValue(schMap.get("dayDate").toString());
			if(schMap.get("startTime") != null) {
				row.createCell(3).setCellValue(schMap.get("startTime").toString());
			}
			if(schMap.get("endTime") != null) {
				row.createCell(4).setCellValue(schMap.get("endTime").toString());
			}
			row.createCell(5).setCellValue(schMap.get("schTitle").toString());
			if(schMap.get("plcName") != null) {
				row.createCell(6).setCellValue(schMap.get("plcName").toString());
			}
			if(schMap.get("schTransp") != null) {
				row.createCell(7).setCellValue(schMap.get("schTransp").toString());
			}
		}
			
		for(int i = 0; i <= 7; i++) {
			sheet.autoSizeColumn(i);
		}
		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition", 
				String.format("attachment; filename=\"schedule.xlsx\""));
		wb.write(fileOut);
		fileOut.close();
		
	}


	@Override
	public void selectDownloadCost(int trvId, HttpServletRequest request, HttpServletResponse response) throws IOException {
		SXSSFWorkbook wb = new SXSSFWorkbook();
		SXSSFSheet sheet = wb.createSheet("cost");
		for(int i = 0; i <= 6; i++) {
			sheet.trackColumnForAutoSizing(i);
		}
		
		OutputStream fileOut = response.getOutputStream();
		
		ArrayList<HashMap> costList = td.selectDownloadCost(sqlSession, trvId);
		
			
		Map<String, CellStyle> styles = CommonUtils.createStyles(wb);
			
		Row title = sheet.createRow(0);
		title.createCell(0).setCellValue("TITLE : ");
		Cell titleCell = title.createCell(1);
		titleCell.setCellValue(costList.get(0).get("trvTitle").toString());
		titleCell.setCellStyle(styles.get("cell_b"));
		title.createCell(5).setCellValue("AUTHOR : ");
		title.createCell(6).setCellValue(costList.get(0).get("userName").toString());
		Row header = sheet.createRow(2);
			
		header.setHeightInPoints(20f);
			
			
			
		for (int i = 1; i <= 6; i++) {
			Cell cell = header.createCell(i);
	        switch(i) {
	            case 1: cell.setCellValue("DAY");break;
	            case 2: cell.setCellValue("날짜");break;
	            case 3: cell.setCellValue("가계부 항목");break;
	            case 4: cell.setCellValue("경비 타입");break;
	            case 5: cell.setCellValue("금액");break;
	            case 6: cell.setCellValue("통화");break;
	        }
	        cell.setCellStyle(styles.get("header"));
	    }
		
			
		for(int i = 0; i < costList.size(); i++) {
			HashMap costMap = costList.get(i);
			Row row = sheet.createRow(i + 3);
				
			row.createCell(1).setCellValue(costMap.get("dayNumber").toString());
			row.createCell(2).setCellValue(costMap.get("dayDate").toString());
			row.createCell(3).setCellValue(costMap.get("costContent").toString());
			row.createCell(4).setCellValue(costMap.get("costType").toString());
			row.createCell(5).setCellValue(costMap.get("costAmount").toString());
			row.createCell(6).setCellValue(costMap.get("currency").toString());
		}

			
		for(int i = 0; i <= 6; i++) {
			sheet.autoSizeColumn(i);
		}
		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition", String.format("attachment; filename=\"cost.xlsx\""));
		wb.write(fileOut);
		
		fileOut.close();
	}


	
//------------구매일정으로 새 일정 작성-----------------------------------------------------

	@Override
	public int insertOverrideTravel(int trvId, int memberId) {
		
		Travel trv = td.selectTravel(sqlSession, trvId);
		
		Travel overrideTrv = new Travel();
		overrideTrv.setTrvTitle("제목 없음");
		overrideTrv.setStartDate(trv.getStartDate());
		overrideTrv.setEndDate(trv.getEndDate());
		overrideTrv.setCompNumber(1);
		overrideTrv.setBudget(trv.getBudget());
		overrideTrv.setMemberId(memberId);
		overrideTrv.setTrvRef(trvId);
		
		int result = td.insertOverrideTrv(sqlSession, overrideTrv);
		int ovTrvId = td.selectTrvId(sqlSession);
		
		ArrayList<TrvCity> trvCityList = td.selectTrvCityList(sqlSession, trvId);
		for(int i = 0; i < trvCityList.size(); i++) {
			TrvCity trvCity = new TrvCity();
			trvCity.setCityId(trvCityList.get(i).getCityId());
			trvCity.setTrvId(ovTrvId);
			result += td.insertTrvCity(sqlSession, trvCity);
		}
		
		ArrayList<TrvDay> trvDayList = td.selectTrvDayList(sqlSession, trvId);
		for(int i = 0; i < trvDayList.size(); i++) {
			TrvDay trvDay = new TrvDay();
			trvDay.setDayNumber(trvDayList.get(i).getDayNumber());
			trvDay.setDayDate(trvDayList.get(i).getDayDate());
			trvDay.setTrvId(ovTrvId);
			result += td.insertTrvDay(sqlSession, trvDay);
			int dayId = td.selectTrvDayId(sqlSession);
			
			ArrayList<TrvSchedule> schList = td.selectSchList(sqlSession, 
													trvDayList.get(i).getDayId());
			for(int j = 0; j < schList.size(); j++) {
				TrvSchedule sch = schList.get(j);
				sch.setSchContent("");
				sch.setDayId(dayId);
				if(sch.getSchTransp() == null) sch.setSchTransp("");
				if(sch.getPlcId() == null) sch.setPlcId("");
				if(sch.getPlcName() == null) sch.setPlcName("");
				if(sch.getStartTime() == null) sch.setStartTime("");
				if(sch.getEndTime() == null) sch.setEndTime("");
				result += td.insertTrvSchedule(sqlSession, sch);
				int schId = td.selectSchId(sqlSession);
				
				TrvCost cost = td.selectSchCost(sqlSession, schList.get(j).getSchId());
				if(cost != null) {
					cost.setSchId(schId);
					cost.setDayId(dayId);
					result += td.insertSchCost(sqlSession, cost);
				}
			}
			ArrayList<TrvCost> costList = td.selectCostList(sqlSession, 
													trvDayList.get(i).getDayId());
			for(int j = 0; j < costList.size(); j++) {
				TrvCost cost = costList.get(j);
				cost.setDayId(dayId);
				result += td.insertTrvCost(sqlSession, cost);
			}
		}
		ArrayList<TrvTag> trvTagList = td.selectTrvTagList(sqlSession, trvId);
		for(int i = 0; i < trvTagList.size(); i++) {
			TrvTag trvTag = new TrvTag();
			trvTag.setTagId(trvTagList.get(i).getTagId());
			trvTag.setTrvId(ovTrvId);
			result += td.insertTag(sqlSession, trvTag);
		}
		return ovTrvId;
	}

	
	
	
	
	
	
	
	



//-----------------------------------------------------------------------------------	
	
	@Override
	public int insertTrvCompany(TrvCompany trvComp) {
		return td.insertTrvCompany(sqlSession, trvComp);
	}


	@Override
	public Member selectCompany(String email) {
		return td.selectCompany(sqlSession, email);
	}

	
	@Override
	public int deleteTrvComp(TrvCompany trvComp) {
		return td.deleteTrvComp(sqlSession, trvComp);
	}





//----------------------------------------------------------------------------------

	@Override
	public HashMap selectSpotList(Travel trv) {
		HashMap spotMap = null;
		int cityId = 0;
		HashMap hmap = td.selectSpotList(sqlSession, trv, cityId);
		return spotMap;
	}

	@Override
	public ArrayList<Travel> selectSharedTrvList(int memberId) {
		ArrayList<Travel> sharedTrvList = td.selectSharedTrvList(sqlSession, memberId);
		for(int i = 0; i < sharedTrvList.size(); i++) {
			int trvId =	sharedTrvList.get(i).getTrvId();
			ArrayList<TrvCity> trvCityList = td.selectTrvCityList(sqlSession, trvId);
			sharedTrvList.get(i).setTrvCityList(trvCityList);
			ArrayList<TrvTag> trvTagList = td.selectTrvTagList(sqlSession, trvId);
			sharedTrvList.get(i).setTrvTagList(trvTagList);
			SchFile mainImage = td.selectTrvMainImage(sqlSession, trvId);
			sharedTrvList.get(i).setMainImage(mainImage);
		}
		return sharedTrvList;
	}











	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
