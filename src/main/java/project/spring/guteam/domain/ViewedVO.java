package project.spring.guteam.domain;

import java.util.Date;

public class ViewedVO {
	private int viewedId;
	private String memberId;
	private int gameId;
	private Date viewedDate;
	public ViewedVO(int viewedId, String memberId, int gameId, Date viewedDate) {
		super();
		this.viewedId = viewedId;
		this.memberId = memberId;
		this.gameId = gameId;
		this.viewedDate = viewedDate;
	}
	public ViewedVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getViewedId() {
		return viewedId;
	}
	public void setViewedId(int viewedId) {
		this.viewedId = viewedId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getGameId() {
		return gameId;
	}
	public void setGameId(int gameId) {
		this.gameId = gameId;
	}
	public Date getViewedDate() {
		return viewedDate;
	}
	public void setViewedDate(Date viewedDate) {
		this.viewedDate = viewedDate;
	}
	@Override
	public String toString() {
		return "ViewedVO [viewedId=" + viewedId + ", memberId=" + memberId + ", gameId=" + gameId + ", viewedDate="
				+ viewedDate + "]";
	}
	
	

}
