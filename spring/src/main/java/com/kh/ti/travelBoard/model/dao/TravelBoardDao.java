package com.kh.ti.travelBoard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.ti.common.PageInfo;
import com.kh.ti.point.model.vo.UsePoint;
import com.kh.ti.travel.model.vo.SchFile;
import com.kh.ti.travelBoard.model.vo.Likey;
import com.kh.ti.travelBoard.model.vo.TourReview;
import com.kh.ti.travelBoard.model.vo.TravelBoard;
import com.kh.ti.travelBoard.model.vo.TrvBoardSch;
import com.kh.ti.travelBoard.model.vo.TrvDaySchedule;

public interface TravelBoardDao {

	int getListCount(SqlSessionTemplate sqlSession, HashMap pageMap);
	
	HashMap travelList(SqlSessionTemplate sqlSession, PageInfo pi, TravelBoard tb);

	HashMap travelDetailForm(SqlSessionTemplate sqlSession, TravelBoard tb);

	int travelDelete(SqlSessionTemplate sqlSession, int trvId);

	int travelLikeyInsert(SqlSessionTemplate sqlSession, Likey likey);

	int travelLikeyDelete(SqlSessionTemplate sqlSession, Likey likey);

	ArrayList selectTravelDetailDays(SqlSessionTemplate sqlSession, TravelBoard tb);

	ArrayList<TourReview> tourReviewList(SqlSessionTemplate sqlSession, PageInfo pi, TourReview tr);

	int insertReview(SqlSessionTemplate sqlSession, TourReview tr);

	TourReview myTourReviewSearch(SqlSessionTemplate sqlSession, TourReview tr);

	int myTourReviewUpdate(SqlSessionTemplate sqlSession, TourReview tr);

	int deliteReview(SqlSessionTemplate sqlSession, TourReview tr);

	HashMap selectTravelCost(SqlSessionTemplate sqlSession, int trvId);

	HashMap myBuyTravelListView(SqlSessionTemplate sqlSession, int memberId);

	HashMap myLikeyTravelListView(SqlSessionTemplate sqlSession, int memberId);

	TrvBoardSch selectSchContent(SqlSessionTemplate sqlSession, int schId);

	ArrayList travelDetailGallery(SqlSessionTemplate sqlSession, TrvDaySchedule sch);

	TravelBoard selectMyCount(SqlSessionTemplate sqlSession, int memberId);

	ArrayList<HashMap> costDownload(SqlSessionTemplate sqlSession, int trvId);


}
