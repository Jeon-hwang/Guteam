package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface ReviewService {
	int create(ReviewVO vo);
	List<ReviewVO> read(int gameId, PageCriteria criteria);
	ReviewVO read(int reviewId);
	int update(ReviewVO vo);
	int delete(int reviewId);
	int update(int riviewId, int amount);
	int getTotalCount(int gameId);
	int getRating(int gameId);
	List<ReviewVO> read(int gameId, PageCriteria criteria, String keyword);
	int getTotalCount(int gameId, String keyword);
	int readWrited(int gameId, String memberId);
}
