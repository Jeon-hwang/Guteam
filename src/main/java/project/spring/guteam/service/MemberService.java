package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.MemberVO;

// CRUD (Create, Read, Update, Delete)
public interface MemberService {
	
	int create(MemberVO vo);
	List<MemberVO> read();
	MemberVO read(String memberId);
	int read(String memberId, String checking);
	int read(String nickname, int checking);
	int update(MemberVO vo, String isCash);
	int delete(String memberId);
	
}
