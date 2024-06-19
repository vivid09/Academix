package com.gdu.academix.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.gdu.academix.service.HrService;

public class AnnualLeavesScheduler {

	@Autowired
	private HrService hrService;

  @Scheduled(cron = "0 * * * * *")
  public void annualLeave() {
	
    //hrService.grantAnnualLeave();
	
	
  }

}
