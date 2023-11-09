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
	public int create(GameBoardVO vo) {
		logger.info("gameBoard create() 호출 : vo = " + vo);
		return gameBoardDAO.insert(vo);
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria) {
		logger.info("gameBoard read() 호출 : gameId = " + gameId);
		List<GameBoardVO> gameBoardVOList = gameBoardDAO.select(gameId, criteria);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < gameBoardVOList.size(); i++) {
			nicknameList.add(memberDAO.select(gameBoardVOList.get(i).getMemberId()).getNickname());
		}
		GameVO gameVO = gameDAO.select(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameBoardVOList", gameBoardVOList);
		args.put("nicknameList",nicknameList);
		args.put("gameVO", gameVO);
		return args;
	}

	@Override
	public int update(GameBoardVO vo) {
		logger.info("gameBoard update() 호출 : vo = " + vo );
		return gameBoardDAO.update(vo);
	}

	@Override
	public int update(int gameBoardId) {
		logger.info("gameBoard update(gameBoardId) 호출 : gameBoardId = " + gameBoardId);
		return gameBoardDAO.updateDeleted(gameBoardId);
	}

	@Override
	public int getTotalCount(int gameId) {
		logger.info("gameBoard getTotalCount() 호출 ");
		return gameBoardDAO.getTotalCounts(gameId);
	}

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
			nicknameList.add(memberDAO.select(gameBoardVOList.get(i).getMemberId()).getNickname());
		}
		GameVO gameVO = gameDAO.select(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameBoardVOList", gameBoardVOList);
		args.put("nicknameList",nicknameList);
		args.put("gameVO", gameVO);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameBoardId, String memberId) {
		logger.info("gameBoard read(gameBoardId) 호출 : gameBoardId = " + gameBoardId);
		GameBoardVO gameBoardVO = gameBoardDAO.selectByBoardId(gameBoardId);
		String nickname = memberDAO.select(gameBoardVO.getMemberId()).getNickname();
		Map<String, Object> args = new HashMap<>();
		if(memberId!=null&&!memberId.equals("")) {
			String memberImageName= memberDAO.select(memberId).getMemberImageName();
			args.put("memberImageName", memberImageName);			
		}
		args.put("gameBoardVO", gameBoardVO);
		args.put("nickname", nickname);
		return args;
	}

	@Override
	public int update(int gameBoardId, int amount) {
		logger.info("gameBoard updateCommentCnt() 호출");
		return gameBoardDAO.updateCommentCnt(gameBoardId, amount);
	}

	@Override
	public int getTotalCount(int gameId, PageCriteria criteria, String keywordCriteria, String keyword) {
		logger.info("getTotalCount(keyword) 호출 : keyword = " + keyword);
		return gameBoardDAO.getTotalCounts(gameId, criteria, keywordCriteria, keyword);
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria, String orderBy) {
		logger.info("gameBoard read(orderBy)호출");
		List<GameBoardVO> gameBoardVOList = gameBoardDAO.select(gameId, criteria, orderBy);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < gameBoardVOList.size(); i++) {
			nicknameList.add(memberDAO.select(gameBoardVOList.get(i).getMemberId()).getNickname());
		}
		GameVO gameVO = gameDAO.select(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameBoardVOList", gameBoardVOList);
		args.put("nicknameList",nicknameList);
		args.put("gameVO", gameVO);
		return args;
	}

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
			nicknameList.add(memberDAO.select(gameBoardVOList.get(i).getMemberId()).getNickname());
		}
		GameVO gameVO = gameDAO.select(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameBoardVOList", gameBoardVOList);
		args.put("nicknameList",nicknameList);
		args.put("gameVO", gameVO);
		return args;
	}

	@Override
	public List<GameBoardVO> readMyBoard(String memberId, PageCriteria criteria) {
		logger.info("gameBoard readMyBoard() 호출 : memberId = "+ memberId);
		List<GameBoardVO> myBoardList = gameBoardDAO.selectByMemberId(memberId, criteria);
		return myBoardList;
	}

	@Override
	public int getCntMyBoard(String memberId) {
		return gameBoardDAO.getCntMyBoard(memberId);
	}
	
	
}
