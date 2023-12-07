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

import project.spring.guteam.domain.BoardAndReplyVO;
import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.domain.ReplyVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.pageutil.PageMaker;
import project.spring.guteam.persistence.BoardCommentDAO;
import project.spring.guteam.persistence.GameBoardDAO;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.ReplyDAO;

@Service //@Component
public class BoardCommentServiceImple implements BoardCommentService {
	private static final Logger logger= LoggerFactory.getLogger(BoardCommentServiceImple.class);
	
	@Autowired
	private BoardCommentDAO boardCommentDAO;
	
	@Autowired
	private GameBoardDAO gameBoardDAO;
	
	@Autowired
	private ReplyDAO replyDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Transactional(value= "transactionManager")
	@Override
	public int create(BoardCommentVO vo) throws Exception{
		boardCommentDAO.insert(vo);
		logger.info("comment create()실행");
		gameBoardDAO.updateCommentCnt(vo.getGameBoardId(), 1);
		logger.info("boardComment update실행");
		return 1;
	}	
	
	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameBoardId,PageCriteria criteria) {
		logger.info("Comment read() 실행");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(boardCommentDAO.getTotalCount(gameBoardId));
		pageMaker.setPageData();
		List<BoardCommentVO> list = boardCommentDAO.select(gameBoardId,criteria);
		List<String> nicknameList = new ArrayList<String>();
		List<String> memberImageNameList = new ArrayList<String>();
		for(int i =0; i<  list.size();i++) {
			String memberId = list.get(i).getMemberId();
			MemberVO memberVO = memberDAO.select(memberId);
			String nickname = memberVO.getNickname();
			String memberImageName = memberVO.getMemberImageName();
			nicknameList.add(nickname);
			memberImageNameList.add(memberImageName);
		}
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("list", list);
		args.put("nicknameList", nicknameList);
		args.put("memberImageNameList",memberImageNameList);
		args.put("pageMaker", pageMaker);
		return args;
	}

	@Override
	public int update(int commentId, String CommentContent) {
		logger.info("comment update() 실행");
		return boardCommentDAO.update("(updated)"+CommentContent, commentId);
	}

	@Override
	public int updateDelete(int commentId, int gameBoardId) {
		logger.info("comment delete 실행");
		return boardCommentDAO.updateDelete(commentId);
	}


	@Override
	public int getBoardId(int commentId) {
		logger.info("service getBoardId 실행");
		return boardCommentDAO.getBoardId(commentId);
	}

	@Override
	public int updateReplyCnt(int commentId, int amount) {
		logger.info("updateReplyCnt 실행");
		return boardCommentDAO.updateReplyCnt(commentId, amount);
	}

	@Override
	public Map<String, Object> getAllCommentsAndReplies(String memberId,PageCriteria criteria){
		List<BoardAndReplyVO> list = boardCommentDAO.select(memberId,criteria);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(boardCommentDAO.getTotalCount(memberId));
		pageMaker.setPageData();
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("pageMaker", pageMaker);
		args.put("list", list);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public int delete(int commentId,int boardId) {
	//	List<ReplyVO> replies = replyDAO.select(commentId);
	//	if(replies != null) { // 답글이 있을경우
	//		for(int i=0;i<replies.size();i++) {
	//			if(replies.get(i).getDeleted().equals("N")) { // 답글중 하나라도 삭제된 상태가 아닌것이 있다면?
				gameBoardDAO.updateCommentCnt(boardId, -1);
				return boardCommentDAO.updateDelete(commentId);
	//			}
	//		}
	//		for(int i=0;i<replies.size();i++) {
	//			replyDAO.delete(replies.get(i).getReplyId());
	//			gameBoardDAO.updateCommentCnt(boardId, -1);
	//		}
	//		gameBoardDAO.updateCommentCnt(boardId, -1);
	//		boardCommentDAO.delete(commentId);
	//		return 2;
	//	}else { // 답글이 없을경우
	//		gameBoardDAO.updateCommentCnt(boardId, -1);
	//		return boardCommentDAO.delete(commentId);
	//	}
	
	}
	
	
	

}
