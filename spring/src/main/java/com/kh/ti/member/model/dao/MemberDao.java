package com.kh.ti.member.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.ti.common.PageInfo;
import com.kh.ti.member.model.vo.Member;

public interface MemberDao {

	int insertMember(SqlSessionTemplate sqlSession, Member m);

	String selectEncPassword(SqlSessionTemplate sqlSession, Member m);

	Member selectMember(SqlSessionTemplate sqlSession, Member m);

	int insertReservePoint(SqlSessionTemplate sqlSession, String email);

	int updateUserPwd(SqlSessionTemplate sqlSession, Member loginUser);

	int dropOutUserInfo(SqlSessionTemplate sqlSession, Member loginUser);

	int updateUserInfo(SqlSessionTemplate sqlSession, Member m);

	int updateUserAcc(SqlSessionTemplate sqlSession, Member loginUser);

	ArrayList<Member> selectAllMember(SqlSessionTemplate sqlSession, PageInfo pi, String status);

	int getListCount(SqlSessionTemplate sqlSession, String status);

	ArrayList<Member> selectConditionMember(SqlSessionTemplate sqlSession, Map<String, String> map);

	int updatePasswordFromFind(SqlSessionTemplate sqlSession, Member member);

	Member selectMemberEmail(SqlSessionTemplate sqlSession, String email);

	int getCurrentMemberId(SqlSessionTemplate sqlSession, Member m);


}
