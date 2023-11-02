package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.ViewedVO;

public interface ViewedDAO {
	int insert(ViewedVO vo);
	List<ViewedVO> select(String memberId);
	int update(ViewedVO vo);
	ViewedVO selectRecently(String memberId, int gameId);
	int delete(int viewedId);
}
