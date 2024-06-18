package com.gdu.academix.dto;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

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
    CHAT, JOIN, LEAVE, UPDATE, UPDATE_READ_STATUS;
  }
  
  private MessageType messageType;
  private int messageNo, senderNo;
  private int chatroomNo;
  private Timestamp sendDt;
  private String messageContent; 
  private List<Integer> recipientNoList;

}