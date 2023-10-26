package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.FriendVO;

public interface FriendDAO {
	
	// 친구 수락
	int insert(FriendVO vo);
	
	// 내 친구 목록
	List<FriendVO> select(String memberId);
	
	// 친구 삭제
	int delete(String friendId);
}
