package project.spring.guteam.domain;

import java.util.Date;

public class ReplyVO {
	int replyId;
	int commentId;
	String memberId;
	String replyContent;
	Date replyDateCreated;
	
	public ReplyVO() {}
	
	public ReplyVO(int replyId, int commentId, String memberId, String replyContent, Date replyDateCreated) {
		super();
		this.replyId = replyId;
		this.commentId = commentId;
		this.memberId = memberId;
		this.replyContent = replyContent;
		this.replyDateCreated = replyDateCreated;
	}
	
	public int getReplyId() {
		return replyId;
	}
	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getReplyDateCreated() {
		return replyDateCreated;
	}
	public void setReplyDateCreated(Date replyDateCreated) {
		this.replyDateCreated = replyDateCreated;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [replyId=" + replyId + ", commentId=" + commentId + ", memberId=" + memberId + ", replyContent="
				+ replyContent + ", replyDateCreated=" + replyDateCreated + "]";
	}
	
}
