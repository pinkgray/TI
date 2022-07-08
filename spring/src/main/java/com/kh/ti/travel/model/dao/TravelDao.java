package com.kh.ti.travel.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.ti.member.model.vo.Member;
import com.kh.ti.spot.model.vo.SpotList;
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

public interface TravelDao {

	ArrayList<Travel> selectTrvList(SqlSessionTemplate sqlSession, int memberId);
	
	int insertTravel(SqlSessionTemplate sqlSession, Travel trv);

	int insertTrvCity(SqlSessionTemplate sqlSession, TrvCity trvCity);
	
	City selectCity(SqlSessionTemplate sqlSession, int cityId);

	int selectTrvId(SqlSessionTemplate sqlSession);

	int insertTrvDay(SqlSessionTemplate sqlSession, TrvDay trvDay);
	
	Travel selectTravel(SqlSessionTemplate sqlSession, int trvId);

	ArrayList<TrvCity> selectTrvCityList(SqlSessionTemplate sqlSession, int trvId);

	ArrayList<TrvDay> selectTrvDayList(SqlSessionTemplate sqlSession, int trvId);

	
	ArrayList<Country> selectCountryList(SqlSessionTemplate sqlSession);
	
	ArrayList<City> selectCityList(SqlSessionTemplate sqlSession, int countryId);
	
	ArrayList<Tag> selectTagList(SqlSessionTemplate sqlSession);
	
	int updateTravel(SqlSessionTemplate sqlSession, Travel trv);
	
	int deleteTrvCity(SqlSessionTemplate sqlSession, TrvCity trvCity);
	
	int updateTrvDay(SqlSessionTemplate sqlSession, TrvDay trvDay);
	
	int deleteTrvDay(SqlSessionTemplate sqlSession, TrvDay trvDay);

	int completeTravel(SqlSessionTemplate sqlSession, int trvId);
	
	int deleteTravel(SqlSessionTemplate sqlSession, int trvId);

	int selectSchCount(SqlSessionTemplate sqlSession, int dayId);

	ArrayList<TrvCost> selectCostList(SqlSessionTemplate sqlSession, int dayId);
	
	ArrayList<TrvSchedule> selectSchList(SqlSessionTemplate sqlSession, int dayId);

	int insertTrvSchedule(SqlSessionTemplate sqlSession, TrvSchedule sch);	

	int selectDayNumber(SqlSessionTemplate sqlSession, int dayId);
	
	int selectSchId(SqlSessionTemplate sqlSession);

	int updateSchNumber(SqlSessionTemplate sqlSession, TrvSchedule sch);
	
	int insertSchCost(SqlSessionTemplate sqlSession, TrvCost cost);
	
	TrvCost selectSchCost(SqlSessionTemplate sqlSession, int schId);

	int updateTrvCost(SqlSessionTemplate sqlSession, TrvCost cost);

	int deleteTrvCost(SqlSessionTemplate sqlSession, int costId);

	TrvSchedule selectTrvSchedule(SqlSessionTemplate sqlSession, int schId);

	int updateTrvSchedule(SqlSessionTemplate sqlSession, TrvSchedule sch);

	ArrayList<TrvCost> selectDayCostList(SqlSessionTemplate sqlSession, int dayId);
	
	int deleteSchTime(SqlSessionTemplate sqlSession, TrvSchedule sch);

	int updateSchDay(SqlSessionTemplate sqlSession, TrvSchedule sch);
	
	int deleteTrvSchedule(SqlSessionTemplate sqlSession, int schId);

	int updateTrvDayMemo(SqlSessionTemplate sqlSession, TrvDay trvDay);

	int updateTrvDayWeather(SqlSessionTemplate sqlSession, TrvDay trvDay);

	
	

	int insertTag(SqlSessionTemplate sqlSession, TrvTag trvTag);	

	int deleteTrvTag(SqlSessionTemplate sqlSession, TrvTag trvTag);	

	ArrayList<TrvTag> selectTrvTagList(SqlSessionTemplate sqlSession, int trvId);
	
	
	

	int updateSchContent(SqlSessionTemplate sqlSession, TrvSchedule sch);

	int selectSchFileCount(SqlSessionTemplate sqlSession, int schId);

	int insertSchFile(SqlSessionTemplate sqlSession, SchFile schFile);

	int selectFileId(SqlSessionTemplate sqlSession);

	SchFile selectSchFile(SqlSessionTemplate sqlSession, int fileId);

	ArrayList<SchFile> selectSchFileList(SqlSessionTemplate sqlSession, int schId);	

	int updateTrvFileLevel(SqlSessionTemplate sqlSession, int schId);

	int updateSchFileLevel(SqlSessionTemplate sqlSession, int fileId);

	int deleteSchFile(SqlSessionTemplate sqlSession, int fileId);
	
	SchFile selectTrvMainImage(SqlSessionTemplate sqlSession, int trvId);



	
	
	

	int updateBudget(SqlSessionTemplate sqlSession, Travel trv);

	int insertTrvCost(SqlSessionTemplate sqlSession, TrvCost cost);

	int selectCostId(SqlSessionTemplate sqlSession);	
	
	TrvCost selectTrvCost(SqlSessionTemplate sqlSession, int costId);

	
	
	
	
	


	HashMap selectSpotList(SqlSessionTemplate sqlSession, Travel trv, int cityCode);


	
	
	
	ArrayList<HashMap> selectDownloadSch(SqlSessionTemplate sqlSession, int trvId);

	ArrayList<HashMap> selectDownloadCost(SqlSessionTemplate sqlSession, int trvId);

	int insertOverrideTrv(SqlSessionTemplate sqlSession, Travel overrideTrv);

	int selectTrvDayId(SqlSessionTemplate sqlSession);

	Member selectCompany(SqlSessionTemplate sqlSession, String email);
	
	int insertTrvCompany(SqlSessionTemplate sqlSession, TrvCompany trvComp);

	ArrayList<TrvCompany> selectTrvCompList(SqlSessionTemplate sqlSession, int trvId);


	int deleteTrvComp(SqlSessionTemplate sqlSession, TrvCompany trvComp);

	ArrayList<Travel> selectSharedTrvList(SqlSessionTemplate sqlSession, int memberId);

	int selectPublicTrvCount(SqlSessionTemplate sqlSession, int memberId);

	ArrayList<HashMap> selectLikeySpotList(SqlSessionTemplate sqlSession, Travel trv);

	ArrayList<HashMap> selectRecommSpotList(SqlSessionTemplate sqlSession, Travel trv);




































}
