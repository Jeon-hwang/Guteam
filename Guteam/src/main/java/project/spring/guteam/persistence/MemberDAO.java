package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.MemberVO;

public interface MemberDAO {
	
	// 회원 등록
	int insert(MemberVO vo);
	
	// 회원 정보 조회 (전체)
	List<MemberVO> select();
	
	// 회원 정보 조회 (ID)
	MemberVO select(int memberId);
	
	// 회원 정보 수정
	int update(MemberVO vo);
	
	// 회원 정보 삭제
	int delete(int memberId);
	
}
