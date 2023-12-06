package project.spring.guteam.service;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.GameBoardDAO;
import project.spring.guteam.persistence.GameDAO;
import project.spring.guteam.persistence.MemberDAO;

@Service
public class GameBoardServiceImple implements GameBoardService {
	private static Logger logger = LoggerFactory.getLogger(GameBoardServiceImple.class);
	
	@Autowired
	private GameBoardDAO gameBoardDAO;
	
	@Autowired
	private GameDAO gameDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int create(GameBoardVO vo, Principal principal) {
		logger.info("gameBoard create() 호출 : vo = " + vo);
		if(gameDAO.select(vo.getGameId())!=null) {
			return gameBoardDAO.insert(vo);					
		}
		logger.info("gameId 존재하지 않음");
		return 0;
	} // end create()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria) {
		logger.info("gameBoard read() 호출 : gameId = " + gameId);
		List<GameBoardVO> gameBoardVOList = gameBoardDAO.select(gameId, criteria);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < gameBoardVOList.size(); i++) {
			if(gameBoardVOList.get(i).getDeleted().equals("Y")) {
				gameBoardVOList.get(i).setGameBoardContent("삭제된 게시글입니다");
				gameBoardVOList.get(i).setGameBoardTitle("삭제된 게시글 입니다");
				gameBoardVOList.get(i).setMemberId("삭제된 게시글입니다");
				nicknameList.add("삭제된 게시글입니다");
			}else {
				nicknameList.add(memberDAO.selectByMemberId(gameBoardVOList.get(i).getMemberId()));
			}
		}
		GameVO gameVO = gameDAO.select(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameBoardVOList", gameBoardVOList);
		args.put("nicknameList",nicknameList);
		args.put("gameVO", gameVO);
		return args;
	} // end read()

	@Override
	public int update(GameBoardVO vo, Principal principal) {
		logger.info("gameBoard update() 호출 : vo = " + vo );
		if(gameDAO.select(vo.getGameId())!=null) {
			if(gameBoardDAO.selectByBoardId(vo.getGameBoardId())!=null) {
				return gameBoardDAO.update(vo);					
			}
			logger.info("gameBoardId 없음");
			return 0;
		}
		logger.info("gameId 없음");
		return 0;
	} // end update()

	@Override
	public int updateToDeleted(int gameBoardId, Principal principal) {
		logger.info("gameBoard update(gameBoardId) 호출 : gameBoardId = " + gameBoardId);
		GameBoardVO vo = gameBoardDAO.selectByBoardId(gameBoardId);
		if(vo.getMemberId().equals(principal.getName())) {
			if(gameDAO.select(vo.getGameId())!=null) {
				if(gameBoardDAO.selectByBoardId(vo.getGameBoardId())!=null) {
					return gameBoardDAO.updateDeleted(gameBoardId);
				}
				logger.info("gameBoardId 없음");
				return 0;
			}
			logger.info("gameId 없음");
			return 0;
		}
		logger.info("user정보 불일치");
		return 0;
	} // end updateToDeleted()

	@Override
	public int getTotalCount(int gameId) {
		logger.info("gameBoard getTotalCount() 호출 ");
		return gameBoardDAO.getTotalCounts(gameId);
	} // end getTotalCount()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria, String keywordCriteria, String keyword) {
		logger.info("gameBoard read(keyword) 호출 : keywordCriteria = " + keywordCriteria + ",keyword = " + keyword);
		List<GameBoardVO> gameBoardVOList = null;
		if(keywordCriteria!=null&&keywordCriteria.equals("memberId")) {
			gameBoardVOList = gameBoardDAO.selectByNickname(gameId, keyword, criteria);
		}else {
			gameBoardVOList = gameBoardDAO.selectByKeyword(gameId, keyword, criteria);
		}
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < gameBoardVOList.size(); i++) {
			if(gameBoardVOList.get(i).getDeleted().equals("Y")) {
				gameBoardVOList.get(i).setGameBoardContent("삭제된 게시글 입니다");
				gameBoardVOList.get(i).setGameBoardTitle("삭제된 게시글 입니다");
				gameBoardVOList.get(i).setMemberId("삭제된 게시글 입니다");
				nicknameList.add("삭제된 게시글 입니다");
			}else {
				nicknameList.add(memberDAO.selectByMemberId(gameBoardVOList.get(i).getMemberId()));
			}
		}
		GameVO gameVO = gameDAO.select(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameBoardVOList", gameBoardVOList);
		args.put("nicknameList",nicknameList);
		args.put("gameVO", gameVO);
		return args;
	} // end read()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameBoardId, String memberId) {
		logger.info("gameBoard read(gameBoardId) 호출 : gameBoardId = " + gameBoardId);
		Map<String, Object> args = new HashMap<>();
		GameBoardVO gameBoardVO = gameBoardDAO.selectByBoardId(gameBoardId);
		if(memberId!=null&&!memberId.equals("")) {
			String nickname = memberDAO.selectByMemberId(gameBoardVO.getMemberId());
			String memberImageName= memberDAO.select(memberId).getMemberImageName();
			args.put("nickname", nickname);
			args.put("memberImageName", memberImageName);			
		}
		if(gameBoardVO.getDeleted().equals("Y")) {
			gameBoardVO.setGameBoardContent("삭제된 게시글 입니다");
			gameBoardVO.setGameBoardTitle("삭제된 게시글 입니다");
			gameBoardVO.setMemberId("삭제된 게시글 입니다");
			args.put("nickname", "삭제된 게시글 입니다");
		}
		args.put("gameBoardVO", gameBoardVO);
		return args;
	} // end read()

	@Override
	public int update(int gameBoardId, int amount) {
		logger.info("gameBoard updateCommentCnt() 호출");
		return gameBoardDAO.updateCommentCnt(gameBoardId, amount);
	} // end update()

	@Override
	public int getTotalCount(int gameId, PageCriteria criteria, String keywordCriteria, String keyword) {
		logger.info("getTotalCount(keyword) 호출 : keyword = " + keyword);
		return gameBoardDAO.getTotalCounts(gameId, criteria, keywordCriteria, keyword);
	} // end getTotalCount()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria, String orderBy) {
		logger.info("gameBoard read(orderBy)호출");
		List<GameBoardVO> gameBoardVOList = gameBoardDAO.select(gameId, criteria, orderBy);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < gameBoardVOList.size(); i++) {
			if(gameBoardVOList.get(i).getDeleted().equals("Y")) {
				gameBoardVOList.get(i).setGameBoardContent("삭제된 게시글 입니다");
				gameBoardVOList.get(i).setGameBoardTitle("삭제된 게시글 입니다");
				gameBoardVOList.get(i).setMemberId("삭제된 게시글 입니다");
				nicknameList.add("삭제된 게시글 입니다");
			}else {
				nicknameList.add(memberDAO.selectByMemberId(gameBoardVOList.get(i).getMemberId()));
			}
		}
		GameVO gameVO = gameDAO.select(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameBoardVOList", gameBoardVOList);
		args.put("nicknameList",nicknameList);
		args.put("gameVO", gameVO);
		return args;
	} // end read

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria, String keywordCriteria, String keyword,
			String orderBy) {
		logger.info("gameBoard read(keyword, orderBy)호출");
		List<GameBoardVO> gameBoardVOList = null;
		if(keywordCriteria!=null&&keywordCriteria.equals("memberId")) {
			gameBoardVOList = gameBoardDAO.selectByNickname(gameId, keyword, criteria, orderBy);
		}else {
			gameBoardVOList = gameBoardDAO.selectByKeyword(gameId, keyword, criteria, orderBy);
		}
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < gameBoardVOList.size(); i++) {
			if(gameBoardVOList.get(i).getDeleted().equals("Y")) {
				gameBoardVOList.get(i).setGameBoardContent("삭제된 게시글 입니다");
				gameBoardVOList.get(i).setGameBoardTitle("삭제된 게시글 입니다");
				gameBoardVOList.get(i).setMemberId("삭제된 게시글 입니다");
				nicknameList.add("삭제된 게시글 입니다");
			}else {
				if(memberDAO.select(gameBoardVOList.get(i).getMemberId())!=null) {
					nicknameList.add(memberDAO.select(gameBoardVOList.get(i).getMemberId()).getNickname());
				}else {
					nicknameList.add("탈퇴한 회원입니다.");
				}
			}
		}
		GameVO gameVO = gameDAO.select(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameBoardVOList", gameBoardVOList);
		args.put("nicknameList",nicknameList);
		args.put("gameVO", gameVO);
		return args;
	} // end read()

	@Override
	public List<GameBoardVO> readMyBoard(String memberId, PageCriteria criteria) {
		logger.info("gameBoard readMyBoard() 호출 : memberId = "+ memberId);
		List<GameBoardVO> myBoardList = gameBoardDAO.selectByMemberId(memberId, criteria);
		return myBoardList;
	} // end readMyBoard()

	@Override
	public int getCntMyBoard(String memberId) {
		return gameBoardDAO.getCntMyBoard(memberId);
	} // end getCntMyBoard()
	
	
} // end GameBoardServiceImple
