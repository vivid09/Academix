package com.gdu.academix.dto;

import java.security.Principal;

public class CustomPrincipal implements Principal {
  private String employeeNo;
  
  public CustomPrincipal(String employeeNo) {
    this.employeeNo = employeeNo;
  }
  
  @Override
  public String getName() {
    return employeeNo;
  }
  

}
