package project.spring.guteam.service;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface ReviewService {
	int create(ReviewVO vo, Principal principal);
	// 리뷰 생성
	Map<String, Object> read(int gameId, PageCriteria criteria);
	// 페이지 정보를 기준으로 리뷰 정보들을 조회(gameId)
	Map<String, Object> read(int reviewId, String memberId);
	// 리뷰 정보를 조회(로그인 정보가 있으면 추천했는지 여부도 함께 조회)
	int update(ReviewVO vo, Principal principal);
	// 리뷰 정보 수정
	int delete(int reviewId, Principal principal);
	// 리뷰 삭제
	int update(int riviewId, int amount);
	// 리뷰의 추천 수를 수정
	int getTotalCount(int gameId);
	// 리뷰의 총 수(gameId) 를 리턴
	int getRating(int gameId);
	// 게임의 평균 평점을 리턴
	Map<String, Object> read(int gameId, PageCriteria criteria, String keyword);
	// 키워드와 페이지 기준으로 리뷰 정보들을 조회
	int getTotalCount(int gameId, String keyword);
	// 키워드 기준으로 총 리뷰수(gameId) 를 리턴
	int readWrited(int gameId, String memberId);
	// 로그인 정보를 바탕으로 해당 game 에 리뷰를 작성했는지 reviewId를 리턴(작성하지 않으면 0 리턴)
	Map<String, Object> read(String orderBy, PageCriteria criteria, String keyword, int gameId);
	// 키워드와 페이지, 정렬 기준으로 리뷰정보들을 조회
	Map<String, Object> read(String orderBy, int gameId, PageCriteria criteria);
	// 정렬과 페이지 기준으로 리뷰 정보들을 조회
	List<ReviewVO> readMyReview(String memberId, PageCriteria criteria);
	// 로그인 정보로 내가 쓴 리뷰 정보들을 조회
	int getCntMyReview(String memberId);
	// 로그인 정보로 내가 쓴 리뷰의 수를 리턴
	int isPurchased(int gameId, String name);
	// 로그인 정보로 구매한 게임인지 확인하여 리턴(구매하였으면 1 아니면 0 )
}
