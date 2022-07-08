package com.kh.ti.spot.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.common.PageInfo;
import com.kh.ti.spot.model.vo.AdminSpotList;
import com.kh.ti.spot.model.vo.Likey;
import com.kh.ti.spot.model.vo.SpotFile;
import com.kh.ti.spot.model.vo.SpotList;
import com.kh.ti.spot.model.vo.SpotReviews;
import com.kh.ti.travel.model.vo.City;
import com.kh.ti.travel.model.vo.Country;

@Repository
public class SpotDaoImpl implements SpotDao {

	//도시 상세보기용 - 세령
	@Override
	public ArrayList<HashMap> selectSpotList(SqlSessionTemplate sqlSession, int cityId) {
		ArrayList<HashMap> spotList = null;
		spotList = (ArrayList) sqlSession.selectList("Spot.selectSpotList", cityId);
		return spotList;
	}

	//명소 좋아요 추가용 - 세령
	@Override
	public int insertSpotLikey(SqlSessionTemplate sqlSession, Likey likey) {
		return sqlSession.insert("Spot.insertSpotLikey", likey);
	}

	//--------------------
	//여행지의 국가명만 조회용 - 세령
	@Override
	public ArrayList<Country> selectCountryList(SqlSessionTemplate sqlSession) {
		ArrayList<Country> countryList = (ArrayList) sqlSession.selectList("Spot.selectCountryList");
		return countryList;
	}

	//여행도시(파일과 함께) 조회 - 세령
	@Override
	public ArrayList<HashMap> selectCityMap(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("Spot.selectCityMap");
	}

	//CITY ID로 도시정보 조회 - 세령
	@Override
	public Country selectCountryOneInfo(SqlSessionTemplate sqlSession, int cityId) {
		return sqlSession.selectOne("Spot.selectCountryOneInfo", cityId);
	}

	//CITY ID로 도시 사진 조회 - 세령
	@Override
	public ArrayList<SpotFile> selectCityFile(SqlSessionTemplate sqlSession, int cityId) {
		return (ArrayList) sqlSession.selectList("Spot.selectCityFile", cityId);
	}

	//spot id로 city 조회 - 세령
	@Override
	public City selectCityOne(SqlSessionTemplate sqlSession, int spotId) {
		return sqlSession.selectOne("Spot.selectCityOne", spotId);
	}
	
	//spot info 조회 - 세령
	@Override
	public SpotList selectSpotListOne(SqlSessionTemplate sqlSession, int spotId) {
		return sqlSession.selectOne("Spot.selectSpotListOne", spotId);
	}

	//명소 리뷰 등록 - 세령
	@Override
	public int insertSpotReviews(SqlSessionTemplate sqlSession, SpotReviews spotReviews) {
		return sqlSession.insert("Spot.insertSpotReviews", spotReviews);
	}

	//명소 리뷰 조회 - 세령
	@Override
	public ArrayList<HashMap> selectSpotReviews(SqlSessionTemplate sqlSession, int spotId) {
		return (ArrayList) sqlSession.selectList("Spot.selectSpotReviews", spotId);
	}

	//리뷰 등록(spot reviews) 현재 시퀀스 조회 - 세령
	@Override
	public int getSpotReviewIdCurrval(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Spot.spotReviewSeqCurrval");
	}

	//명소 사진 조회 - 세령
	@Override
	public ArrayList<SpotFile> selectSpotFile(SqlSessionTemplate sqlSession, int spotId) {
		return (ArrayList) sqlSession.selectList("Spot.selectSpotFile", spotId);
	}

	//대륙명으로 도시 조회 - 세령
	@Override
	public ArrayList<HashMap> selectCityMap(SqlSessionTemplate sqlSession, String condition) {
		return (ArrayList) sqlSession.selectList("Spot.selectCityMap", condition);
	}

	//대륙명으로 국가 조회 - 세령
	@Override
	public ArrayList<Country> selectCountryList(SqlSessionTemplate sqlSession, String condition) {
		return (ArrayList) sqlSession.selectList("Spot.selectCountryList", condition);
	}

	//국가 아이디로 도시 조회 - 세령
	@Override
	public ArrayList<HashMap> selectConditionSpotFromUser(SqlSessionTemplate sqlSession, int countryId) {
		return (ArrayList) sqlSession.selectList("Spot.selectConditionSpotFromUser", countryId);
	}

	//사용자의 좋아요 명소 조회 - 세령
	@Override
	public Likey selectLikey(SqlSessionTemplate sqlSession, Likey likey) {
		return sqlSession.selectOne("Spot.selectUserLikey", likey);
	}

	//사용자의 좋아요 명소 삭제 - 세령
	@Override
	public int deleteSpotLikey(SqlSessionTemplate sqlSession, Likey likey) {
		return sqlSession.delete("Spot.deleteSpotLikey", likey);
	}

	//명소 리뷰 수정용 - 세령
	@Override
	public int updateSpotReview(SqlSessionTemplate sqlSession, SpotReviews spotReviews) {
		return sqlSession.update("Spot.updateSpotReviews", spotReviews);
	}

	//명소 리뷰 삭제용 - 세령
	@Override
	public int deleteSpotReview(SqlSessionTemplate sqlSession, int spotReviewId) {
		return sqlSession.delete("Spot.deleteSpotReviews", spotReviewId);
	}

	//마이페이지 명조 좋아요 조회용 - 세령
	@Override
	public ArrayList<HashMap> selectMyLikeySpotList(SqlSessionTemplate sqlSession, int memberId) {
		return (ArrayList) sqlSession.selectList("Spot.selectMyLikeySpotList", memberId);
	}

	//마이페이지 명소 좋아요(국가/도시)조회용 - 세령
	@Override
	public ArrayList<HashMap> selectMyLikeyCountryList(SqlSessionTemplate sqlSession, int memberId) {
		return (ArrayList) sqlSession.selectList("Spot.selectMyListCountryList", memberId);
	}

	//city 정보 조회용 - 세령
	@Override
	public City selectCity(SqlSessionTemplate sqlSession, int cityId) {
		return sqlSession.selectOne("Spot.selectCity", cityId);
	}
 
	//명소 리스트 수  조회 - 세령
	@Override
	public int getSpotListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Spot.selectListCount");
	}

	//명소 리스트 조회 - 세령
	@Override
	public ArrayList<AdminSpotList> selectAllSpot(SqlSessionTemplate sqlSession, PageInfo pi) {
		ArrayList<AdminSpotList> spotList = null;
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		spotList = (ArrayList) sqlSession.selectList("Spot.selectAllSpotList", null, rowBounds);
		return spotList;
	}

	//관리자 여행지 삭제용 - 세령
	@Override
	public int updateSpotStatus(SqlSessionTemplate sqlSession, int spotId) {
		return sqlSession.update("Spot.updateSpotStatusN", spotId);
	}

	//관리자 여행지 국가 조회용 - 세령
	@Override
	public ArrayList<Country> selectCountryListForAdmin(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("Spot.selectCountryListFroAdmin");
	}

	//관리자 여행지 도시 조회용 - 세령
	@Override
	public ArrayList<City> selectCityListForAdmin(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("Spot.selectCityListForAdmin");
	}

	//관리자 여행지 등록용 - 세령
	@Override
	public int insertSpotList(SqlSessionTemplate sqlSession, SpotList spotList) {
		return sqlSession.insert("Spot.insertSpot", spotList);
	}

	//관리자 명소 사진 등록용 - 세령
	@Override
	public int insertSpotFile(SqlSessionTemplate sqlSession, SpotList spotList) {
		return sqlSession.insert("Spot.insertSpotFile", spotList);
	}

	//spot_id 현재 시퀀스 조회 용 - 세령
	@Override
	public int getSpotCurrval(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Spot.getSpotCurrval");
	}

	//도시의 명소 수 조회용 - 세령
	@Override
	public int getSpotListCount(SqlSessionTemplate sqlSession, int cityId) {
		return sqlSession.selectOne("Spot.selectListCount", cityId);
	}

}
