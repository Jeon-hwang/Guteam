package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.FriendRequestVO;

public interface FriendRequestDAO {
	
	// 친구 요청
	int insert(FriendRequestVO vo);
	
	// 친구 요청 확인
	int select(String sendMemberId);
	
	// 친구 요청 내역
	List<String> selectTo(String sendMemberId);
	
	// 받은 친구 요청 내역
	List<FriendRequestVO> selectFrom(String receiveMemberId);
	
	// 수락/거절 후 삭제
	int delete(String sendMemberId);
}
