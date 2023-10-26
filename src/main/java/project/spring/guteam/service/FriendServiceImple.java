package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.FriendVO;
import project.spring.guteam.persistence.FriendDAO;

@Service // @Component
public class FriendServiceImple implements FriendService {
	private static final Logger logger = LoggerFactory.getLogger(FriendServiceImple.class);
	
	@Autowired
	private FriendDAO dao;
	
	@Override
	public int create(FriendVO vo) {
		logger.info("create() 호출 vo? " + vo.toString());
		return dao.insert(vo);
	}

	@Override
	public List<FriendVO> read(String memberId) {
		logger.info("read() 호출 memId? " + memberId);
		return dao.select(memberId);
	}

	@Override
	public int delete(String friendId) {
		logger.info("delete() 호출 friendId? " + friendId);
		return dao.delete(friendId);
	}

}
