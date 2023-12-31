
package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.MemberVO;

// CRUD (Create, Read, Update, Delete)
public interface MemberService {
	
	int create(MemberVO vo);
	List<MemberVO> read();
	List<String> search(String keyword);
	MemberVO read(String memberId);
	int read(String memberId, String checking);
	int read(String nickname, int checking);
	int update(MemberVO vo, String isCash);
	int update(String memberId, int amount);
	int delete(String memberId);
	List<MemberVO> findLikeNickname(String keyword);
	List<MemberVO> findNickname(String getKeyword);
	MemberVO findByNickname(String nickname);
	MemberVO readNickname(String nickname);
	
}