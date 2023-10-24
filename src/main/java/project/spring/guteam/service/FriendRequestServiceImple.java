package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.FriendRequestVO;
import project.spring.guteam.persistence.FriendRequestDAO;

@Service // @Component
public class FriendRequestServiceImple implements FriendRequestService {
	private static final Logger logger = LoggerFactory.getLogger(FriendRequestServiceImple.class);
	
	@Autowired
	private FriendRequestDAO dao;
	
	@Override
	public int create(FriendRequestVO vo) {
		logger.info("create() 호출");
		return dao.insert(vo);
	}

	@Override
	public List<FriendRequestVO> readTo(String sendMemberId) {
		logger.info("readTo() 호출 보낸 사람 = " + sendMemberId);
		return dao.selectTo(sendMemberId);
	}

	@Override
	public List<FriendRequestVO> readFrom(String receiveMemberId) {
		logger.info("readFrom() 호출 받은 초대" + receiveMemberId);
		return dao.selectFrom(receiveMemberId);
	}

	@Override
	public int delete(String sendMemberId) {
		logger.info("delete() 호출");
		return dao.delete(sendMemberId);
	}

}
