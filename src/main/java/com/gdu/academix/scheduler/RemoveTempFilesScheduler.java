package com.gdu.academix.scheduler;

import org.springframework.scheduling.annotation.Scheduled;

public class RemoveTempFilesScheduler {

    
  
  @Scheduled(cron="0 28 12 * * ?")
  public void execute() {
    
  }
  
}
