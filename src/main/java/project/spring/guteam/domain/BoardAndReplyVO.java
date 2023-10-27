package project.spring.guteam.domain;

import java.util.Date;

public class BoardAndReplyVO {
	private String nickname;
	private int boradId;
	private String content;
	private Date createdDate;
	
	
	
	public BoardAndReplyVO() {}

	public BoardAndReplyVO(String nickname, int boradId, String content, Date createdDate) {
		super();
		this.nickname = nickname;
		this.boradId = boradId;
		this.content = content;
		this.createdDate = createdDate;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getBoradId() {
		return boradId;
	}

	public void setBoradId(int boradId) {
		this.boradId = boradId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
	
}
