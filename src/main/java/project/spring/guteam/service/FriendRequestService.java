package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.FriendRequestVO;

public interface FriendRequestService {
	
	int create(FriendRequestVO vo);
	List<FriendRequestVO> readTo(String sendMemberId);
	List<FriendRequestVO> readFrom(String receiveMemberId);
	int delete(String sendMemberId);
	
}
