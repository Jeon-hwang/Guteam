package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.domain.ReplyVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface BoardCommentService {
	int create(BoardCommentVO vo);
	List<BoardCommentVO> read(int gameBoardId,PageCriteria criteria);
	int update(int commentId,String CommentContent);
	int delete(int commentId, int gameBoardId);
	int getTotalCount(int boardId);
}
