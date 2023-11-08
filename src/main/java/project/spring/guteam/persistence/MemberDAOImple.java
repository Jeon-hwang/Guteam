package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.MemberVO;

@Repository // @component
public class MemberDAOImple implements MemberDAO {
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImple.class);
	
	public static final String NAMESPACE = "project.spring.guteam.MemberMapper";
	
	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public int insert(MemberVO vo) {
		logger.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public List<MemberVO> select() {
		logger.info("select() 호출");
		return sqlSession.selectList(NAMESPACE + ".select_all");
	}

	@Override
	public MemberVO select(String memberId) {
		logger.info("select() 호출 memberId = " + memberId); 
		return sqlSession.selectOne(NAMESPACE + ".select_by_member_id", memberId);
	}
	
	@Override
	public int checkId(String memberId) {
		logger.info("checkId() 호출 memberId = " + memberId);
		return sqlSession.selectOne(NAMESPACE + ".check_member_id", memberId);
	}

	@Override
	public int checkNickname(String nickname) {
		logger.info("checkNickname() 호출 nickname = " + nickname);
		return sqlSession.selectOne(NAMESPACE + ".check_nickname", nickname);
	}
	
	@Override
	public int updateMem(MemberVO vo) {
		logger.info("updateMem() 호출 vo = " + vo.toString() );
		return sqlSession.update(NAMESPACE + ".update_member", vo);
	}
	
	@Override
	public int updateCash(int cash,String memberId) {
		logger.info("updateCash() 호출 cash, memberId = " + cash + "," + memberId );
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("cash", cash);
		args.put("memberId", memberId);
		return sqlSession.update(NAMESPACE + ".update_cash", args);
	}

	@Override
	public int delete(String memberId) {
		logger.info("delete() 호출 memberId = " + memberId);
		return sqlSession.delete(NAMESPACE + ".delete", memberId);
	}

	@Override
	public String selectByNickname(String nickname) {
		logger.info("nickname 조회");
		return sqlSession.selectOne(NAMESPACE+".select_by_nickname", nickname);
	}

	@Override
	public String selectByMemberId(String memberId) {
		logger.info("memberId 조회");
		return sqlSession.selectOne(NAMESPACE + ".select_by_member_id_to_nick", memberId);
	}

	

	


}
