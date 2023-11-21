package project.spring.guteam.domain;

import java.util.Date;

public class KakaoPayReadyVO {
	private String tid, next_redirect_pc_url;
    private Date created_at;
	public KakaoPayReadyVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public KakaoPayReadyVO(String tid, String next_redirect_pc_url, Date created_at) {
		super();
		this.tid = tid;
		this.next_redirect_pc_url = next_redirect_pc_url;
		this.created_at = created_at;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getNext_redirect_pc_url() {
		return next_redirect_pc_url;
	}
	public void setNext_redirect_pc_url(String next_redirect_pc_url) {
		this.next_redirect_pc_url = next_redirect_pc_url;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	@Override
	public String toString() {
		return "KakaoPayReadyVO [tid=" + tid + ", next_redirect_pc_url=" + next_redirect_pc_url + ", created_at="
				+ created_at + "]";
	}
    
    
}
