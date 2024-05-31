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
public class FolderAttachDto {
	
  private int folderAttachNo, folderNo, ownerNo;
  private String uploadPath, filesystemName, originalFilename;
  private Timestamp uploadDate;
  
}
