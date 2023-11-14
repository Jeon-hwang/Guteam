package project.spring.guteam.service;

import java.util.Map;

import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface BoardCommentService {
	int create(BoardCommentVO vo) throws Exception;
	Map<String, Object> read(int gameBoardId,PageCriteria criteria);
	int update(int commentId,String CommentContent);
	int updateDelete(int commentId, int gameBoardId);
	int getBoardId(int commentId);
	int updateReplyCnt(int commentId, int amount);
	Map<String, Object> getAllCommentsAndReplies(String memberId,PageCriteria criteria);
	int delete(int commentId,int gameBoardId);
}
