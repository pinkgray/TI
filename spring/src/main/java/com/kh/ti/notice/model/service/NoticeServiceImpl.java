package com.kh.ti.notice.model.service;

import java.io.Serializable;
import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.common.PageInfo;
import com.kh.ti.notice.model.dao.NoticeDao;

@Service
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private NoticeDao cd;
	@Autowired
	private DataSourceTransactionManager transactionManager;
	//공지글 수
	@Override
	public int getNoticeCount() {
		return cd.getNoticeCount(sqlSession);
	}

	//공지 목록들
	@Override
	public ArrayList<Board> selectNoticeList(PageInfo pi) {
		return cd.selectNoticeList(sqlSession, pi);
	}

	//공지사항 상세조회
	@Override
	public Board selectOneNotice(int boardId) {
		Board b = new Board();
		int result = cd.updateNoticeCount(sqlSession, boardId);
		if(result > 0) {
			b = cd.selectNoticeDetail(sqlSession, boardId);
		}
		return b;
	}

	//자주글 수
	@Override
	public int getMoreQuestionCount() {
		return cd.getMoreQuestionCount(sqlSession);
	}

	//자주글 목록
	@Override
	public ArrayList<Board> selectMoreQuestionList(PageInfo pi) {
		return cd.selectMoreQuestionList(sqlSession, pi);
	}

}
