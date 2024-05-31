package com.gdu.academix.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class FolderDto {

  private int folderNo, parentFolderNo;
  private String folderTitle;
  private Timestamp folderCreatedAt;
  private EmployeesDto employee;
	
}
