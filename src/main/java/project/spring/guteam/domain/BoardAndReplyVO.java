package project.spring.guteam.domain;

import java.util.Date;

public class BoardAndReplyVO {
	private int boardId;
	private int gameId;
	private String content;
	private Date createdDate;
	
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public int getGameId() {
		return gameId;
	}
	public void setGameId(int gameId) {
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
	public BoardAndReplyVO(int boardId, int gameId, String content, Date createdDate) {
		this.boardId = boardId;
		this.gameId = gameId;
		this.content = content;
		this.createdDate = createdDate;
	}
	public BoardAndReplyVO() {}
	
	
}
