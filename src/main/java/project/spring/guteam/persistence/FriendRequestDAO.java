package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.FriendRequestVO;

public interface FriendRequestDAO {
	
	// 친구 요청
	int insert(FriendRequestVO vo);
	
	// 받은 친구 요청 확인
	int select(String sendMemberId, String receiveMemberId);
	
	// 친구 요청 내역
	List<String> selectTo(String sendMemberId);
	
	// 받은 친구 요청 내역
	List<String> selectFrom(String receiveMemberId);
	
	// 수락/거절 후 삭제
	int delete(String sendMemberId, String receiveMemberId);
}
