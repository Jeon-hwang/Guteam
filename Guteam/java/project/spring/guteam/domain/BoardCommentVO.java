package project.spring.guteam.domain;

import java.util.Date;

public class BoardCommentVO {
	private int commentId;
	private int gameBoardId;
	private String memberId;
	private String commentContent;
	private Date commentDateCreated;
	private int replyCnt;

	public BoardCommentVO() {}

	public BoardCommentVO(int commentId, int gameBoardId, String memberId, String commentContent,
			Date commentDateCreated, int replyCnt) {
		this.commentId = commentId;
		this.gameBoardId = gameBoardId;
		this.memberId = memberId;
		this.commentContent = commentContent;
		this.commentDateCreated = commentDateCreated;
		this.replyCnt = replyCnt;
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public int getGameBoardId() {
		return gameBoardId;
	}

	public void setGameBoardId(int gameBoardId) {
		this.gameBoardId = gameBoardId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public Date getCommentDateCreated() {
		return commentDateCreated;
	}

	public void setCommentDateCreated(Date commentDateCreated) {
		this.commentDateCreated = commentDateCreated;
	}

	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	@Override
	public String toString() {
		return "BoardCommentVO [commentId=" + commentId + ", gameBoardId=" + gameBoardId + ", memberId=" + memberId
				+ ", commentContent=" + commentContent + ", commentDateCreated=" + commentDateCreated + ", replyCnt="
				+ replyCnt + "]";
	}
	
	
	
	
	
}
