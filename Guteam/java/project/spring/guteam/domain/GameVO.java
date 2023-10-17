package project.spring.guteam.domain;

import java.util.Date;

public class GameVO {
	private int gameId;
	private String gameName;
	private int price;
	private String genre;
	private Date releaseDate;
	private Date updateDate; 
	private String gameImageName;
	
	public GameVO() {}
	public GameVO(int gameId, String gameName, int price, String genre, Date releaseDate, Date updateDate,
			String gameImageName) {
		this.gameId = gameId;
		this.gameName = gameName;
		this.price = price;
		this.genre = genre;
		this.releaseDate = releaseDate;
		this.updateDate = updateDate;
		this.gameImageName = gameImageName;
	}
	public int getGameId() {
		return gameId;
	}
	public void setGameId(int gameId) {
		this.gameId = gameId;
	}
	public String getGameName() {
		return gameName;
	}
	public void setGameName(String gameName) {
		this.gameName = gameName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public Date getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getGameImageName() {
		return gameImageName;
	}
	public void setGameImageName(String gameImageName) {
		this.gameImageName = gameImageName;
	}
	@Override
	public String toString() {
		return "GameVO [gameId=" + gameId + ", gameName=" + gameName + ", price=" + price + ", genre=" + genre
				+ ", releaseDate=" + releaseDate + ", updateDate=" + updateDate + ", gameImageName=" + gameImageName
				+ "]";
	}
	
	
}