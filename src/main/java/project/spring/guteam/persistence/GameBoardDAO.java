package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameBoardDAO {
	int insert(GameBoardVO vo);
	// 게시글 정보를 입력
	List<GameBoardVO> select(int gameId, PageCriteria criteria);
	// 페이지 정보를 기반으로 게시글들을 조회
	GameBoardVO selectByBoardId(int gameBoardId);
	// 게시글 정보를 조회
	int update(GameBoardVO vo);
	// 게시글 정보 수정
	int getTotalCounts(int gameId);
	// 게시글 총 수( gameId 기준 )를 리턴
	int getTotalCounts(int gameId, PageCriteria criteria, String keywordCriteria, String keyword);
	// 키워드와 페이지 정보를 기준으로 게시글들을 조회
	List<GameBoardVO> selectByNickname(int gameId, String memberId, PageCriteria criteria);
	// 닉네임 정보와 페이지 정보를 기준으로 게시글들을 조회
	List<GameBoardVO> selectByKeyword(int gameId, String keyword, PageCriteria criteria);
	// 키워드와 페이지 저보를 기준으로 게시글들을 조회
	int updateCommentCnt(int gameBoardId, int amount);
	// 게시글 댓글 수를 수정
	int updateDeleted(int gameBoardId);
	// 게시글 정보 수정(삭제처리)
	List<GameBoardVO> select(int gameId, PageCriteria criteria, String orderBy);
	// 정렬과 페이지 기준으로 게시글 정보들을 조회
	List<GameBoardVO> selectByNickname(int gameId, String keyword, PageCriteria criteria, String orderBy);
	// 정렬과 닉네임, 페이지 기준으로 게시글 정보들을 조회
	List<GameBoardVO> selectByKeyword(int gameId, String keyword, PageCriteria criteria, String orderBy);
	// 정렬과 키워드, 페이지 기준으로 게시글 정보들을 조회
	List<GameBoardVO> selectByMemberId(String memberId, PageCriteria criteria);
	// 로그인 정보를 기준으로 본인이 쓴 게시글 정보들을 조회
	int getCntMyBoard(String memberId);
	// 로그인 정보를 기준으로 본인이 쓴 게시글 수를 리턴
}
