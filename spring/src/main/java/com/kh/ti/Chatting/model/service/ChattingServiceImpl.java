package com.kh.ti.Chatting.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ti.Chatting.model.dao.ChattingDao;
import com.kh.ti.member.model.vo.Member;
import com.kh.ti.travel.model.vo.Country;
import com.kh.ti.travel.model.vo.Tag;

@Service
public class ChattingServiceImpl implements ChattingService{

	@Autowired
	private ChattingDao cd;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Member selectMemberInfo(int userId) {
		
		return cd.selectMemberInfo(sqlSession,userId);
	}

	@Override
	public ArrayList<Country> selectContryList() {
		return cd.selectContryList(sqlSession);
	}

	@Override
	public ArrayList<Tag> selectTagList() {
		// TODO Auto-generated method stub
		return cd.selectTagList(sqlSession);
	}

	@Override
	public HashMap<String, ArrayList> selectRankTagList() {

		return cd.selectRankTagList(sqlSession);
	}
	
	
	
}
