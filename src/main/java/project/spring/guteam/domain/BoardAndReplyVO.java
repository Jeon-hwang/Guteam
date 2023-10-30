package project.spring.guteam.domain;

import java.util.Date;

public class BoardAndReplyVO {
	private String nickname;
	private int boardId;
	private int gameId;
	private String content;
	private Date createdDate;
	
	
	
	public BoardAndReplyVO() {}

	public BoardAndReplyVO(String nickname, int boradId,int gameId, String content, Date createdDate) {
		super();
		this.nickname = nickname;
		this.boardId = boradId;
		this.gameId= gameId;
		this.content = content;
		this.createdDate = createdDate;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	
	public int getGameId() {
		return gameId;
	}

	public void setgameId(int gameId) {
		this.gameId = gameId;
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
