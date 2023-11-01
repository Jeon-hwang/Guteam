package project.spring.guteam.service;

import java.util.List;
import java.util.Map;

import project.spring.guteam.domain.BoardAndReplyVO;
import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface BoardCommentService {
	int create(BoardCommentVO vo) throws Exception;
	Map<String, Object> read(int gameBoardId,PageCriteria criteria);
	int update(int commentId,String CommentContent);
	int delete(int commentId, int gameBoardId);
	int getBoardId(int commentId);
	int updateReplyCnt(int commentId, int amount);
	public Map<String, Object> getAllCommentsAndReplies(String memberId,PageCriteria criteria);
}
