package project.spring.guteam.domain;

import java.util.Date;

public class MessageReceiveVO {
	int receiveMessageId;
	String receiveMemberId;
	String sendMemberId;
	String sendMemberNickname;
	String messageTitle;
	String messageContent;
	Date messageDateCreated;
	String messageBox;
	
	public MessageReceiveVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MessageReceiveVO(int receiveMessageId, String receiveMemberId, String sendMemberId,
			String sendMemberNickname, String messageTitle, String messageContent, Date messageDateCreated,
			String messageBox) {
		super();
		this.receiveMessageId = receiveMessageId;
		this.receiveMemberId = receiveMemberId;
		this.sendMemberId = sendMemberId;
		this.sendMemberNickname = sendMemberNickname;
		this.messageTitle = messageTitle;
		this.messageContent = messageContent;
		this.messageDateCreated = messageDateCreated;
		this.messageBox = messageBox;
	}

	public int getReceiveMessageId() {
		return receiveMessageId;
	}

	public void setReceiveMessageId(int receiveMessageId) {
		this.receiveMessageId = receiveMessageId;
	}

	public String getReceiveMemberId() {
		return receiveMemberId;
	}

	public void setReceiveMemberId(String receiveMemberId) {
		this.receiveMemberId = receiveMemberId;
	}

	public String getSendMemberId() {
		return sendMemberId;
	}

	public void setSendMemberId(String sendMemberId) {
		this.sendMemberId = sendMemberId;
	}

	public String getSendMemberNickname() {
		return sendMemberNickname;
	}

	public void setSendMemberNickname(String sendMemberNickname) {
		this.sendMemberNickname = sendMemberNickname;
	}

	public String getMessageTitle() {
		return messageTitle;
	}

	public void setMessageTitle(String messageTitle) {
		this.messageTitle = messageTitle;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public Date getMessageDateCreated() {
		return messageDateCreated;
	}

	public void setMessageDateCreated(Date messageDateCreated) {
		this.messageDateCreated = messageDateCreated;
	}

	public String getMessageBox() {
		return messageBox;
	}

	public void setMessageBox(String messageBox) {
		this.messageBox = messageBox;
	}

	@Override
	public String toString() {
		return "MessageReceiveVO [receiveMessageId=" + receiveMessageId + ", receiveMemberId=" + receiveMemberId
				+ ", sendMemberId=" + sendMemberId + ", sendMemberNickname=" + sendMemberNickname + ", messageTitle="
				+ messageTitle + ", messageContent=" + messageContent + ", messageDateCreated=" + messageDateCreated
				+ ", messageBox=" + messageBox + "]";
	}
	
	
}