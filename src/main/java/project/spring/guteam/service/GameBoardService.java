package project.spring.guteam.service;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameBoardService {
	int create(GameBoardVO vo, Principal principal);
	// 게시글 정보 입력
	Map<String, Object> read(int gameId, PageCriteria criteria);
	// gameId로 해당 게임의 게시글들을 페이지 정보를 기준으로 조회
	Map<String, Object> read(int gameBoardId, String memberId);
	// gameBoardId 로 글 정보를 가져오고, memberId 로 댓글에 사용될 회원 정보를 가져옴
	int update(GameBoardVO vo, Principal principal);
	// 게시글 정보 수정
	int updateToDeleted(int gameBoardId, Principal principal);
	// 게시글 정보 수정(삭제처리)
	int getTotalCount(int gameId);
	// 게시글 총 수를 리턴(gameId)
	int getTotalCount(int gameId, PageCriteria criteria, String keywordCriteria, String keyword);
	// 키워드를 기준으로 조회하여 게시글 수를 리턴
	Map<String, Object> read(int gameId, PageCriteria criteria, String keywordCriteria, String keyword);
	// 키워드와 페이지 정보를 기준으로 게시글 정보들을 조회
	int update(int gameBoardId, int amount);
	// 게시글의 댓글 수를 변경
	Map<String, Object> read(int gameId, PageCriteria criteria, String orderBy);
	// 게시글 정보들을 정렬 기준과 페이지 기준으로 조회
	Map<String, Object> read(int gameId, PageCriteria criteria, String keywordCriteria, String keyword, String orderBy);
	// 게시글 정보들을 키워드와 정렬 및 페이지 기준으로 조회 
	List<GameBoardVO> readMyBoard(String memberId, PageCriteria criteria);
	// 내가 쓴 게시글들을 조회
	int getCntMyBoard(String memberId);
	// 내가 쓴 글의 수를 리턴
}