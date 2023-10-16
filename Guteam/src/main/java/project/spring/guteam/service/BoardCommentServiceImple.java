package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.persistence.BoardCommentDAO;

@Service //@Component
public class BoardCommentServiceImple implements BoardCommentService {
	private static final Logger logger= LoggerFactory.getLogger(BoardCommentServiceImple.class);
	
	@Autowired
	BoardCommentDAO boardCommentDAO;
	
	@Override
	public int create(BoardCommentVO vo) {
		logger.info("comment create()실행");
		return boardCommentDAO.insert(vo);
	}

	@Override
	public List<BoardCommentVO> read(int gameBoardId) {
		logger.info("Comment read() 실행");
		return boardCommentDAO.select(gameBoardId);
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

}
