package com.gdu.academix.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.gdu.academix.service.UploadService;

public class RemoveTempFilesScheduler {

  @Autowired	
  private UploadService uploadService;   
  
  @Scheduled(cron="0 28 12 * * ?")
  public void execute() {
    uploadService.removeTempFiles();
  }
  
}
