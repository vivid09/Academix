package com.gdu.academix.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gdu.academix .service.BlogService;

import lombok.RequiredArgsConstructor;

public class RemoveBlogImageScheduler {
  
  // 저장된 블로그 이미지 중 데이터베이스에 저장되지 않은 이미지 삭제하기(어제 폴더 공략)

  @Autowired	
  private  BlogService blogService;
  
  @Scheduled(cron="0 0 1 * * ?")  // 매일 새벽 1시에 동작
  public void execute() {
    blogService.removeBlogImageNotOnTheTable();
  }
  
}
