package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.FriendRequestVO;

public interface FriendRequestService {
	
	int create(FriendRequestVO vo);
	int read(String sendMemberId, String receiveMemberId);
	List<String> readTo(String sendMemberId);
	List<String> readFrom(String receiveMemberId);
	int delete(String sendMemberId, String receiveMemberId);
	
}
