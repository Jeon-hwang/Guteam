package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.ReplyVO;
import project.spring.guteam.persistence.ReplyDAO;

@Service
public class ReplyServiceImple implements ReplyService {

	private static final Logger logger = LoggerFactory.getLogger(ReplyServiceImple.class);
	
	@Autowired
	private ReplyDAO replyDAO;
	
	@Autowired
	private BoardCommentService boardCommentService;
	
	@Autowired
	private GameBoardService gameBoardService;
	
	@Transactional(value="transactionManager")
	@Override
	public int create(ReplyVO vo) {
		logger.info("create 호출");
		replyDAO.insert(vo);
		int boardId = boardCommentService.getBoardId(vo.getCommentId());
		boardCommentService.updateReplyCnt(vo.getCommentId(), 1);
		gameBoardService.update(boardId, 1);
		
		return 1;
	}

	@Override
	public List<ReplyVO> read(int commentId) {
		logger.info("read 호출");
		return replyDAO.select(commentId);
	}

	@Override
	public int update(int replyId, String replyContent) {
		logger.info("update 호출");
		return replyDAO.update(replyContent, replyId);
	}

	@Override
	public int delete(int replyId) {
		logger.info("delete 호출");
		return replyDAO.delete(replyId);
	}

}
