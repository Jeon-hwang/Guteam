package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.FriendVO;

public interface FriendService {
	
	int create(FriendVO vo);
	List<String> read(String memberId);
	int read(String memberId, String friendId);
	int delete(String memberId, String friendId);
}
