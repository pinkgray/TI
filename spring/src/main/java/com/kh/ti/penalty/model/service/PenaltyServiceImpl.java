package com.kh.ti.penalty.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.kh.ti.common.PageInfo;
import com.kh.ti.penalty.model.dao.PenaltyDao;
import com.kh.ti.penalty.model.vo.Penalty;
import com.kh.ti.penalty.model.vo.PenaltyAttachment;

@Service
public class PenaltyServiceImpl implements PenaltyService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private PenaltyDao pd;
	@Autowired
	private DataSourceTransactionManager transactionManager;

	//신고하기 인서트
	@Override
	public int insertPenalty(Penalty p, ArrayList<PenaltyAttachment> attachmentFileList) {
		int result = 0;
		
		//신고글 인서트
		int result1 = pd.insertPenalty(sqlSession, p);
		
		//신고 캡쳐이미지 인서트
		int result2 = pd.insertPenaltyImg(sqlSession, attachmentFileList);
			
		if(result2 == attachmentFileList.size()) {
			result = 1;
		} else {
			result = 0;
		}
		return result;
	}

	//신청한 신고내역 수
	@Override
	public int getPenaltyCount(int memberId) {
		return pd.getPenaltyCount(sqlSession, memberId);
	}

	//신고글 내역들 조회
	@Override
	public ArrayList<Penalty> selectPenaltyList(PageInfo pi, int memberId) {
		return pd.selectPenaltyList(sqlSession, pi, memberId);
	}

	//신고글 상세조회
	@Override
	public Penalty selectOnePenalty(int listId) {
		return pd.selectOnePanelty(sqlSession, listId);
	}
}
