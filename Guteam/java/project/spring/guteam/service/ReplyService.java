package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.ReplyVO;

public interface ReplyService {
	int create(ReplyVO vo);
	List<ReplyVO> read(int commentId);
	int update(int replyId,String replyContent);
	int delete(int replyId);
}
