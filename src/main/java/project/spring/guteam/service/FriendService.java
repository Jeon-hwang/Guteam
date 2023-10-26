package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.FriendVO;

public interface FriendService {
	
	int create(FriendVO vo);
	List<FriendVO> read(String memberId);
	int delete(String friendId);
}
