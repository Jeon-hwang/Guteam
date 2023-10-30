package project.spring.guteam.service;

import java.util.Map;

import project.spring.guteam.domain.ReplyVO;

public interface ReplyService {
	int create(ReplyVO vo);
	Map<String,Object> read(int commentId);
	int update(int replyId,String replyContent);
	int delete(int replyId);
}
