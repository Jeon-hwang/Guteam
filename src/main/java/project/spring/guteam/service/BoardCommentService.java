package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface BoardCommentService {
	int create(BoardCommentVO vo) throws Exception;
	List<BoardCommentVO> read(int gameBoardId,PageCriteria criteria);
	int update(int commentId,String CommentContent);
	int delete(int commentId, int gameBoardId);
	int getTotalCount(int boardId);
	int getBoardId(int commentId);
	int updateReplyCnt(int commentId, int amount);
}
