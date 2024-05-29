package com.gdu.academix.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MvcController {

  @GetMapping("/")
  public String welcome() {
    return "user/signin";
  }
  
  @GetMapping("/main.page")
  public String welcomeMain() {
    return "index";
  }

}
