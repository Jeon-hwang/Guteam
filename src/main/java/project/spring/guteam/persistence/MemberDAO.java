package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.MemberVO;

public interface MemberDAO {
	
	// 회원 등록
	int insert(MemberVO vo);
	
	// 회원 정보 조회 (전체)
	List<MemberVO> select();
	
	// 회원 정보 조회 (닉넴)
	List<String> selectList(String keyword);
	
	// 회원 정보 조회 (ID)
	MemberVO select(String memberId);
	
	// 회원 정보 수정
	int updateMem(MemberVO vo);
	
	// 캐쉬 충전
	int updateCash(int amount,String memberId);
	
	// 회원 정보 삭제
	int delete(String memberId);
	
	// 회원 닉넴 중복 체크 int checkNickname(String nickname);
	String selectByNickname(String nickname);
	
	// 회원 id 중복 체크 int checkId(String memberId);
	String selectByMemberId(String memberId);

	List<MemberVO> selectLikeNickname(String keyword);
	
}
