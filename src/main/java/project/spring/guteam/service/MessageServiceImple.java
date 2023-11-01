package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.MessageVO;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.MessageDAO;

@Service // @Component
public class MessageServiceImple implements MessageService {
	private static final Logger logger = LoggerFactory.getLogger(MessageServiceImple.class);
	
	@Autowired
	private MessageDAO dao;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int create(MessageVO vo) {
		logger.info("create() 호출 vo? " + vo.toString());
		vo.setReceiveMemberId((memberDAO.selectByNickname(vo.getReceiveMemberId())));
		return dao.insert(vo);
	}

	@Override
	public List<MessageVO> read(String memberId) {
		logger.info("read() 호출");
		return dao.select(memberId);
	}

	@Override
	public int delete(int messageId) {
		logger.info("delete() 호출");
		return dao.delete(messageId);
	}

}
