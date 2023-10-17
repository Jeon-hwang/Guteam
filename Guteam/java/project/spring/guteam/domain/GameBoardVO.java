package project.spring.guteam.domain;

import java.util.Date;

public class GameBoardVO {
	private int gameBoardId;
	private int gameId;
	private String memberId;
	private String gameBoardTitle;
	private String gameBoardContent;
	private Date gameBoardDateCreated;
	private int commentCnt;
	
	public GameBoardVO() {}
	public GameBoardVO(int gameBoardId, int gameId, String memberId, String gameBoardTitle, String gameBoardContent,
			Date gameBoardDateCreated, int commentCnt) {
		this.gameBoardId = gameBoardId;
		this.gameId = gameId;
		this.memberId = memberId;
		this.gameBoardTitle = gameBoardTitle;
		this.gameBoardContent = gameBoardContent;
		this.gameBoardDateCreated = gameBoardDateCreated;
		this.commentCnt = commentCnt;
	}
	
	public int getGameBoardId() {
		return gameBoardId;
	}
	public void setGameBoardId(int gameBoardId) {
		this.gameBoardId = gameBoardId;
	}
	public int getGameId() {
		return gameId;
	}
	public void setGameId(int gameId) {
		this.gameId = gameId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getGameBoardTitle() {
		return gameBoardTitle;
	}
	public void setGameBoardTitle(String gameBoardTitle) {
		this.gameBoardTitle = gameBoardTitle;
	}
	public String getGameBoardContent() {
		return gameBoardContent;
	}
	public void setGameBoardContent(String gameBoardContent) {
		this.gameBoardContent = gameBoardContent;
	}
	public Date getGameBoardDateCreated() {
		return gameBoardDateCreated;
	}
	public void setGameBoardDateCreated(Date gameBoardDateCreated) {
		this.gameBoardDateCreated = gameBoardDateCreated;
	}
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	@Override
	public String toString() {
		return "GameBoardVO [gameBoardId=" + gameBoardId + ", gameId=" + gameId + ", memberId=" + memberId
				+ ", gameBoardTitle=" + gameBoardTitle + ", gameBoardContent=" + gameBoardContent
				+ ", gameBoardDateCreated=" + gameBoardDateCreated + ", commentCnt=" + commentCnt + "]";
	}
	
	

}
