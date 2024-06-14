package com.gdu.academix.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequestMapping("/mail")
@RequiredArgsConstructor
@Controller
public class MailController {

  @GetMapping("/inbox.page")
  public String inbox() {
    return "mail/inbox";
  }
	
  @GetMapping("/compose.page")
  public String composeMail() {
    return "mail/compose";
  }
	
  @GetMapping("/sentMailbox.page")
  public String sentMailbox() {
    return "mail/sentMailbox";
  }
	
	
}
