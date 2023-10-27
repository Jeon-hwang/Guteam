package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface BoardCommentDAO {
	public int insert(BoardCommentVO vo);
	public List<BoardCommentVO> select(int gameBoardId);
	public int update(String commentContent,int commentId);
	public int delete(int commentId);
	
	public List<BoardCommentVO> select(int gameBoardId, PageCriteria criteria);
	public int getTotalCount(int gameBoardId);
	public int getBoardId(int commentId);
	public int updateReplyCnt(int commentId,int amount);
	
	public List<BoardCommentVO> select(String memberId);
}