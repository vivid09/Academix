package com.gdu.academix.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;


@RequestMapping("/drive")
@RequiredArgsConstructor
@Controller
public class FolderController {
	
  @GetMapping("/myDrive.page")
  public String myDrive() {
      return "drive/myDrive";
  }
  

}
