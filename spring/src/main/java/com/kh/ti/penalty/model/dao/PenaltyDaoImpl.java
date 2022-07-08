package com.kh.ti.penalty.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.common.PageInfo;
import com.kh.ti.penalty.model.vo.Penalty;
import com.kh.ti.penalty.model.vo.PenaltyAttachment;

@Repository
public class PenaltyDaoImpl implements PenaltyDao{

	//신고글 인서트
	@Override
	public int insertPenalty(SqlSessionTemplate sqlSession, Penalty p) {
		return sqlSession.insert("Penalty.insertPenalty", p);
	}

	//신고글 이미지 인서트
	@Override
	public int insertPenaltyImg(SqlSessionTemplate sqlSession, ArrayList<PenaltyAttachment> attachmentFileList) {
		int result = 0;
		for(int i = 0; i < attachmentFileList.size(); i++) {
			sqlSession.insert("Penalty.insertPenaltyImg", attachmentFileList.get(i));
			result++;
		}
		
		return result;
	}

	//나의 신고내역 수 조회
	@Override
	public int getPenaltyCount(SqlSessionTemplate sqlSession, int memberId) {
		return sqlSession.selectOne("Penalty.getPenaltyCount", memberId);
	}

	//나의 신고내역 목록
	@Override
	public ArrayList<Penalty> selectPenaltyList(SqlSessionTemplate sqlSession, PageInfo pi, int memberId) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("Penalty.selectPenaltyList", memberId, rowBounds);
	}

	//신고 상세보기
	@Override
	public Penalty selectOnePanelty(SqlSessionTemplate sqlSession, int listId) {
		return sqlSession.selectOne("Penalty.selectOnePanelty", listId);
	}

}
