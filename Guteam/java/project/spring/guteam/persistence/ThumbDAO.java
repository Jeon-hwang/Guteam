package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.ThumbVO;

public interface ThumbDAO {
	int insert(ThumbVO vo);
	List<Integer> select(String memberId, int upDown);
	int delete(ThumbVO vo);
	int update(ThumbVO vo);
}
