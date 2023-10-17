package project.spring.guteam.persistence;

import java.util.List;

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
	public int updateMem(MemberVO vo) {
		logger.info("updateMem() 호출 vo = " + vo.toString() );
		return sqlSession.update(NAMESPACE + ".update_member", vo);
	}
	
	@Override
	public int updateCash(MemberVO vo) {
		logger.info("updateCash() 호출 vo = " + vo.toString());
		return sqlSession.update(NAMESPACE + ".update_cash", vo);
	}

	@Override
	public int delete(String memberId) {
		logger.info("delete() 호출 memberId = " + memberId);
		return sqlSession.delete(NAMESPACE + ".delete", memberId);
	}


}
