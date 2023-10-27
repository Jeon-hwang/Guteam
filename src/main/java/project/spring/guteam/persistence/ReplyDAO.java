package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.ReplyVO;

public interface ReplyDAO {
	int insert(ReplyVO vo);
	List<ReplyVO> select(int commentId);
	int update(String replyComment, int replyId);
	int delete(int replyId);
	List<ReplyVO> select(String memberId);
}
