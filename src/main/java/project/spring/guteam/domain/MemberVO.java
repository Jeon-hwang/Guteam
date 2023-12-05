package project.spring.guteam.domain;

import java.util.Objects;

public class MemberVO {

	String memberId;
	String password;
	String nickname;
	String email;
	String phone;
	int cash;
	String memberImageName;
	String isAdmin;
	String deleted;
	
	public MemberVO() {}

	public MemberVO(String memberId, String password, String nickname, String email, String phone, int cash,
			String memberImageName, String isAdmin, String deleted) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.nickname = nickname;
		this.email = email;
		this.phone = phone;
		this.cash = cash;
		this.memberImageName = memberImageName;
		this.isAdmin = isAdmin;
		this.deleted = deleted;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getCash() {
		return cash;
	}

	public void setCash(int cash) {
		this.cash = cash;
	}

	public String getMemberImageName() {
		return memberImageName;
	}

	public void setMemberImageName(String memberImageName) {
		this.memberImageName = memberImageName;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	@Override
	public String toString() {
		return "MemberVO [memberId=" + memberId + ", password=" + password + ", nickname=" + nickname + ", email="
				+ email + ", phone=" + phone + ", cash=" + cash + ", memberImageName=" + memberImageName + ", isAdmin="
				+ isAdmin + ", deleted=" + deleted + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(cash, deleted, email, isAdmin, memberId, memberImageName, nickname, password, phone);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MemberVO other = (MemberVO) obj;
		return cash == other.cash && Objects.equals(deleted, other.deleted) && Objects.equals(email, other.email)
				&& Objects.equals(isAdmin, other.isAdmin) && Objects.equals(memberId, other.memberId)
				&& Objects.equals(memberImageName, other.memberImageName) && Objects.equals(nickname, other.nickname)
				&& Objects.equals(password, other.password) && Objects.equals(phone, other.phone);
	}
	
}
