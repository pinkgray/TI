package com.kh.ti.point.model.service;

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
import com.kh.ti.point.model.dao.PointDao;
import com.kh.ti.point.model.vo.Payment;
import com.kh.ti.point.model.vo.Proceeds;
import com.kh.ti.point.model.vo.Rebate;
import com.kh.ti.point.model.vo.Refund;
import com.kh.ti.point.model.vo.ReservePoint;
import com.kh.ti.point.model.vo.SearchPoint;
import com.kh.ti.point.model.vo.UsePoint;

@Service
public class PointServiceImpl implements PointService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private PointDao pd;

	// 포인트 충전
	@Override
	public int insertPay(Payment pay) {
		return pd.insertPay(sqlSession, pay);
	}

	// 포인트 충전 리스트 전체 카운터
	@Override
	public int getChargeListCount(Payment charge) {
		return pd.getChargeListCount(sqlSession, charge);
	}

	// 포인트 지급 리스트 전체 카운터
	@Override
	public int getReceiveListCount(ReservePoint reserve) {
		return pd.getReceiveListCount(sqlSession, reserve);
	}

	// 포인트 사용 리스트 전체 카운터
	@Override
	public int getUseListCount(UsePoint use) {
		return pd.getUseListCount(sqlSession, use);
	}

	// 포인트 충전리스트 전체 조회
	@Override
	public ArrayList selectChargeList(PageInfo chPi, Payment charge) {
		return pd.selectChargeList(sqlSession, chPi, charge);
	}

	// 포인트 지급리스트 전체 조회
	@Override
	public ArrayList<ReservePoint> selectReceiveList(PageInfo rePi, ReservePoint reserve) {
		return pd.selectReceiveList(sqlSession, rePi, reserve);
	}

	// 포인트 사용리스트 전체 조회
	@Override
	public ArrayList<UsePoint> selectUseList(PageInfo usPi, UsePoint use) {
		return pd.selectUseList(sqlSession, usPi, use);
	}

	// 포인트 자동으로 적립하기
	@Override
	public int insertReservePoint(ReservePoint rp) {
		return pd.insertReservePoint(sqlSession, rp);
	}

	// 성공시 멤버 누적포인트 증가
	@Override
	public int updateUserPointAuto(ReservePoint rp) {
		return pd.updateUserPointAuto(sqlSession, rp);
	}

	// 포인트 환불신청하기-> 환불 내역에 인서트
	@Override
	public int insertRefund(Refund refund) {
		return pd.insertRefund(sqlSession, refund);
	}

	// 해당 reviewId로 trvId 조회해오기
	@Override
	public int selectOneTrv(ReservePoint rp) {
		// TODO Auto-generated method stub
		return pd.selectOneTrv(sqlSession, rp);
	}

	// Member 테이블의 userPoint조회해오기
	@Override
	public int selectUserPoint(int memberId) {
		return pd.selectUserPoint(sqlSession, memberId);
	}

	// Member 테이블의 userPoint조회해오기
	@Override
	public int selectUserProceeds(int memberId) {
		return pd.selectUserProceeds(sqlSession, memberId);
	}

	// 포인트 사용 후 포인트 사용내역에 insert
	@Override
	public int insertPointUse(UsePoint userPoint) {
		return pd.insertPointUse(sqlSession, userPoint);
	}

	// 포인트 충전시 멤버 테이블의 누적포인트 증가
	@Override
	public int updateUserPoint(Payment pay) {
		return pd.updateUserPoint(sqlSession, pay);
	}

	// 수익금 여행글에 따른 memberId 찾기
	@Override
	public int selectReceiverTrvMemberId(int trvId) {
		return pd.selectReceiverTrvMemberId(sqlSession, trvId);
	}

	// 수익금 의뢰글에 따른 memberId 찾기
	@Override
	public int selectReceiverRequestMemberId(int ptcpId) {
		return pd.selectReceiverRequestMemberId(sqlSession, ptcpId);
	}

	// 성공시 수익금발생내역에 인서트
	@Override
	public int insertReceiverProceeds(Proceeds receiverBoard) {
		return pd.insertReceiverProceeds(sqlSession, receiverBoard);
	}

	// 판매자의 기존 수익금 내역이 존재할 시 update만
	@Override
	public int updateReceiverProceeds(Proceeds receiverBoard) {
		return pd.updateReceiverProceeds(sqlSession, receiverBoard);
	}

	// 성공시 member 테이블의 누적 포인트 차감(memberId)
	@Override
	public int updateUserDeductionPoint(UsePoint userPoint) {
		return pd.updateUserDeductionPoint(sqlSession, userPoint);
	}

	// 성공시 member 테이블의 누적 수익금 추가
	@Override
	public int updateUserIncreaseProceeds(Proceeds receiverBoard) {
		return pd.updateUserIncreaseProceeds(sqlSession, receiverBoard);
	}

	// 수익금 달성내역 전체 리스트 카운트
	@Override
	public int getProceedsListCount(Proceeds proceeds) {
		return pd.getProceedsListCount(sqlSession, proceeds);
	}

	// 수익금 달성내역 가져오기
	@Override
	public ArrayList<Proceeds> selectAllProceeds(PageInfo proPi, Proceeds proceeds) {
		return pd.selectAllProceeds(sqlSession, proPi, proceeds);
	}

	// 누적수익금을 위한 기존 수익금 조회
	@Override
	public Proceeds selectOneProceeds(Proceeds receiverBoard) {
		return pd.selectOneProceeds(sqlSession, receiverBoard);
	}

	// 환급 신청내역 전체 리스트 카운트
	@Override
	public int getRebateListCount(Rebate rebate) {
		return pd.getRebateListCount(sqlSession, rebate);
	}

	// 환급 신청내역 전체 리스트 조회
	@Override
	public ArrayList<Rebate> selectAllRebate(PageInfo rebatePi, Rebate rebate) {
		return pd.selectAllRebate(sqlSession, rebate, rebatePi);
	}

	// 환불 신청시
	@Override
	public int insertRebate(Rebate rebate) {
		return pd.insertRebate(sqlSession, rebate);
	}

	// 신청 성공시 수익금 차감
	@Override
	public int updateDeductionRebate(Rebate rebate) {
		return pd.updateDeductionRebate(sqlSession, rebate);
	}

	// --------------------------------------------------------관리자
	// 관리자 총 결제 내역 전체 조회, 검색조회
	@Override
	public ArrayList<Payment> selectAdPayList(PageInfo adPayPi, SearchPoint sp) {
		return pd.selectAdPayList(sqlSession, adPayPi, sp);
	}

	// 관리자 - 총 결제 내역 리스트 카운트
	@Override
	public int getAdPaymentListCount() {
		return pd.getAdPaymentListCount(sqlSession);
	}

	// 세션에 저장하기 위해 구매한 사람의 포인트를 가져온다.
	@Override
	public int getUseMemberPoint(int memberId) {
		return pd.getUseMemberPoint(sqlSession, memberId);
	}

	// 세션에 저장하기 위해 판 사람의 수익금을 가져온다.
	@Override
	public int getRecevieMemberProceeds(int memberId) {
		return pd.getRecevieMemberProceeds(sqlSession, memberId);
	}

	// 관리자 - 결제내역 검색 리스트 카운트
	@Override
	public int getAdPaySearchListCount(SearchPoint sp) {
		return pd.getAdPaySearchListCount(sqlSession, sp);
	}

	// 관리자 - 포인트내역 검색 리스트 카운트
	@Override
	public int getAdPointListCount(SearchPoint sp) {
		return pd.getAdPointListCount(sqlSession, sp);
	}

	// 관리자 - 포인트 내역 전체 조회, 검색 조회
	@Override
	public ArrayList<Payment> selectAdPointList(PageInfo adPointPi, SearchPoint sp) {
		return pd.selectAdPointList(sqlSession, adPointPi, sp);
	}

	// 관리자 - 환불 내역 리스트 카운트
	@Override
	public int getAdRefundListCount(SearchPoint sp) {
		return pd.getAdRefundListCount(sqlSession, sp);
	}

	// 관리자 - 환불 내역 전체 조회, 검색 조회
	@Override
	public ArrayList<Payment> selectAdRefundList(PageInfo adRefundPi, SearchPoint sp) {
		return pd.selectAdRefundList(sqlSession, adRefundPi, sp);
	}

	// 관리자 - 환불 상태 바꿔주기
	@Override
	public int updateRefund(Refund refund) {
		return pd.updateRefund(sqlSession, refund);
	}

	@Override
	public Refund selectOneRefund(Refund refund) {
		return pd.selectOneRefund(sqlSession, refund);
	}

	// 관리자 - 환불 상태 성공시 산 사람의 userPoint 업데이트
	@Override
	public int updateUserPointRefund(Refund updatedRefund) {
		return pd.updateUserPointRefund(sqlSession, updatedRefund);
	}

	@Override
	public Proceeds selectMemberIdTrv(Refund updatedRefund) {
		return pd.selectMemberIdTrv(sqlSession, updatedRefund);
	}

	// 관리자 - 판 사람의 아이디 조회 -planId 이용
	@Override
	public Proceeds selectMemberIdRequest(Refund updatedRefund) {
		return pd.selectMemberIdRequest(sqlSession, updatedRefund);
	}

	// 관리자 - 판 사람의 userProceeds 차감
	@Override
	public int updateUserProceedsRefund(Proceeds proceeds) {
		return pd.updateUserProceedsRefund(sqlSession, proceeds);
	}

	// 판매자의 참여번호를 조회해와야 함
	@Override
	public int selectOnePtcp(int requestId) {
		return pd.selectOnePtcp(sqlSession, requestId);
	}

	// 차감된 userPoint 찾기
	@Override
	public int selectOnePoint(int memberId) {
		return pd.selectOnePoint(sqlSession, memberId);
	}

	// 관리자 - 수익금 리스트 카운트
	@Override
	public int getAdProceedsListCount(SearchPoint sp) {
		return pd.getAdProceedsListCount(sqlSession, sp);
	}

	// 관리자 - 수익금 조회
	@Override
	public ArrayList<Proceeds> selectAdProceedsList(PageInfo adProceedsPi, SearchPoint sp) {
		return pd.selectAdProceedsList(sqlSession, adProceedsPi, sp);
	}

	// 명소리뷰코드로 명소코드 가져오기
	@Override
	public int selectSpotId(int spotReviewId) {
		return pd.selectSpotId(sqlSession, spotReviewId);
	}

	// 관리자 - 환급 내역 리스트 카운트
	@Override
	public int getAdRebateListCount(SearchPoint sp) {
		return pd.getAdRebateListCount(sqlSession, sp);
	}

	// 관리자 - 환급 내역 조회
	@Override
	public ArrayList<Proceeds> selectAdRebateList(PageInfo adRebatePi, SearchPoint sp) {
		return pd.selectAdRebateList(sqlSession, adRebatePi, sp);
	}

	// 관리자 - 환급 상태 1개변경
	@Override
	public int updateAdRebate(int refundId) {
		return pd.updateAdRebate(sqlSession, refundId);
	}

	// 관리자 - 환급 상태 여러개변경
	@Override
	public int updateAdRebates(int refundId) {
		return pd.updateAdRebates(sqlSession, refundId);
	}

	// 관리자 - 미지급 내역 다운로드
	@Override
	public void downRebates(int rebateStatus, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		SXSSFWorkbook wb = new SXSSFWorkbook();
		SXSSFSheet sheet = wb.createSheet("rebatesInfo");
		for (int i = 0; i <= 6; i++) {
			sheet.trackColumnForAutoSizing(i);
		}
		OutputStream fileOut = response.getOutputStream();
		ArrayList<HashMap> rebatesList = pd.downRebates(sqlSession, rebateStatus);

		System.out.println("rebatesList : " + rebatesList);

		Map<String, CellStyle> styles = CommonUtils.createStyles(wb);

		Row header = sheet.createRow(2);
		
		header.setHeightInPoints(20f);
		
		for(int i=1 ; i<=6 ;i++ ) {
			Cell cell = header.createCell(i);
			switch(i) {
			case 1 : cell.setCellValue("이름"); break; 
			case 2 : cell.setCellValue("이메일 주소"); break;
			case 3 : cell.setCellValue("환급 신청일"); break;
			case 4 : cell.setCellValue("환급 신청액"); break;
			case 5 : cell.setCellValue("은행 코드"); break;
			case 6 : cell.setCellValue("계좌 번호"); break;
			}
			cell.setCellStyle(styles.get("header"));
		}
		
		for(int i=0 ; i<rebatesList.size() ; i++) {
			HashMap rebateMap = rebatesList.get(i);
			
			Row row = sheet.createRow(i+3);
			row.createCell(1).setCellValue(rebateMap.get("userName").toString());
			row.createCell(2).setCellValue(rebateMap.get("email").toString());
			row.createCell(3).setCellValue(rebateMap.get("applyDate").toString());
			row.createCell(4).setCellValue(rebateMap.get("payAmount").toString());
			row.createCell(5).setCellValue(rebateMap.get("accCode").toString());
			row.createCell(6).setCellValue(rebateMap.get("accNumber").toString());
		}
		
		for(int i=0 ; i<=6 ; i++) {
			sheet.autoSizeColumn(i);
		}
		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition", String.format("attachment; filename=\"rebatesInfo.xlsx\""));
		wb.write(fileOut);
		fileOut.close();
	}
	//일정리뷰 코드 이용하여 trvId조회
	@Override
	public int selectTrvId(int reviewId) {
		return pd.selectTrvId(sqlSession, reviewId);
	}
	//사용자 - 환급신청 내역 월 검색 리스트 카운트
	@Override
	public int selectOneRebateListCount(SearchPoint sp) {
		return pd.selectOneRebateListCount(sqlSession, sp);
	}
	//사용자 - 환급신청 내역 월 검색 조회
	@Override
	public ArrayList<Rebate> selectOneRebateList(PageInfo rebatePi, SearchPoint sp) {
		return pd.selectOneRebateList(sqlSession, rebatePi, sp);
	}
	//사용자 - 수익달성 내역 월 검색 리스트 카운트
	@Override
	public int selectOneProceedsListCount(SearchPoint sp) {
		return pd.selectOneProceedsListCount(sqlSession, sp);
	}
	//사용자 - 수익달성 내역 월 검색 조회
	@Override
	public ArrayList<Proceeds> selectOneProceedsList(PageInfo proPi, SearchPoint sp) {
		return pd.selectOneProceedsList(sqlSession, proPi, sp);
	}

}
