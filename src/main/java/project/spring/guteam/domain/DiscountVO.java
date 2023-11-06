package project.spring.guteam.domain;

public class DiscountVO {
	private String genre;
	private float discountRate;
	public DiscountVO(String genre, float discountRate) {
		super();
		this.genre = genre;
		this.discountRate = discountRate;
	}
	public DiscountVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public float getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(float discountRate) {
		this.discountRate = discountRate;
	}
	@Override
	public String toString() {
		return "DiscountVO [genre=" + genre + ", discountRate=" + discountRate + "]";
	}
	
	

}
