package com.gdu.academix.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequestMapping("/studentMng")
@RequiredArgsConstructor
@Controller
public class StudentMngController {

  @GetMapping("/consultingList.page")
  public String consultingList() {
      return "studentMng/consultingList";
  }
  
  @GetMapping("/registerConsulting.page")
  public String registerConsulting() {
	  return "studentMng/registerConsulting";
  }
  
	
}
