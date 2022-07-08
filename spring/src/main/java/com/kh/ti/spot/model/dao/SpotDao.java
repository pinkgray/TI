package com.kh.ti.spot.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.ti.common.PageInfo;
import com.kh.ti.spot.model.vo.AdminSpotList;
import com.kh.ti.spot.model.vo.Likey;
import com.kh.ti.spot.model.vo.SpotFile;
import com.kh.ti.spot.model.vo.SpotList;
import com.kh.ti.spot.model.vo.SpotReviews;
import com.kh.ti.travel.model.vo.City;
import com.kh.ti.travel.model.vo.Country;

public interface SpotDao {

	ArrayList<HashMap> selectSpotList(SqlSessionTemplate sqlSession, int cityId);

	int insertSpotLikey(SqlSessionTemplate sqlSession, Likey likey);

	ArrayList<HashMap> selectMyLikeySpotList(SqlSessionTemplate sqlSession, int memberId);

	ArrayList<Country> selectCountryList(SqlSessionTemplate sqlSession);

	ArrayList<HashMap> selectCityMap(SqlSessionTemplate sqlSession);

	Country selectCountryOneInfo(SqlSessionTemplate sqlSession, int cityId);

	ArrayList<SpotFile> selectCityFile(SqlSessionTemplate sqlSession, int cityId);

	City selectCityOne(SqlSessionTemplate sqlSession, int spotId);

	SpotList selectSpotListOne(SqlSessionTemplate sqlSession, int spotId);

	int insertSpotReviews(SqlSessionTemplate sqlSession, SpotReviews spotReviews);

	ArrayList<HashMap> selectSpotReviews(SqlSessionTemplate sqlSession, int spotId);

	int getSpotReviewIdCurrval(SqlSessionTemplate sqlSession);

	ArrayList<SpotFile> selectSpotFile(SqlSessionTemplate sqlSession, int spotId);

	ArrayList<HashMap> selectCityMap(SqlSessionTemplate sqlSession, String condition);

	ArrayList<Country> selectCountryList(SqlSessionTemplate sqlSession, String condition);

	ArrayList<HashMap> selectConditionSpotFromUser(SqlSessionTemplate sqlSession, int countryId);

	Likey selectLikey(SqlSessionTemplate sqlSession, Likey likey);

	int deleteSpotLikey(SqlSessionTemplate sqlSession, Likey likey);

	int updateSpotReview(SqlSessionTemplate sqlSession, SpotReviews spotReviews);

	int deleteSpotReview(SqlSessionTemplate sqlSession, int spotReviewId);

	ArrayList<HashMap> selectMyLikeyCountryList(SqlSessionTemplate sqlSession, int memberId);

	City selectCity(SqlSessionTemplate sqlSession, int cityId);

	int getSpotListCount(SqlSessionTemplate sqlSession);

	ArrayList<AdminSpotList> selectAllSpot(SqlSessionTemplate sqlSession, PageInfo pi);

	int updateSpotStatus(SqlSessionTemplate sqlSession, int spotId);

	ArrayList<Country> selectCountryListForAdmin(SqlSessionTemplate sqlSession);

	ArrayList<City> selectCityListForAdmin(SqlSessionTemplate sqlSession);

	int insertSpotList(SqlSessionTemplate sqlSession, SpotList spotList);

	int insertSpotFile(SqlSessionTemplate sqlSession, SpotList spotList);

	int getSpotCurrval(SqlSessionTemplate sqlSession);

	int getSpotListCount(SqlSessionTemplate sqlSession, int cityId);


}
