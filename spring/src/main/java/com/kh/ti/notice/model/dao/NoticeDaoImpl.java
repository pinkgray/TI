package com.kh.ti.notice.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.common.PageInfo;

@Repository
public class NoticeDaoImpl implements NoticeDao{

	//공지글 수 조회
	@Override
	public int getNoticeCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("CallCenter.getNoticeCount");
	}

	//공지글 목록 조회
	@Override
	public ArrayList<Board> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("CallCenter.selectNoticeList", null, rowBounds);
	}

	//공지글 상세조회
	@Override
	public Board selectNoticeDetail(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("CallCenter.selectNoticeDetail", boardId);
	}

	//공지글 조회수 증가
	@Override
	public int updateNoticeCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.update("CallCenter.updateNoticeCount", boardId);
	}

	//자주글 수
	@Override
	public int getMoreQuestionCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("CallCenter.getMoreQuestionCount");
	}

	//자주글 목록
	@Override
	public ArrayList<Board> selectMoreQuestionList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
						
		return (ArrayList)sqlSession.selectList("CallCenter.selectMoreQuestionList", null, rowBounds);
	}

}
