package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.MemberVO;

// CRUD (Create, Read, Update, Delete)
public interface MemberService {
	
	int create(MemberVO vo);
	List<MemberVO> read();
	MemberVO read(String memberId);
	int updateMem(MemberVO vo);
	int updateCash(MemberVO vo);
	int delete(String memberId);
	
}
