package project.spring.guteam.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.MessageVO;

@Repository // @Component
public class MessageDAOImple implements MessageDAO {
	private static final Logger logger = LoggerFactory.getLogger(MessageDAOImple.class);
	
	public static final String NAMESPACE = "project.spring.guteam.MessageMapper";
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int insert(MessageVO vo) {
		logger.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public List<MessageVO> select(String memberId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int delete(int messageId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
