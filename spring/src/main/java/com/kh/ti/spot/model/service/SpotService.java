package com.kh.ti.spot.model.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import com.kh.ti.common.PageInfo;
import com.kh.ti.spot.model.vo.AdminSpotList;
import com.kh.ti.spot.model.vo.Likey;
import com.kh.ti.spot.model.vo.SpotFile;
import com.kh.ti.spot.model.vo.SpotList;
import com.kh.ti.spot.model.vo.SpotReviews;
import com.kh.ti.travel.model.vo.City;
import com.kh.ti.travel.model.vo.Country;

public interface SpotService {

	ArrayList<HashMap> selectSpotList(int cityId);

	String insertSpotLikey(Likey likey);

	ArrayList<HashMap> selectMyLikeySpotList(int memberId);

	ArrayList<Country> selectCountryList();

	ArrayList<HashMap> selectCityMap();

	Country selectCountryOneInfo(int cityId);

	ArrayList<SpotFile> selectCityFile(int cityId);

	City selectCityOne(int spotId);

	SpotList selectSpotListOne(int spotId);

	int insertSpotReviews(SpotReviews spotReviews);

	ArrayList<HashMap> selectSpotReviews(int spotId);

	ArrayList<SpotFile> selectSpotFile(int spotId);

	ArrayList<Country> selectCountryList(String condition);

	ArrayList<HashMap> selectCityMap(String condition);

	ArrayList<HashMap> selectConditionSpotFromUser(int countryId);

	String updateSpotReview(SpotReviews spotReviews);

	String deleteSpotReview(int spotReviewId);

	ArrayList<HashMap> selectMyLikeyCountryList(int memberId);

	City selectCity(int cityId);

	int getSpotListCount();

	ArrayList<AdminSpotList> selectAllSpot(PageInfo pi);

	void insertMassiveArticleInBoard(File destFile);

	int updateSpotStatus(ArrayList<Integer> spotIdArr);

	ArrayList<Country> selectCountryListForAdmin();

	ArrayList<City> selectCityListForAdmin();

	int insertSpotList(SpotList spotList);

	int getSpotListCountCity(int cityId);

}
