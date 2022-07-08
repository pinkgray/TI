package com.kh.ti.Chatting.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.ti.member.model.vo.Member;
import com.kh.ti.travel.model.vo.Country;
import com.kh.ti.travel.model.vo.Tag;

public interface ChattingDao {


	//사용자 정보 불러오는 메소드 -- 지원
	public Member selectMemberInfo(SqlSessionTemplate sqlSession, int userId);

	public ArrayList<Country> selectContryList(SqlSessionTemplate sqlSession);

	public ArrayList<Tag> selectTagList(SqlSessionTemplate sqlSession);

	public HashMap<String, ArrayList> selectRankTagList(SqlSessionTemplate sqlSession);
	
}
