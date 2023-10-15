package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.BoardCommentVO;

public interface BoardCommentDAO {
	public int insert(BoardCommentVO vo);
	public List<BoardCommentVO> select(int gameBoardId);
	public int update(String commentContent,int commentId);
	public int delete(int commentId);
}
