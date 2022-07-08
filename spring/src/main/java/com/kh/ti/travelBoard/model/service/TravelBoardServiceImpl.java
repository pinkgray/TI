package com.kh.ti.travelBoard.model.service;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ti.common.CommonUtils;
import com.kh.ti.common.PageInfo;
import com.kh.ti.point.model.vo.UsePoint;
import com.kh.ti.travel.model.vo.SchFile;
import com.kh.ti.travelBoard.model.dao.TravelBoardDao;
import com.kh.ti.travelBoard.model.vo.Likey;
import com.kh.ti.travelBoard.model.vo.TourReview;
import com.kh.ti.travelBoard.model.vo.TravelBoard;
import com.kh.ti.travelBoard.model.vo.TrvBoardSch;
import com.kh.ti.travelBoard.model.vo.TrvDaySchedule;

@Service
public class TravelBoardServiceImpl implements TravelBoardService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private TravelBoardDao tbd;
	
	//페이징 처리용 - 예랑
	@Override
	public int getListCount(HashMap pageMap) {
		
		return tbd.getListCount(sqlSession, pageMap);
	}
	
	//여행일정 리스트 조회 - 예랑
	@Override
	public HashMap travelList(PageInfo pi, TravelBoard tb) {
		
		return tbd.travelList(sqlSession, pi, tb);
	}
	
	//여행일정 상세 조회 - 예랑
	@Override
	public HashMap travelDetailForm(TravelBoard tb) {
		
		return tbd.travelDetailForm(sqlSession, tb);
	}
	
	//여행일정 삭제 - 예랑
	@Override
	public int travelDelete(int trvId) {
		
		return tbd.travelDelete(sqlSession, trvId);
	}
	
	//여행일정 좋아요 - 예랑
	@Override
	public int travelLikeyInsert(Likey likey) {
		
		return tbd.travelLikeyInsert(sqlSession, likey);
	}
	
	//여행일정 좋아요 취소 - 예랑
	@Override
	public int travelLikeyDelete(Likey likey) {
		
		return tbd.travelLikeyDelete(sqlSession, likey);
	}
	
	//여행일정 일자별 스케쥴 조회용
	@Override
	public ArrayList selectTravelDetailDays(TravelBoard tb) {
		
		return tbd.selectTravelDetailDays(sqlSession, tb);
	}
	
	//여행일정 구매리뷰 조회용
	@Override
	public ArrayList<TourReview> tourReviewList(PageInfo pi, TourReview tr) {
		
		return tbd.tourReviewList(sqlSession, pi, tr);
	}
	
	//여행일정 상세 / 리뷰 작성 - 예랑
	@Override
	public int insertReview(TourReview tr) {
		
		return tbd.insertReview(sqlSession, tr);
	}

	//자신이 작성한 여행일정 리뷰 검색
	@Override
	public TourReview myTourReviewSearch(TourReview tr) {
		
		return tbd.myTourReviewSearch(sqlSession, tr);
	}
	
	//자신이 작성한 여행일정 리뷰 수정
	@Override
	public int myTourReviewUpdate(TourReview tr) {
		
		return tbd.myTourReviewUpdate(sqlSession, tr);
	}
	
	//여행일정 상세 / 리뷰 삭제 - 예랑
	@Override
	public int deliteReview(TourReview tr) {
		
		return tbd.deliteReview(sqlSession, tr);
	}
	
	//여행일정 상세 / 가계부 조회 - 예랑
	@Override
	public HashMap selectTravelCost(int trvId) {
		
		return tbd.selectTravelCost(sqlSession, trvId);
	}
	
	//마이페이지 / 구매한 일정 보기 - 예랑
	@Override
	public HashMap myBuyTravelListView(int memberId) {
		
		return tbd.myBuyTravelListView(sqlSession, memberId);
	}
	
	//마이페이지 / 좋아요 / 여행일정 좋아요 보기 - 예랑
	@Override
	public HashMap myLikeyTravelListView(int memberId) {
		
		return tbd.myLikeyTravelListView(sqlSession, memberId);
	}
	
	//여행상세일정 조회
	@Override
	public TrvBoardSch selectSchContent(int schId) {
		
		return tbd.selectSchContent(sqlSession, schId);
	}
	
	//여행일정 상세 / 날짜별 갤러리 보기 - 예랑
	@Override
	public ArrayList travelDetailGallery(TrvDaySchedule sch) {
		
		return tbd.travelDetailGallery(sqlSession, sch);
	}
	
	//마이페이지 / 좋아요, 구매수 카운트 조회 - 예랑
	@Override
	public TravelBoard selectMyCount(int memberId) {
		
		return tbd.selectMyCount(sqlSession, memberId);
	}
	
	//여행일정 상세 / 가계부 / 가계부 다운로드 - 예랑
	@Override
	public void costDownload(int trvId, HttpServletRequest request, HttpServletResponse response) throws IOException {
		SXSSFWorkbook wb = new SXSSFWorkbook();
		SXSSFSheet sheet = wb.createSheet("cost");
		for(int i = 0; i <= 6; i++) {
			sheet.trackColumnForAutoSizing(i);
		}
		
		OutputStream fileOut = response.getOutputStream();
		
		ArrayList<HashMap> costList = tbd.costDownload(sqlSession, trvId);
		
			
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
		

}
