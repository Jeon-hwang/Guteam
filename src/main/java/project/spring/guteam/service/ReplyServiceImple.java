package project.spring.guteam.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.domain.ReplyVO;
import project.spring.guteam.persistence.BoardCommentDAO;
import project.spring.guteam.persistence.GameBoardDAO;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.ReplyDAO;

@Service
public class ReplyServiceImple implements ReplyService {

	private static final Logger logger = LoggerFactory.getLogger(ReplyServiceImple.class);
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private ReplyDAO replyDAO;
	
	@Autowired
	private BoardCommentDAO boardCommentDAO;
	
	@Autowired
	private GameBoardDAO gameBoardDAO;
	
	@Transactional(value="transactionManager")
	@Override
	public int create(ReplyVO vo) {
		logger.info("create 호출");
		replyDAO.insert(vo);
		int boardId = boardCommentDAO.getBoardId(vo.getCommentId());
		boardCommentDAO.updateReplyCnt(vo.getCommentId(), 1);
		gameBoardDAO.updateCommentCnt(boardId, 1);
		
		return 1;
	}
	
	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int commentId) {
		logger.info("read 호출");
		List<ReplyVO> list = replyDAO.select(commentId);
		List<String> nicknameList = new ArrayList<String>();
		List<String> profileImageNameList = new ArrayList<String>();
		for(int i = 0; i<list.size();i++) {
			String memberId = list.get(i).getMemberId();
			MemberVO memberVO = memberDAO.select(memberId);
			String nickname, profileImageName;
			if(memberVO == null) {
				nickname = memberDAO.selectByMemberId(memberId);
				profileImageName = "deleted.png";
			}else {
				nickname = memberVO.getNickname();
				profileImageName = memberVO.getMemberImageName();
			}
			nicknameList.add(nickname);
			profileImageNameList.add(profileImageName);
			
		}
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("list", list);
		args.put("nicknameList", nicknameList);
		args.put("profileImageNameList", profileImageNameList);
		return args;
	}

	@Override
	public int update(int replyId, String replyContent) {
		logger.info("update 호출");
		return replyDAO.update("(updated)"+replyContent, replyId);
	}

	@Override
	public int delete(int replyId) {
		logger.info("delete 호출");
		return replyDAO.updateDelete(replyId);
	}
	
	@Transactional(value = "transactionManager")
	@Override
	public int delete(int commentId,String commentContent, int replyId) { //답글 삭제버튼 누를시
		logger.info("답글 삭제 commentId,commentContent,replyId : "+commentId+", "+commentContent+", "+replyId);
		int result = 0;
		int boardId = boardCommentDAO.getBoardId(commentId);
		if(commentContent.equals("삭제된 댓글입니다.")) { // 댓글이 삭제된 상태이고
			result = replyDAO.updateDelete(replyId);
			gameBoardDAO.updateCommentCnt(boardId, -1);
			boardCommentDAO.updateReplyCnt(commentId, -1);
			List<ReplyVO> replies = replyDAO.select(commentId); // 댓글아래 답글들 가져오고
			result = 2;
			for(int i =0;i<replies.size();i++) {
				logger.info(replies.get(i).getDeleted());
				if(replies.get(i).getDeleted().equals("N")) {  // 답글 중에 하나라도 삭제상태인 것이 아니라면?
					result = 1; //이미 답글은 삭제된 상태로 치고 하나라도 삭제되지 않은 답글이 있다면 결과값을 2로
				}
			} // 모든 답글들도 삭제된 댓글입니다가 뜨면?
		}else {
			gameBoardDAO.updateCommentCnt(boardId, -1);
			boardCommentDAO.updateReplyCnt(commentId, -1);
			return replyDAO.updateDelete(replyId); // 이건 그냥 삭제되었습니다로만 바꾸어줌
		}
		
//			for(int i =0;i<replies.size();i++) {
//				replyDAO.delete(replies.get(i).getReplyId()); // 모든 답글 완전 삭제
//				logger.info("완전 삭제!");
//				gameBoardDAO.updateCommentCnt(boardId, -1);
//			}
//			gameBoardDAO.updateCommentCnt(boardId, -1);
//			boardCommentDAO.delete(commentId);
//			result=2;
//			return result; // 댓글도 완전 삭제
//		}else{
//			boardCommentDAO.updateReplyCnt(commentId, -1);
			return result;
//		}
		
		
	}

}
