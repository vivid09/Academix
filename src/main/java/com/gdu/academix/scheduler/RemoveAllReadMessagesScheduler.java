package com.gdu.academix.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.gdu.academix.service.ChatService;

public class RemoveAllReadMessagesScheduler {
  
  // all_read가 1인 message데이터 삭제

  @Autowired
  private ChatService chatService;
  
  @Scheduled(cron = "0 */10 * * * *") // 매 10분마다 실행
  public void excute() {
    chatService.deleteAlreadyRead();
  }

}
