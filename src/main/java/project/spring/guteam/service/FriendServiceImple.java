package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.FriendVO;
import project.spring.guteam.persistence.FriendDAO;
import project.spring.guteam.persistence.FriendRequestDAO;

@Service // @Component
public class FriendServiceImple implements FriendService {
	private static final Logger logger = LoggerFactory.getLogger(FriendServiceImple.class);
	
	@Autowired
	private FriendDAO frdDao;
	
	@Autowired
	private FriendRequestDAO reqDao;
	
	
	// 친구 수락될때 수락 후 friendRequest 테이블에서 삭제 (트랜잭션)
	@Transactional(value = "transactionManager")
	@Override
	public int create(FriendVO vo) {
		logger.info("create() 호출 vo? " + vo.toString());
		int result = frdDao.insert(vo);
		FriendVO rvo = new FriendVO(vo.getFriendId(), vo.getMemberId());
		logger.info("vo 반대로? rvo = " + rvo.toString());
		if(result == 1) {
			result = frdDao.insert(rvo);
			logger.info("요청 받은 아이디 : " + vo.getMemberId());
			reqDao.delete(vo.getFriendId(), vo.getMemberId());
			// 내가 친추 요청을 했다면 .delete 해야함
			result = reqDao.select(vo.getFriendId());
			if(result == 1) {
				result = reqDao.delete(vo.getMemberId(), vo.getFriendId());				
				logger.info("내가 한 요청 삭제");
			}
			
		}
		return result;
	}

	@Override
	public List<String> read(String memberId) {
		logger.info("read() 호출 memId? " + memberId);
		return frdDao.select(memberId);
	}

	@Override
	public int read(String memberId, String friendId) {
		logger.info("이미 친구인가? " + memberId + " " + friendId);
		return frdDao.select(memberId, friendId);
	}
	
	@Override
	public int delete(String friendId) {
		logger.info("delete() 호출 friendId? " + friendId);
		return frdDao.delete(friendId);
	}


}
