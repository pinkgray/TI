package com.kh.ti.notice.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.ti.adminCallCenter.model.vo.Board;
import com.kh.ti.common.PageInfo;

public interface NoticeDao {

	int getNoticeCount(SqlSessionTemplate sqlSession);

	ArrayList<Board> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi);

	Board selectNoticeDetail(SqlSessionTemplate sqlSession, int boardId);

	int updateNoticeCount(SqlSessionTemplate sqlSession, int boardId);

	int getMoreQuestionCount(SqlSessionTemplate sqlSession);

	ArrayList<Board> selectMoreQuestionList(SqlSessionTemplate sqlSession, PageInfo pi);

}
