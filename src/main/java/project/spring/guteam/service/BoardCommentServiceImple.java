package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.BoardCommentDAO;
import project.spring.guteam.persistence.GameBoardDAO;

@Service //@Component
public class BoardCommentServiceImple implements BoardCommentService {
	private static final Logger logger= LoggerFactory.getLogger(BoardCommentServiceImple.class);
	
	@Autowired
	BoardCommentDAO boardCommentDAO;
	
	@Autowired
	GameBoardDAO gameBoardDAO;
	
	@Transactional(value= "transactionManager")
	@Override
	public int create(BoardCommentVO vo) throws Exception{
		boardCommentDAO.insert(vo);
		logger.info("comment create()실행");
		gameBoardDAO.updateCommentCnt(vo.getGameBoardId(), 1);
		logger.info("boardComment update실행");
		return 1;
	}

	@Override
	public List<BoardCommentVO> read(int gameBoardId,PageCriteria criteria) {
		logger.info("Comment read() 실행");
		return boardCommentDAO.select(gameBoardId,criteria);
	}

	@Override
	public int update(int commentId, String CommentContent) {
		logger.info("comment update() 실행");
		return boardCommentDAO.update(CommentContent, commentId);
	}

	@Override
	public int delete(int commentId, int gameBoardId) {
		logger.info("comment delete 실행");
		return boardCommentDAO.delete(commentId);
	}

	@Override
	public int getTotalCount(int boardId) {
		logger.info("service getTotalCount 실행");
		return boardCommentDAO.getTotalCount(boardId);
	}

	@Override
	public int getBoardId(int commentId) {
		logger.info("service getBoardId 실행");
		return boardCommentDAO.getBoardId(commentId);
	}

	@Override
	public int updateReplyCnt(int commentId, int amount) {
		logger.info("updateReplyCnt 실행");
		return boardCommentDAO.updateReplyCnt(commentId, amount);
	}

}
