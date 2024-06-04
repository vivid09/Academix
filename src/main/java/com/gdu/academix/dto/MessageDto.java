package com.gdu.academix.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class MessageDto {
  
  public enum MessageType{
    CHAT, JOIN, LEAVE;
  }
  
  private MessageType messageType;
  private int messageNo, isRead, senderNo;
  private int chatroomNo;
  private Timestamp sendDt;
  private String messageContent; 

}