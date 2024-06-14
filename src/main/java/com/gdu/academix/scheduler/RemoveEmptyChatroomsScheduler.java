package com.gdu.academix.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.gdu.academix.service.ChatService;

public class RemoveEmptyChatroomsScheduler {
  
  // participants 행의 개수가 0인 chatroom데이터 삭제
  
  @Autowired
  private ChatService chatService;
  
  @Scheduled(cron = "0 */10 * * * *") // 매 10분마다 실행
  public void excute() {
    chatService.deleteNoParticipateChatroom();
  }

}
