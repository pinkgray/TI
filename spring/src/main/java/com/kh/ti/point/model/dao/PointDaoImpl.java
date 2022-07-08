package com.kh.ti.point.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.common.PageInfo;
import com.kh.ti.member.model.vo.Member;
import com.kh.ti.point.model.vo.Payment;
import com.kh.ti.point.model.vo.Proceeds;
import com.kh.ti.point.model.vo.Rebate;
import com.kh.ti.point.model.vo.Refund;
import com.kh.ti.point.model.vo.ReservePoint;
import com.kh.ti.point.model.vo.SearchPoint;
import com.kh.ti.point.model.vo.UsePoint;

@Repository
public class PointDaoImpl implements PointDao{

	//포인트 충전
	@Override
	public int insertPay(SqlSessionTemplate sqlSession, Payment pay) {
		//System.out.println("payAmount : " + pay.getPayAmount());
		return sqlSession.insert("Payment.insertPay", pay);
	}
	//포인트 충전 리스트 전체 카운터
	@Override
	public int getChargeListCount(SqlSessionTemplate sqlSession, Payment charge) {
		return sqlSession.selectOne("Payment.getChargeListCount", charge);
	}
	//포인트 지급 리스트 전체 카운터
	@Override
	public int getReceiveListCount(SqlSessionTemplate sqlSession, ReservePoint reserve) {
		int count = sqlSession.selectOne("Payment.getReceiveListCount", reserve);
		return count;
	}
	//포인트 사용 리스트 전체 카운터
	@Override
	public int getUseListCount(SqlSessionTemplate sqlSession, UsePoint use) {
		return sqlSession.selectOne("Payment.getUseListCount",use);
	}
	//포인트 충전리스트 전체 조회
	@Override
	public ArrayList selectChargeList(SqlSessionTemplate sqlSession, PageInfo chPi, Payment charge) {
		int offset = (chPi.getCurrentPage() - 1) * chPi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, chPi.getLimit());
		ArrayList chPayList = (ArrayList)sqlSession.selectList("Payment.selectChargeList",	charge, rowBounds);
		
		return chPayList;
	}
	//포인트 지급리스트 전체 조회
	@Override
	public ArrayList<ReservePoint> selectReceiveList(SqlSessionTemplate sqlSession, PageInfo rePi, ReservePoint reserve) {
		int offset = (rePi.getCurrentPage() - 1) * rePi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, rePi.getLimit());
		
		ArrayList<ReservePoint> rePayList = (ArrayList)sqlSession.selectList("Payment.selectReceiveList", reserve, rowBounds);
		return rePayList;
	}
	//포인트 사용리스트 전체 조회
	@Override
	public ArrayList<UsePoint> selectUseList(SqlSessionTemplate sqlSession, PageInfo usPi, UsePoint use) {
		int offset = (usPi.getCurrentPage() - 1) * usPi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, usPi.getLimit());
		
		ArrayList<UsePoint> usPayList = (ArrayList)sqlSession.selectList("Payment.selectUseList", use, rowBounds);
		return usPayList;
	}
	//포인트 자동으로 적립하기
	@Override
	public int insertReservePoint(SqlSessionTemplate sqlSession, ReservePoint rp) {
		return sqlSession.insert("Payment.insertReservePoint",rp);
	}
	//성공시 멤버 누적포인트 증가
	@Override
	public int updateUserPointAuto(SqlSessionTemplate sqlSession, ReservePoint rp) {
		return sqlSession.update("Payment.updateUserPointAuto", rp);
	}
	//포인트 환불신청하기-> 환불 내역에 인서트
	@Override
	public int insertRefund(SqlSessionTemplate sqlSession, Refund refund) {
		return sqlSession.insert("Payment.insertRefund", refund);
	}
	//해당 reviewId로 trvId 조회해오기
	@Override
	public int selectOneTrv(SqlSessionTemplate sqlSession, ReservePoint rp) {
		return sqlSession.selectOne("Payment.selectOneTrv", rp);
	}
	//Member 테이블의 userPoint조회해오기
	@Override
	public int selectUserPoint(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("Payment.selectUserPoint", memberId);
	}
	//Member 테이블의 userPoint조회해오기
	@Override
	public int selectUserProceeds(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("Payment.selectUserProceeds", memberId);
	}
	//포인트 사용 후 포인트 사용내역에 insert
	@Override
	public int insertPointUse(SqlSessionTemplate sqlSession, UsePoint userPoint) {
		return sqlSession.insert("Payment.insertPointUse", userPoint);
	}
	//포인트 충전시 멤버 테이블의 누적포인트 증가
	@Override
	public int updateUserPoint(SqlSessionTemplate sqlSession, Payment pay) {
		System.out.println("update PayAmount : " + pay.getPayAmount());
		return sqlSession.update("Payment.updateUserPoint",pay);
	}
	//수익금 여행글에 따른 memberId 찾기
	@Override
	public int selectReceiverTrvMemberId(SqlSessionTemplate sqlSession, int trvId) {
		return sqlSession.selectOne("Payment.selectReceiverTrvMemberId", trvId);
	}
	//수익금 의뢰글에 따른 memberId 찾기
	@Override
	public int selectReceiverRequestMemberId(SqlSessionTemplate sqlSession, int ptcpId) {
		return sqlSession.selectOne("Payment.selectReceiverRequestMemberId", ptcpId);
	}
	//성공시 수익금발생내역에 인서트
	@Override
	public int insertReceiverProceeds(SqlSessionTemplate sqlSession, Proceeds receiverBoard) {
		return sqlSession.insert("Payment.insertReceiverProceeds", receiverBoard);
	}
	//판매자의 기존 수익금 내역이 존재할 시 update만
	@Override
	public int updateReceiverProceeds(SqlSessionTemplate sqlSession, Proceeds receiverBoard) {
		return sqlSession.update("Payment.updateReceiverProceeds", receiverBoard);
	}
	//성공시 member 테이블의 누적 포인트 차감(memberId)
	@Override
	public int updateUserDeductionPoint(SqlSessionTemplate sqlSession, UsePoint userPoint) {
		return sqlSession.update("Payment.updateUserDeductionPoint", userPoint);
	}
	//성공시 member 테이블의 누적 수익금 추가
	@Override
	public int updateUserIncreaseProceeds(SqlSessionTemplate sqlSession, Proceeds receiverBoard) {
		return sqlSession.update("Payment.updateUserIncreaseProceeds", receiverBoard);
	}
	//수익금 달성내역 전체 리스트 카운트
	@Override
	public int getProceedsListCount(SqlSessionTemplate sqlSession, Proceeds proceeds) {
		//System.out.println("getProceedsListCount proceeds : " + proceeds);
		return sqlSession.selectOne("Payment.getProceedsListCount", proceeds);
	}
	//수익금 달성내역 가져오기
	@Override
	public ArrayList<Proceeds> selectAllProceeds(SqlSessionTemplate sqlSession, PageInfo proPi, Proceeds proceeds) {
		int offset = (proPi.getCurrentPage() - 1) * proPi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, proPi.getLimit());
		
		ArrayList<Proceeds> proceedsList = (ArrayList)sqlSession.selectList("Payment.selectAllProceeds", proceeds, rowBounds);
		return proceedsList;
	}
	//누적수익금을 위한 기존 수익금 조회
	@Override
	public Proceeds selectOneProceeds(SqlSessionTemplate sqlSession, Proceeds receiverBoard) {
		return sqlSession.selectOne("Payment.selectOneProceeds", receiverBoard);
	}
	//환급 신청내역 전체 리스트 카운트
	@Override
	public int getRebateListCount(SqlSessionTemplate sqlSession, Rebate rebate) {
		return sqlSession.selectOne("Payment.getRebateListCount", rebate);
	}
	//환급 신청내역 전체 리스트 조회
	@Override
	public ArrayList<Rebate> selectAllRebate(SqlSessionTemplate sqlSession, Rebate rebate, PageInfo rebatePi) {
		int offset = (rebatePi.getCurrentPage() - 1) * rebatePi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, rebatePi.getLimit());
		
		ArrayList<Rebate> rebateList = (ArrayList)sqlSession.selectList("Payment.selectAllRebate", rebate, rowBounds);
		return rebateList;
	}
	//환불 신청시
	@Override
	public int insertRebate(SqlSessionTemplate sqlSession, Rebate rebate) {
		return sqlSession.insert("Payment.insertRebate", rebate);
	}
	//신청 성공시 수익금 차감
	@Override
	public int updateDeductionRebate(SqlSessionTemplate sqlSession, Rebate rebate) {
		return sqlSession.update("Payment.updateDeductionRebate", rebate);
	}
	//--------------------------------------------------------관리자
	//관리자  총 결제 내역 전체 조회, 검색조회
	@Override
	public ArrayList<Payment> selectAdPayList(SqlSessionTemplate sqlSession, PageInfo adPayPi, SearchPoint sp) {
		int offset = (adPayPi.getCurrentPage() - 1) * adPayPi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, adPayPi.getLimit());
		
		ArrayList<Payment> adPayList = (ArrayList)sqlSession.selectList("Payment.selectAdPayList", sp, rowBounds);
		return adPayList;
	}
	//관리자 - 총 결제 내역 리스트 카운트
	@Override
	public int getAdPaymentListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("Payment.getAdPaymentListCount");
	}
	//세션에 저장하기 위해 구매한 사람의 포인트를 가져온다.
	@Override
	public int getUseMemberPoint(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("Payment.getUseMemberPoint", memberId);
	}
	//세션에 저장하기 위해 판 사람의 수익금을 가져온다.
	@Override
	public int getRecevieMemberProceeds(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("Payment.getRecevieMemberProceeds", memberId);
	}
	//관리자 - 결제내역 검색 리스트 카운트
	@Override
	public int getAdPaySearchListCount(SqlSessionTemplate sqlSession, SearchPoint sp) {
		return sqlSession.selectOne("Payment.getAdPaySearchListCount", sp);
	}
	//관리자 - 포인트내역 검색 리스트 카운트
	@Override
	public int getAdPointListCount(SqlSessionTemplate sqlSession, SearchPoint sp) {
		return sqlSession.selectOne("Payment.getAdPointListCount", sp);
	}
	//관리자 - 포인트 내역 전체 조회, 검색 조회 
	@Override
	public ArrayList<Payment> selectAdPointList(SqlSessionTemplate sqlSession, PageInfo adPointPi, SearchPoint sp) {
		int offset = (adPointPi.getCurrentPage() - 1) * adPointPi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, adPointPi.getLimit());
		
		ArrayList<Payment> adPointList = (ArrayList)sqlSession.selectList("Payment.selectAdPointList", sp, rowBounds);
		return adPointList;
	}
	//관리자 - 환불 내역 리스트 카운트
	@Override
	public int getAdRefundListCount(SqlSessionTemplate sqlSession, SearchPoint sp) {
		return sqlSession.selectOne("Payment.getAdRefundListCount",sp);
	}
	//관리자 - 환불 내역 전체 조회, 검색 조회 
	@Override
	public ArrayList<Payment> selectAdRefundList(SqlSessionTemplate sqlSession, PageInfo adRefundPi, SearchPoint sp) {
		int offset = (adRefundPi.getCurrentPage() - 1) * adRefundPi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, adRefundPi.getLimit());
		
		ArrayList<Payment> adRefundList = (ArrayList)sqlSession.selectList("Payment.selectAdRefundList", sp, rowBounds);
		return adRefundList;
	}
	//관리자 - 환불 상태 바꿔주기
	@Override
	public int updateRefund(SqlSessionTemplate sqlSession, Refund refund) {
		return sqlSession.update("Payment.updateRefund", refund);
	}
	//관리자 - 업데이트 된 환불 내역 들고오기
	@Override
	public Refund selectOneRefund(SqlSessionTemplate sqlSession, Refund refund) {
		return sqlSession.selectOne("Payment.selectOneRefund", refund);
	}
	//관리자 - 환불 상태 성공시 산 사람의 userPoint 업데이트
	@Override
	public int updateUserPointRefund(SqlSessionTemplate sqlSession, Refund updatedRefund) {
		return sqlSession.update("Payment.updateUserPointRefund", updatedRefund);
	}
	//관리자 - 판 사람의 아이디 조회 -trvId 이용
	@Override
	public Proceeds selectMemberIdTrv(SqlSessionTemplate sqlSession, Refund updatedRefund) {
		return sqlSession.selectOne("Payment.selectMemberIdTrv", updatedRefund);
	}
	//관리자 - 판 사람의 아이디 조회 -planId 이용
	@Override
	public Proceeds selectMemberIdRequest(SqlSessionTemplate sqlSession, Refund updatedRefund) {
		return sqlSession.selectOne("Payment.selectMemberIdRequest", updatedRefund);
	}
	//관리자 - 판 사람의 userProceeds 차감
	@Override
	public int updateUserProceedsRefund(SqlSessionTemplate sqlSession, Proceeds proceeds) {
		return sqlSession.update("Payment.updateUserProceedsRefund", proceeds);
	}
	//판매자의 참여번호를 조회해와야 함
	@Override
	public int selectOnePtcp(SqlSessionTemplate sqlSession, int requestId) {
		return sqlSession.selectOne("Payment.selectOnePtcp", requestId);
	}
	//차감된 userPoint 찾기
	@Override
	public int selectOnePoint(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("Payment.selectOnePoint", memberId);
	}
	//관리자 - 수익금 리스트 카운트
	@Override
	public int getAdProceedsListCount(SqlSessionTemplate sqlSession, SearchPoint sp) {
		return sqlSession.selectOne("Payment.getAdProceedsListCount", sp);
	}
	//관리자 - 수익금 조회
	@Override
	public ArrayList<Proceeds> selectAdProceedsList(SqlSessionTemplate sqlSession, PageInfo adProceedsPi,
			SearchPoint sp) {
		int offset = (adProceedsPi.getCurrentPage() - 1) * adProceedsPi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, adProceedsPi.getLimit());
		
		ArrayList<Proceeds> adProceedsList = (ArrayList)sqlSession.selectList("Payment.selectAdProceedsList", sp, rowBounds);
		return adProceedsList;
	}
	//명소리뷰코드로 명소코드 가져오기
	@Override
	public int selectSpotId(SqlSessionTemplate sqlSession, int spotReviewId) {
		return sqlSession.selectOne("Payment.selectSpotId", spotReviewId);
	}
	//관리자 - 환급 내역 리스트 카운트
	@Override
	public int getAdRebateListCount(SqlSessionTemplate sqlSession, SearchPoint sp) {
		return sqlSession.selectOne("Payment.getAdRebateListCount", sp);
	}
	//관리자 - 환급 내역 조회
	@Override
	public ArrayList<Proceeds> selectAdRebateList(SqlSessionTemplate sqlSession, PageInfo adRebatePi, SearchPoint sp) {
		int offset = (adRebatePi.getCurrentPage() - 1) * adRebatePi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, adRebatePi.getLimit());
		
		ArrayList<Proceeds> adRebateList = (ArrayList)sqlSession.selectList("Payment.selectAdRebateList", sp, rowBounds);
		return adRebateList;
	}
	//관리자 - 환급 상태 1개변경
	@Override
	public int updateAdRebate(SqlSessionTemplate sqlSession, int refundId) {
		return sqlSession.update("Payment.updateAdRebate", refundId);
	}
	//관리자 - 환급 상태 여러개변경
	@Override
	public int updateAdRebates(SqlSessionTemplate sqlSession, int refundId) {
		return sqlSession.update("Payment.updateAdRebates", refundId);
	}
	//관리자 - 미지급 내역 다운로드
	@Override
	public ArrayList<HashMap> downRebates(SqlSessionTemplate sqlSession, int rebateStatus) {
		return (ArrayList)sqlSession.selectList("Payment.downRebates", rebateStatus);
	}
	//일정리뷰 코드 이용하여 trvId조회
	@Override
	public int selectTrvId(SqlSessionTemplate sqlSession, int reviewId) {
		return sqlSession.selectOne("Payment.selectTrvId", reviewId);

	}
	//사용자 - 환급신청 내역 월 검색 리스트 카운트
	@Override
	public int selectOneRebateListCount(SqlSessionTemplate sqlSession, SearchPoint sp) {
		return sqlSession.selectOne("Payment.selectOneRebateListCount", sp);
	}
	//사용자 - 환급신청 내역 월 검색 조회
	@Override
	public ArrayList<Rebate> selectOneRebateList(SqlSessionTemplate sqlSession, PageInfo rebatePi, SearchPoint sp) {
		int offset = (rebatePi.getCurrentPage() - 1) * rebatePi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, rebatePi.getLimit());
		
		ArrayList<Rebate> rebateList = (ArrayList)sqlSession.selectList("Payment.selectOneRebateList", sp, rowBounds);
		return rebateList;
	}
	//사용자 - 수익달성 내역 월 검색 리스트 카운트
	@Override
	public int selectOneProceedsListCount(SqlSessionTemplate sqlSession, SearchPoint sp) {
		return sqlSession.selectOne("Payment.selectOneProceedsListCount", sp);
	}
	//사용자 - 수익달성 내역 월 검색 조회
	@Override
	public ArrayList<Proceeds> selectOneProceedsList(SqlSessionTemplate sqlSession, PageInfo proPi, SearchPoint sp) {
		int offset = (proPi.getCurrentPage() - 1) * proPi.getLimit();
		RowBounds rowBounds = new RowBounds(offset, proPi.getLimit());
		
		ArrayList<Proceeds> proceedsList = (ArrayList)sqlSession.selectList("Payment.selectOneProceedsList", sp, rowBounds);
		return proceedsList;
	}
}