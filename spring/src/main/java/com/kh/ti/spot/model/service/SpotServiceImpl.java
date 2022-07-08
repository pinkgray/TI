package com.kh.ti.spot.model.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ti.common.PageInfo;
import com.kh.ti.hucloud.utilities.excel.option.ReadOption;
import com.kh.ti.hucloud.utilities.excel.read.ExcelRead;
import com.kh.ti.spot.model.dao.SpotDao;
import com.kh.ti.spot.model.vo.AdminSpotList;
import com.kh.ti.spot.model.vo.Likey;
import com.kh.ti.spot.model.vo.SpotFile;
import com.kh.ti.spot.model.vo.SpotList;
import com.kh.ti.spot.model.vo.SpotReviews;
import com.kh.ti.travel.model.vo.City;
import com.kh.ti.travel.model.vo.Country;

@Service
public class SpotServiceImpl implements SpotService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private SpotDao sd;


	//도시 상세보기용 - 세령
	@Override
	public ArrayList<HashMap> selectSpotList(int cityId) {
		return sd.selectSpotList(sqlSession, cityId);
	}
	
	//명소 좋아요 추가용 - 세령
	@Override
	public String insertSpotLikey(Likey likey) {
		Likey userLikey = sd.selectLikey(sqlSession, likey);
		int result = 0;
		String msg = "";
		if(userLikey != null) { //만약 존재 한다면?
			result = sd.deleteSpotLikey(sqlSession, likey);
			
			if(result > 0) {
				msg = "좋아요 리스트에서 명소를 삭제했습니다.";
			} else {
				msg = "좋아요 리스트에서 명소를 삭제 하는데  실패했습니다.";
			}
			
		} else { //존재 하지 않는다면?
			result = sd.insertSpotLikey(sqlSession, likey);
			
			if (result > 0) {
				msg = "좋아요 리스트에 명소를 추가했습니다.";
			} else {
				msg = "좋아요 리스트에 명소를 추가 하는데 실패했습니다.";
			} //end if
			
		} //end if
		
		return msg;
	}
	
	//-----------------------------

	//여행지의 국가명만 조회 - 세령
	@Override
	public ArrayList<Country> selectCountryList() {
		return sd.selectCountryList(sqlSession);
	}

	//여행지의 도시정보 조회(전체) - 세령
	@Override
	public ArrayList<HashMap> selectCityMap() {
		return sd.selectCityMap(sqlSession);
	}

	//CITY ID로 도시정보 조회 - 세령
	@Override
	public Country selectCountryOneInfo(int cityId) {
		return sd.selectCountryOneInfo(sqlSession, cityId);
	}

	//CITY ID로 도시 사진 조회 - 세령
	@Override
	public ArrayList<SpotFile> selectCityFile(int cityId) {
		return sd.selectCityFile(sqlSession, cityId);
	}

	//spot id로 city 조회 - 세령
	@Override
	public City selectCityOne(int spotId) {
		return sd.selectCityOne(sqlSession, spotId);
	}

	//spot info 조회 - 세령
	@Override
	public SpotList selectSpotListOne(int spotId) {
		return sd.selectSpotListOne(sqlSession, spotId);
	}

	//명소 리뷰 등록 - 세령
	@Override
	public int insertSpotReviews(SpotReviews spotReviews) {
		int result = sd.insertSpotReviews(sqlSession, spotReviews);
		int spotReviewIdCurrval = 0;
		if(result > 0) {
			spotReviewIdCurrval = sd.getSpotReviewIdCurrval(sqlSession);
		}
		return spotReviewIdCurrval;
	}

	//명소 리뷰 조회 - 세령
	@Override
	public ArrayList<HashMap> selectSpotReviews(int spotId) {
		return sd.selectSpotReviews(sqlSession, spotId);
	}

	//명소 사진 조회 - 세령
	@Override
	public ArrayList<SpotFile> selectSpotFile(int spotId) {
		return sd.selectSpotFile(sqlSession, spotId);
	}

	//대륙명으로 국가 조회 - 세령
	@Override
	public ArrayList<Country> selectCountryList(String condition) {
		return sd.selectCountryList(sqlSession, condition);
	}

	//대륙명으로 도시 조회 - 세령
	@Override
	public ArrayList<HashMap> selectCityMap(String condition) {
		return sd.selectCityMap(sqlSession, condition);
	}

	//국가 아이디로 도시 조회 - 세령
	@Override
	public ArrayList<HashMap> selectConditionSpotFromUser(int countryId) {
		return sd.selectConditionSpotFromUser(sqlSession, countryId);
	}

	//명소 리뷰 수정용 - 세령
	@Override
	public String updateSpotReview(SpotReviews spotReviews) {
		String msg = "";
		int result = sd.updateSpotReview(sqlSession, spotReviews);
		if(result > 0) {
			msg = "리뷰가 수정되었습니다.";
		} else {
			msg = "리뷰 수정에 실패했습니다.";
		}
		return msg;
	}

	//명소 리뷰 삭제용 - 세령
	@Override
	public String deleteSpotReview(int spotReviewId) {
		String msg = "";
		int result = sd.deleteSpotReview(sqlSession, spotReviewId);
		if(result > 0) {
			msg = "리뷰가 삭제되었습니다.";
		} else {
			msg = "리뷰 삭제에 실패했습니다.";
		}
		return msg;
	}
	
	//마이페이지 명소 좋아요 조회용 - 세령
	@Override
	public ArrayList<HashMap> selectMyLikeySpotList(int memberId) {
		return sd.selectMyLikeySpotList(sqlSession, memberId);
	}

	//마이페이지 명소 좋아요(국가/도시)조회용 - 세령
	@Override
	public ArrayList<HashMap> selectMyLikeyCountryList(int memberId) {
		return sd.selectMyLikeyCountryList(sqlSession, memberId);
	}

	//city 정보 조회용 - 세령
	@Override
	public City selectCity(int cityId) {
		return sd.selectCity(sqlSession, cityId);
	}

	//여행지 리스트 수 조회 - 세령
	@Override
	public int getSpotListCount() {
		return sd.getSpotListCount(sqlSession);
	}

	//여행지 명소 리스트 조회 - 세령
	@Override
	public ArrayList<AdminSpotList> selectAllSpot(PageInfo pi) {
		return sd.selectAllSpot(sqlSession, pi);
	}

	//엑셀로 여행지 추가 - 세령
	@Override
	public void insertMassiveArticleInBoard(File destFile) {
		  ReadOption readOption = new ReadOption();
		  readOption.setFilePath(destFile.getAbsolutePath());
		  readOption.setOutputColumns("A","B","C","D", "E", "F", "G", 
				  					  "F", "H", "I", "M", "N", "O", "P", "Q");
		  readOption.setStartRow(2);
		  
		  List<Map<String, String>> excelContent = ExcelRead.read(readOption);
		  
		  SpotList spot = null;
		  for(Map<String, String> article : excelContent){
			  spot = new SpotList();
			  
			  int spotId = Integer.parseInt(article.get("A"));
			  spot.setSpotId(spotId);
			  spot.setSpotNameKo(article.get("B"));
			  spot.setSpotNameEn(article.get("C"));
			  spot.setSpotContent(article.get("D"));
			  spot.setSpotAddress(article.get("E"));
			  spot.setOpeningHours(article.get("F"));
			  spot.setSpotPhone(article.get("G"));
			  spot.setWebAddress(article.get("H"));
			  int cityId = Integer.parseInt(article.get("N"));
			  spot.setCityId(cityId);
			  int plyTypeId = Integer.parseInt(article.get("P"));
			  spot.setPlcTypeId(plyTypeId);
			  spot.setFilePath(article.get("Q"));

		      this.insertSpotList(spot);
			  
			  //데이터를 추가하는 아이를 만들면 됨
		  }
	}

	//관리자 여행지 삭제용 - 세령
	@Override
	public int updateSpotStatus(ArrayList<Integer> spotIdArr) {
		int result = 0;
		for(int i = 0; i < spotIdArr.size(); i++) {
			result += sd.updateSpotStatus(sqlSession, spotIdArr.get(i));
		}
		return result;
	}

	//관리자 여행지 국가 조회용 - 세령
	@Override
	public ArrayList<Country> selectCountryListForAdmin() {
		return sd.selectCountryListForAdmin(sqlSession);
	}

	//관리자 여행지 도시 조회용  - 세령
	@Override
	public ArrayList<City> selectCityListForAdmin() {
		return sd.selectCityListForAdmin(sqlSession);
	}

	//관리자 여행지 등록용 - 세령
	@Override
	public int insertSpotList(SpotList spotList) {
		int result = sd.insertSpotList(sqlSession, spotList);
		int resultFile = 0;
		if(result > 0) {
			int spotCurrval = sd.getSpotCurrval(sqlSession);
			spotList.setSpotId(spotCurrval);
			resultFile = sd.insertSpotFile(sqlSession, spotList);
		}
		return resultFile;
	}

	//도시의 명소 수 조회용 - 세령
	@Override
	public int getSpotListCountCity(int cityId) {
		return sd.getSpotListCount(sqlSession, cityId);
	}

}
